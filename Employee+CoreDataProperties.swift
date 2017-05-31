//
//  Employee+CoreDataProperties.swift
//  JSCallOC
//
//  Created by 11111 on 2017/5/25.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var birthday: NSDate?
    @NSManaged public var height: Float
    @NSManaged public var name: String?
    @NSManaged public var sectionName: String?
    @NSManaged public var department: Department?

}
