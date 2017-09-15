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
