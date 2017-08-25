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
    
    //MARK: - Swifty
    func swiftyDeleteAll() {
        
        guard var swiftyArr = swiftyDataArr else {
            fatalError("you may initialize arr first")
            
        }
        
        swiftyArr.removeAll()
        print("now swifty count = \(swiftyArr.count)")
    }
    
    func traverseArr(type : NSInteger) {
        
        switch type {
        case DataType.swifty.rawValue:
            let _ = self.swiftyDataArr.map({ (str) in
                
                str == "0" ? print("\(Date.init()) swifty show \(str)") : print("now swifty show \(str)")
                
            })
            
            break
            
        case DataType.objective.rawValue:
            let _ = self.ocDataArr.map({ (str) in
                print("now objective show \(str)")
            })
            break
            
        default:
            fatalError("you may deliver error type")
            break
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
