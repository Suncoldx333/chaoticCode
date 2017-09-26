//
//  AsyncSafeSwiftyManage.swift
//  JSCallOC
//
//  Created by 11111 on 2017/8/25.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

class AsyncSafeSwiftyManage: NSObject {
    
    static let share = AsyncSafeSwiftyManage()
    private override init() {
        
    }
    
    //MARK: - Var
    var swiftyDataArr : Array<String>!
    var ocDataArr : NSMutableArray!
    enum DataType : NSInteger{
        case swifty = 1,
            objective = 2
    }
    
    func checkCurArr() {
        withUnsafePointer(to: &self.swiftyDataArr, {
            print("4 = \($0)")
        })
        printWithTime("at last arr count = \(swiftyDataArr.count)")
        
    }
    
    //MARK: - Swifty
    func swiftyDeleteAll() {
        withUnsafePointer(to: &swiftyDataArr) {
            print("1 = \($0)")
        }
        
        guard (swiftyDataArr) != nil else {
            fatalError("you may initialize arr first")
            
        }
        withUnsafePointer(to: &swiftyDataArr) {
            print("2 = \($0)")
        }
        swiftyDataArr.removeLast(100)
        print("now swifty count = \(swiftyDataArr.count)")
    }
    
    func traverseArr(type : NSInteger) {
        
        if type == DataType.swifty.rawValue {
            
            customSynchronized(swiftyDataArr, f: { 
                withUnsafePointer(to: &swiftyDataArr, {
                    print("3 = \($0)")
                })
                
                for str : String in swiftyDataArr {
                    str == "0" ? print("\(Date.init()) swifty show \(str)") : print("now swifty show \(str)")
                }
                
//                let _ = swiftyDataArr.map({ (str) in
//                    str == "0" ? print("\(Date.init()) swifty show \(str)") : print("now swifty show \(str)")
//                    
//                })
            })
            
        }
        
    }
    
    func operationTest() {
        
        var willChangeArray = [Int]()
        var willChangeArray1 = [Int]()
        var willChangeArray2 = [Int]()

        var model = operatModel.init(modelId: "hello")
        
        let queue = OperationQueue.init()
        queue.maxConcurrentOperationCount = 4
        var operations = [Operation]()

        let op1 = BlockOperation.init {
//            for index in 0..<100{
//                willChangeArray1.append(index)
//
//            }
            model.modelId = "op1"
        }
        let op2 = BlockOperation.init { 
//            for index in 100..<200{
//                willChangeArray2.append(index)
//                
//            }
            model.modelId = "op2"
        }
        
        let op3 = BlockOperation.init {
//            willChangeArray.append(contentsOf: willChangeArray1)
//            willChangeArray.append(contentsOf: willChangeArray2)
//            print("\(willChangeArray)")
            print("\(model.modelId)")
        }
        op3.addDependency(op1)
        op3.addDependency(op2)
        
        operations.append(op1)
        operations.append(op2)
        operations.append(op3)

        queue.addOperations(operations, waitUntilFinished: false)
//        let filterOperation = BlockOperation.init {
//            print("\(willChangeArray)")
//
//            let _ = willChangeArray.filter{
//                $0 < 8
//            }
//        }
//        for index in 1..<4 {
//            let operation = BlockOperation.init(block: {
//                
//                for innerIndex in ((index - 1) * 5)..<(index * 5){
//                    willChangeArray.append(innerIndex)
//                    
//                }
//            })
//            
//            filterOperation.addDependency(operation)
//            operations.append(operation)
//        }
//        operations.append(filterOperation)
//        
//        queue.addOperations(operations, waitUntilFinished: false)
//        print("\(willChangeArray)")
        
    }
    
    //MARK: - Objective
    func ocDeleteAll() {
        
        guard let objectiveArr = ocDataArr else {
            fatalError("you may initialize arr first")
        }
        objectiveArr.removeAllObjects()
        print("now objective count = \(objectiveArr.count)")
    }
    
    fileprivate func traverseArr(_ arr : Any) {
        
        
        
    }
    
}

struct operatModel {
    var modelId : String!
}
