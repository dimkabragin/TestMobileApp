//
//  AppSettings+CoreDataProperties.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 04.08.2021.
//
//

import Foundation
import CoreData


extension AppSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppSettings> {
        return NSFetchRequest<AppSettings>(entityName: "AppSettings")
    }

    @NSManaged public var isLogin: Bool

}

extension AppSettings : Identifiable {

}
