//
//  HipoMember+CoreDataProperties.swift
//  HipoAssignment
//
//  Created by Ali Emre Değirmenci on 27.02.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//
//

import Foundation
import CoreData


extension HipoMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HipoMember> {
        return NSFetchRequest<HipoMember>(entityName: "HipoMember")
    }

    @NSManaged public var name: String
    @NSManaged public var age: Int16
    @NSManaged public var location: String
    @NSManaged public var github: String
    @NSManaged public var position: String
    @NSManaged public var years_in_hipo: Int16

}
