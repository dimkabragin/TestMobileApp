//
//  URLString+CoreDataProperties.swift
//  TestApp
//
//  Created by Дмитрий Брагин on 04.08.2021.
//
//

import Foundation
import CoreData


extension URLString {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<URLString> {
        return NSFetchRequest<URLString>(entityName: "URLString")
    }

    @NSManaged public var string: String

}

extension URLString : Identifiable {

}
