//
//  BaseCoreData.swift
//  JSCallOC
//
//  Created by 11111 on 2017/5/25.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit
import CoreData

class BaseCoreData: NSObject {
    
    static let shareInstance = BaseCoreData()
    
    let manageObjectModel : NSManagedObjectModel!
    let persistent : NSPersistentStoreCoordinator!
    let context : NSManagedObjectContext!
    
    private override init(){
        let modelURL : URL = Bundle.main.url(forResource: "Model", withExtension: "momd")!
        manageObjectModel = NSManagedObjectModel.init(contentsOf: modelURL)
        
        persistent = NSPersistentStoreCoordinator.init(managedObjectModel: manageObjectModel)
        
        let documentDirectory : URL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
        let sqliteURL : URL = documentDirectory.appendingPathComponent("Model.sqlite")
        do{
            let persisOption = [NSMigratePersistentStoresAutomaticallyOption : NSNumber.init(value: true),NSInferMappingModelAutomaticallyOption : NSNumber.init(value: true)]
            
            try persistent.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: sqliteURL, options: persisOption)
        }catch{
            print("here Error")
        }
        
        context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistent
        
    }
    
    @available(iOS 10,*)
    func showHello() {
        
    }
}
