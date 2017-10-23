//
//  SwiftLab.swift
//  JSCallOC
//
//  Created by 11111 on 2017/9/13.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit
import Messages

import RxSwift
import RxCocoa

class SwiftLab: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        self.view.backgroundColor = ColorMethodho(hexValue: 0xffffff)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(changeModel))
        self.view.addGestureRecognizer(tap)
        
        self.view.addSubview(textLabel)
    }
    
    var outterName : Variable<String>!
    var model : infoModel!
    var dis : Disposable?
    let disbage = DisposeBag.init()
    var tapCount : NSInteger! = 0
    
    lazy var textLabel: UILabel = {
        let inner = UILabel.init(frame: CGRect.init(x: 0, y: 100, width: ScreenWidth, height: 50))
        return inner
    }()
    func initData() {
//        performenceCompare()
//        testCombine()
//        testCodable()
//        calculatePointPath()
        
        let before = [1,2,3,4]
        let after = [NSInteger]()
        let resullt = createRandom(number: before.count, before: before, after: after)
        printWithTime("newBefore = \(resullt.0),newAfter = \(resullt.1)")
        
        testRemove(testArr: before)
        
        let draw : ImageDrawing = ImageSVG()
        draw.addEllipse(rect: CGRect.zero, fill: ColorMethodho(hexValue: 0xffffff))
        draw.showExtension()
        
        outterName = Variable.init("lilei")
        model = infoModel.init(name: Variable("yo"))
        
        dis = outterName.asObservable()
            .debug()
            .map {
            $0 + "after"
        }.bind(to: model.name)
    }
}

extension SwiftLab{
    
    func funcAsDelegate() {
        let av = HelloAlertView.init()
        var logger = TapLogger.init()
        
        av.buttonTapped = {
            logger.logTap(index: $0)
        }
    }
    
    func performenceCompare() {
        var refers = [ReferenceModel]()
        var unRefers = [UnReferenceModel]()
        
        for index in 0..<10000000 {
            let modelId = String.init(format: "%d", index)
            
            let referModel = ReferenceModel.init()
            referModel.modelId = modelId
            refers.append(referModel)
            
            var unReferModel = UnReferenceModel.init()
            unReferModel.modelId = modelId
            unRefers.append(unReferModel)
        }
        
        var duration : Double = 0
        let timeFor = DateFormatter.init()
        timeFor.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let beginDate = Date.init()
        let begin : Double = beginDate.timeIntervalSince1970 * 1000
        for model in unRefers {
            let _ = model.modelId
            
        }
        let endDate = Date.init()
        let end : Double = endDate.timeIntervalSince1970 * 1000
        duration = duration + end - begin
        print("duration = \(duration)")
        
    }
    
    func testCodable() {
        
//        let willCodeArray = infoModel.init(name: Variable.init("hello"))
//        do {
//            let data = try JSONSerialization.data(withJSONObject: willCodeArray, options: [])
//            let newArray = try JSONSerialization.jsonObject(with: data, options: [])
//            print("array = \(newArray)")
//        } catch  {
//            print("unAvailable type")
//        }
    }
    
    func testRemove(testArr : Array<NSInteger>) {
        
        let count = testArr.count
        var newTest = testArr
        var minArrs = [Array<NSInteger>]()
        for index in 0..<count {
            newTest.remove(at: index)
            minArrs.append(newTest)
            newTest = testArr
        }
        printWithTime(minArrs)
        
    }
    
    func createRandom(number : Int,before : Array<NSInteger>,after : Array<NSInteger>) -> (Array<NSInteger>,Array<NSInteger>) {
        
        if number < 1 {
            return (before,after)
        }
        
        var newBefore = before
        var newAfter = after
        let newRandomNum = number - 1
        
        let ranomNum = NSInteger.init(arc4random()%UInt32.init(number))
        newAfter.append(before[ranomNum])
        newBefore.remove(at: ranomNum)
        
        return createRandom(number: newRandomNum, before: newBefore, after: newAfter)
    }
    
    func changeModel() {
        tapCount = tapCount + 1
        outterName.value = "hanmeimei" + "~~" + String.init(format: "%d", tapCount)
        
        print("model = \(model.name.value)")
        
        if tapCount > 10 {
            dis?.dispose()
        }
    }
    
    func testCombine() {
        
        let dataArr = ["1","2"]
        let dataSet = Set.init(dataArr)
        
        let dataArr1 = ["2","1"]
        let dataSet1 = Set.init(dataArr)
        
        if dataArr == dataArr1 {
            printWithTime("equal")
        }
    }
    
    
    func calculatePointPath() {
        
        let lats = ["30.214898","30.215370","30.214021","30.214360","30.213502"]
        let lons = ["120.204429","120.205466","120.205103","120.203441","120.203993"]
        var models = [PointModel]()
        
        for index in 1..<6 {
            let model1 = PointModel.init()
            model1.pointFlag = "1505359921000"
            model1.pointId = String.init(format: "%d", index)
            model1.pointLat = lats[index - 1]
            model1.pointLon = lons[index - 1]
            model1.pointIsFixed = index == 1 ? "1" : "0"
            models.append(model1)
        }
        
        
        let manage = SWPointPathManage.shareInstance
        var duration : Double = 0
        let timeFor = DateFormatter.init()
        timeFor.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        for _ in 0..<100 {
            let beginDate = Date.init()
            let begin : Double = beginDate.timeIntervalSince1970 * 1000
            let _ = manage.exhaustionAllSatisfedPath(models, queueMemberCount: 4, minLength: 800)
            //            guard let error = result.error else {
            //                let _ = result.result.map({ (model) in
            //                    print("id = \(model.pointId),sequence = \(model.pointSequence)")
            //                })
            //                return
            //            }
            //            printWithTime("error = \(error)")
            let endDate = Date.init()
            let end : Double = endDate.timeIntervalSince1970 * 1000
            duration = duration + end - begin
        }
        print("duration = \(duration)")
        
        //        printWithTime("~~~~~~~~now sequence end~~~~~~~~")
    }
}

//MARK: - for performence compare
class ReferenceModel : NSObject{
    var modelId : String!
    
}

struct UnReferenceModel {
    var modelId : String!
}

//MARK: - 
struct infoModel{
    var name : Variable<String>!
    
}

//MARK: - 
protocol ImageDrawing {
    func addEllipse(rect : CGRect,fill : UIColor)
}

extension ImageDrawing{
    func showExtension() {
        print("hello Drawing")
    }
}

//MARK: -
extension CGContext : ImageDrawing{
    func addEllipse(rect: CGRect, fill: UIColor) {
        setFillColor(fill.cgColor)
        fillEllipse(in: rect)
    }
}

struct ImageSVG {
    func showExtension() {
        print("hello SVG")
    }
}

extension ImageSVG : ImageDrawing{
    func addEllipse(rect: CGRect, fill: UIColor) {
        print("hello SVG")
    }
}



//MARK: - 
class IntIterator{
    var nextImpl : () -> Int?
    
    init<I : IteratorProtocol>(_ iterator : I) where I.Element == Int {
        var iteratorCopy = iterator
        self.nextImpl = {
            iteratorCopy.next()
        }
        
    }
}

//MARK: - 
enum FileError : Error{
    case fileDoesNotExit
    case noPermission
}

enum Result<A>{
    case failure(Error)
    case success(A)
}

//MARK: - func as delegate
class HelloAlertView{
    var buttons : [String]
    var buttonTapped : ((Int) -> ())?
    
    init(buttons : [String] = ["OK","Cancel"]) {
        self.buttons = buttons
    }
    
}

struct TapLogger{
    var taps : [Int] = []
    mutating func logTap(index : Int){
        taps.append(index)
    }
}

