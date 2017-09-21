//
//  baseModel.swift
//  JSCallOC
//
//  Created by 11111 on 2017/3/16.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit
import CoreData

class baseModel: NSObject {
    
    public init(changingDic : [String : Any]) {
        super.init()
        createAttribute(changingDic: changingDic)
    }
    
    public var mayStr : String!
    
    var tedIC : [String : String]?
    
    public init(teDouble :Double){
        super.init()

//        var anoDouble : Double = teDouble
//        anoDouble.maySssss = 0.998
//        mayStr = NSNumber.init(floatLiteral: anoDouble.maySssss!).stringValue
//
//        if tedIC == nil {
//            
//        }
        
        let fir = [Int]();
        let sec = [2];
        let ad = fir + sec
        
        
        
        let teArr = [1,2,3,4,5]
        let _ = teArr.map2 { (num) in
            num + 9
        }
        
        let coreDataInstance : BaseCoreData = BaseCoreData.shareInstance
//        let emp : Employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: coreDataInstance.context) as! Employee
//        emp.setValue(Date.init(), forKey: "birthday")
//        emp.setValue(1.80, forKey: "height")
//        emp.setValue("Mike", forKey: "name")
//        emp.setValue("iOS", forKey: "sectionName")
        
        let entity = NSEntityDescription.entity(forEntityName: "Department", in: coreDataInstance.context)
        let depart : Department = NSManagedObject.init(entity: entity!, insertInto: coreDataInstance.context) as! Department
        depart.createDate = Date.init() as NSDate
        depart.departName = "CLAUDX33"
        
        
        do{
            try coreDataInstance.context.save()
            
        }catch{
            print("error")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Department")
//        let entity : NSEntityDescription? = NSEntityDescription.entity(forEntityName: "Employee", in: coreDataInstance.context)
//        request.entity = entity
        request.predicate = NSPredicate.init(format: "departName='CLAUDX33'", "")
        var resultArr : NSMutableArray = NSMutableArray.init()
        do{
            resultArr = try coreDataInstance.context.fetch(request) as! NSMutableArray
            print(resultArr)
        }catch{
            print("exeuError")
        }
        
        if resultArr.count > 0 {
            print(resultArr.map({ (manObject) -> Date in
                let name : Date = (manObject as! NSManagedObject).value(forKey: "createDate") as! Date
                return name
            }))
//            let manObject : NSManagedObject = resultArr.firstObject as! NSManagedObject
//            let name : String = manObject.value(forKey: "departName") as! String
//            print(name)
        }
        
    }

    
    func createAttribute(changingDic : [String : Any]) {
        
        let keyArr = changingDic.keys
        for _ in keyArr {
            
        }
        
        var count : UInt32 = 0
        let ivars = class_copyIvarList(self.classForCoder, &count)
        
        for index in 0..<count {
            _ = String.init(describing: ivar_getName(ivars?[Int.init(index)]))
        }
        
    }
}

extension Array{
    func map2<T>(_ transForm : (Element) -> T) -> [T] {
        return reduce([]){
            $0 + [transForm($1)]
        }
    }
}

class userDefaultManage: NSObject {
    static let shareInstance = userDefaultManage.init()
    override init() {
        
    }
    
    fileprivate var model : userDefaultModel! = userDefaultModel.init()
    
    func userDefaultInitialize() {
        model.usrName = "shanshan"
        model.usrAge = "16"
    }
    
    func userDefaultStore() {
        
        
        
//        let modelData = Data.in
        UserDefaults.standard.set(model, forKey: allKeys.userDefaultTestKey)
        UserDefaults.standard.synchronize()
    }
}

class userDefaultModel: NSObject {
    var usrName : String! = "leihou"
    var usrAge : String! = "18"
    
    
}


