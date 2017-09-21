//
//  SWPointPathManage.swift
//  SWCampus
//
//  Created by 11111 on 2017/9/19.
//  Copyright © 2017年 WanHang. All rights reserved.
//

import UIKit
import CoreLocation

class SWPointPathManage: NSObject {
    static let shareInstance = SWPointPathManage.init()
    override init() {
        
    }
    
    
    /// 穷举路径
    ///
    /// - Parameters:
    ///   - points: 点位集合
    ///   - queueMemberCount: 路径点位个数要求
    ///   - minLength: 最低里程
    /// - Returns: 穷举结果
    func exhaustionAllSatisfedPath(_ points : Array<PointModel>,queueMemberCount : NSInteger,minLength : NSInteger) -> PointSequenceResult {
        
        let result = PointSequenceResult.init()

        //异常处理
        if let error = pointsCheck(points) {
            result.error = error
            return result
        }
        
        //获取必经点的id
        let pointIds = points.map{
            ($0.pointId,$0.pointIsFixed)
        }
        let fixedPointId = pointIds.filter{
            $0.1 == "1"
        }.first!.0!
        
        //所有路径
        let allPaths = createPathsWith(points: points, paths: [PathModel]())
        
        //仅包含必经点的路径
        let fixedPaths = allPaths.filter{
            $0.pathPoints!.0 == NSInteger.init(fixedPointId)! || $0.pathPoints!.1 == NSInteger.init(fixedPointId)!
        }
        //不包含必经点的路径
        let unFixedPaths = allPaths.filter{
            $0.pathPoints!.0 != NSInteger.init(fixedPointId)! && $0.pathPoints!.1 != NSInteger.init(fixedPointId)!
        }
        
        //路径分类
        var pathsContainUnFixedPoint = [Array<PathModel>]()
        for pathModel in fixedPaths {
            let oppositePointId = pathModel.pathPoints!.0 == NSInteger.init(fixedPointId)! ? pathModel.pathPoints!.1 : pathModel.pathPoints!.0
            let oppositePaths = unFixedPaths.filter({
                $0.pathPoints!.0 == oppositePointId || $0.pathPoints!.1 == oppositePointId
            })
            pathsContainUnFixedPoint.append(oppositePaths)
        }
        //穷举,时间太长，待优化
        printWithTime("穷举开始")
        var pathsCanConnect = [Array<PathModel>]()
        for outIndex in 0..<4 {
            var newfixedPaths = fixedPaths
            newfixedPaths.remove(at: outIndex)
            pathsContainUnFixedPoint.append(newfixedPaths)
            
            let combinedPaths = createPathCombine(queueMemberCount, pathsContainUnFixedPoint)
            
            for group in combinedPaths {
                var originalPaths = [[fixedPaths[outIndex]]]
                
                for paths in group {
                    let result = originalPaths.flatMap({ fixedPath in
                        paths.map({ path in
                            (fixedPath,path)
                        })
                    })
                    
                    originalPaths = result.map({ pair -> [PathModel] in
                        var mutalbePath = pair.0
                        mutalbePath.append(pair.1)
                        return mutalbePath
                    })
                    
                    
                }
                let a = originalPaths.filter{
                    pathCombineAvailable($0)
                }
                
                for inerpaths in a {
                    let result = pathsCanConnect.contains(where: {
                        isPaths(lhs: $0, equalTo: inerpaths)
                    })
                    if !result {
                        pathsCanConnect.append(inerpaths)
                    }
                }
            }
            
        }
        
        let minLengthFilterReult = pathsCanConnect.filter{
            isPathsSubGreaterThan(minLenght: minLength, paths: $0)
        }
        printWithTime("穷举结束")

        //穷举结果处理，随机选取一条路径
        if minLengthFilterReult.count == 0 {
            result.error = .pointNoOneSatisfy
            return result
        }
        
        let count = UInt32.init(minLengthFilterReult.count)
        let index = Int.init(arc4random()%count)
        let randomPaths = minLengthFilterReult[index]
        
        //路径模型转换为点位模型
        let finalPointIds = changePathIntoPoint(paths: randomPaths)
        let chosenPoints = points.filter{
            finalPointIds.contains(Int.init($0.pointId)!)
        }
        var unChosenPoints = points.filter{
            !finalPointIds.contains(Int.init($0.pointId)!)
        }
        
        for model in chosenPoints {
            model.pointSequence = String.init(format: "%d", finalPointIds.index(of: Int.init(model.pointId)!)! + 1)
        }
        
        unChosenPoints.append(contentsOf: chosenPoints)
        result.result = unChosenPoints
        return result
    }
    
    fileprivate func pointsCheck(_ points : Array<PointModel>) -> PointSequenceResultError? {
        
        let result : PointSequenceResultError? = nil
        if points.count != 5 {
            return .pointsCountNotEqualFive
        }
        
        let exitArr = points.filter { model in
            Int.init(model.pointIsFixed)! > 0
        }
        if exitArr.count < 1 {
            return .pointsWithoutFixedPoint
        }
        
        let unavailableArr = points.filter { model in
            Int.init(model.pointFlag)! == 0
        }
        if unavailableArr.count > 0 {
            return .pointsWithUnavailableFlag
        }
        
        return result
    }
    
    fileprivate func changePathIntoPoint(paths : Array<PathModel>) -> Array<NSInteger>{
        
        var finalPointIds = [NSInteger]()
        
        //获取路径点位集合
        let pointPairs = paths.map{
            $0.pathPoints!
        }
        
        var pointIds = [NSInteger]()
        for pair in pointPairs {
            pointIds.append(pair.0)
            pointIds.append(pair.1)
        }
        
        //获取第一个点
        var newPointIds = pointIds
        var firstPointId : NSInteger!
        
        for index in 0..<pointIds.count {
            newPointIds.remove(at: index)
            if !newPointIds.contains(pointIds[index]) {
                firstPointId = pointIds[index]
                break
            }
            newPointIds = pointIds
        }
        finalPointIds.append(firstPointId)
        
        //获取剩下的点
        let firstPair = pointPairs.filter{
            $0.0 == firstPointId || $0.1 == firstPointId
            }.first!
        firstPair.0 == firstPointId ? finalPointIds.append(firstPair.1) : finalPointIds.append(firstPair.0)
        
        for index in 0..<pointPairs.count - 1 {
            let secondPair = pointPairs.filter{
                ($0.0 != finalPointIds[index] && $0.1 != finalPointIds[index]) && ($0.0 == finalPointIds[index + 1] || $0.1 == finalPointIds[index + 1])
                }.first!
            secondPair.0 == finalPointIds[index + 1] ? finalPointIds.append(secondPair.1) : finalPointIds.append(secondPair.0)
        }
        
        return finalPointIds
    }
    
}

extension SWPointPathManage{
    
    /// 通过点位数组生成路径数组
    ///
    /// - Parameters:
    ///   - points: 点位数组
    ///   - paths: 路径数组
    /// - Returns: 路径数组
    func createPathsWith(points : Array<PointModel>,paths : Array<PathModel>) -> Array<PathModel> {
        
        if points.count == 1 {
            return paths
        }
        
        var newPoints = points
        var newPaths = paths
        
        let firstPoint = points.first
        newPoints.remove(at: 0)
        let changedPaths = newPoints.map { [weak self] (point) in
            self?.distanceBetween(point1: point, to: firstPoint!)
        }
        for model in changedPaths {
            newPaths.append(model!)
        }
        return createPathsWith(points: newPoints,paths: newPaths)
    }
    
    /// 计算两点之间距离并生成路径模型
    ///
    /// - Parameters:
    ///   - point1: 点位1
    ///   - point2: 点位2
    /// - Returns: 路径模型
    func distanceBetween(point1 : PointModel, to point2 : PointModel) -> PathModel {
        let id1 : NSInteger! = NSInteger.init(point1.pointId)
        let id2 : NSInteger! = NSInteger.init(point2.pointId)
        
        var model = PathModel.init()
        let location1 = CLLocation.init(latitude: Double.init(point1.pointLat)!, longitude: Double.init(point1.pointLon)!)
        let location2 = CLLocation.init(latitude: Double.init(point2.pointLat)!, longitude: Double.init(point2.pointLon)!)

        model.pathLength = location1.distance(from: location2)
        model.pathPoints = (id1,id2)
        return model
    }
    
    /// 路径集合的总长是否超过最低里程
    ///
    /// - Parameters:
    ///   - minLenght: 最低里程
    ///   - paths: 路径集合
    /// - Returns: 是否超过
    func isPathsSubGreaterThan(minLenght : NSInteger,paths : Array<PathModel>) -> Bool {
        let lengthSub = paths.reduce(0) { (total, path) -> Double in
            total + path.pathLength
        }
//        print("length = \(lengthSub)")
        return lengthSub > Double.init(minLenght)
    }
    
    /// 路径集合是否有效，即能够组成一条连续的路径
    ///
    /// - Parameter paths: 路经集合
    /// - Returns: 是否有效
    func pathCombineAvailable(_ paths : Array<PathModel>) -> Bool {
        let pointIdPairs = paths.map{
            ($0.pathPoints!.0,$0.pathPoints!.1)
        }
        //1.
        var newpointIdPairs = [(NSInteger,NSInteger)]()
        for pair in pointIdPairs {
            if !newpointIdPairs.contains(where: {$0 == pair}) {
                newpointIdPairs.append(pair)
            }
        }
        if newpointIdPairs.count != pointIdPairs.count {
            return false
        }
        //2.
        if pointIdPairs.count > 2 {
            for index in 0..<pointIdPairs.count {
                var new = pointIdPairs
                new.remove(at: index)
                let a = pointIdPairs[index]
                
                let newSett = Set.init(changePairsToArray(pairs: new))
                if !newSett.contains(a.0) && !newSett.contains(a.1) {
                    return false
                }
            }
        }
        
        
        var pointIds = [NSInteger]()
        for pair in pointIdPairs {
            pointIds.append(pair.0)
            pointIds.append(pair.1)
        }
        let pointIdSet = Set.init(pointIds)
        var newPointIds = pointIds
        for item in pointIdSet {
            newPointIds.remove(at: newPointIds.index(of: item)!)
        }
        let resideSet = Set.init(newPointIds)
        
        return pointIdSet.count == paths.count + 1 && resideSet.count == newPointIds.count
        
    }
    
    func changePairsToArray(pairs : [(NSInteger,NSInteger)]) -> [NSInteger] {
        var pointIds = [NSInteger]()
        for pair in pairs {
            pointIds.append(pair.0)
            pointIds.append(pair.1)
        }
        return pointIds
    }
    
    /// 两个路经集合是否相等
    ///
    /// - Parameters:
    ///   - lhs: 路经集合1
    ///   - rhs: 路径集合2
    /// - Returns: 是否相等
    func isPaths(lhs : Array<PathModel>,equalTo rhs : Array<PathModel>) -> Bool {
        
        var afterPaths = [PathModel]()
        
        if lhs.count == rhs.count {
            for lModel in lhs {
                let filterResult = rhs.filter{
                    ($0.pathPoints!.0 == lModel.pathPoints!.0) && ($0.pathPoints!.1 == lModel.pathPoints!.1)
                }
                afterPaths.append(contentsOf: filterResult)
            }
            if afterPaths.count == lhs.count {
                return true
            }
            return false
        }
        return false
        
    }
    
    func createPathCombine(_ queueMemberCount : NSInteger, _ paths : Array<Array<PathModel>>) -> Array<Array<Array<PathModel>>> {
        
        let shouldGetCount = queueMemberCount - 2
        var resultArray = [Array<Array<PathModel>>]()
        let randomQueue = [(1,2),(1,3),(1,4),(1,5),(2,3),(2,4),(2,5),(3,4),(3,5),(4,5),]
        let newRandomQueue = [(1,2,3),(1,2,4),(1,2,5),(1,3,4),(1,3,5),(1,4,5),(2,3,4),(2,3,5),(2,4,5),(3,4,5),]
        switch shouldGetCount {
        case 1:
            
            resultArray = paths.map{
                [$0]
            }
            
            break
        case 2:
            
            resultArray = randomQueue.map{
                [paths[$0.0 - 1],paths[$0.1 - 1]]
            }
            
            break
        case 3:
            
            resultArray = newRandomQueue.map{
                [paths[$0.0 - 1],paths[$0.1 - 1],paths[$0.2 - 1]]
            }
            
            break
        default:
            break
        }
        return resultArray
        
    }
}

//MARK: -
class PointModel: NSObject {
    var pointFlag : String! = "0"       //点位所属跑步标识符
    var pointIsPass : String! = "0"     //点位是否经过，boolvalue
    var pointLat : String! = "0"        //点位纬度
    var pointLon : String! = "0"        //点位经度
    var pointIsFixed : String! = "0"    //点位是否必经点,boolvalue
    var pointSequence : String! = "-1"  //点位序列,未参与排序为-1
    var pointId : String! = "-1"        //点位ID
    
}

struct PathModel {
    var pathLength : Double! = 0                        //两点之间的路径长度
    var pathPoints : (NSInteger,NSInteger)! = (-1,-1)   //路径的两个点ID
    
}

//MARK: -
class PointSequenceResult: NSObject {
    var error : PointSequenceResultError? = nil
    var result : Array<PointModel>! = Array.init()
    
}

//MARK: -
enum PointSequenceResultError: Error {
    case pointsCountNotEqualFive    //点位个数不为5
    case pointsWithoutFixedPoint    //没有必经点
    case pointsWithUnavailableFlag  //点位标识符为0
    case pointNoOneSatisfy          //没有符合规则的点位集合
    
}

extension PointSequenceResultError : CustomNSError{
    static let errorDomain = "pointSequenceResultError"
    var errorCode : Int {
        switch self {
        case .pointsCountNotEqualFive:
            return 100
        case .pointsWithoutFixedPoint:
            return 101
        case .pointsWithUnavailableFlag:
            return 102
        case .pointNoOneSatisfy:
            return 103
        }
    }
    var errorUserInfo : [String : Any]{
        return [:]
    }
    
}
