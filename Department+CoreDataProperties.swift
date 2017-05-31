//
//  Department+CoreDataProperties.swift
//  JSCallOC
//
//  Created by 11111 on 2017/5/25.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import Foundation
import CoreData


extension Department {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Department> {
        return NSFetchRequest<Department>(entityName: "Department")
    }

    @NSManaged public var createDate: NSDate?
    @NSManaged public var departName: String?
    @NSManaged public var employee: Employee?

}
