//
//  Database.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation
import CoreData

/// Ideally, this should be abstracted from Core Data, but it has already taken longer than I expected
protocol Persistence {
    func fetchedObjectList<Object: NSManagedObject>(_ type: Object.Type, predicate: NSPredicate?) -> FetchedObjectList<Object>?
    func fetch<Object: NSManagedObject>(_ type: Object.Type, predicate: NSPredicate?) -> [Object]
    func fetchNewOrWritable<Object: NSManagedObject>(_ type: Object.Type, predicate: NSPredicate?) -> Object
    func new<Object: NSManagedObject>(_ type: Object.Type) -> Object
    func save(_ objects: NSManagedObject?)
}
