//
//  CoreDataPersistence.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import CoreData

/// My first time with Core Data in Swift. With Objective-C, Core Data looks better.
class CoreDataPersistence: Persistence {
    
    private let dbName: String
    private var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dbName)
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        if let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathToDb = documentsPathURL.appendingPathComponent("\(dbName)_db")
            container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: pathToDb)]
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                Logger.error(error)
            }
        })
        return container
    }()
    
    init(name: String) {
        dbName = name
    }
    
    func fetch<Object: NSManagedObject>(_ type: Object.Type,
                                        predicate: NSPredicate? = nil) -> [Object] {
        let request = fetchRequest(type, predicate: predicate)
        do {
            return try self.context.fetch(request)
        } catch {
            Logger.error(error)
        }
        return []
    }
    
    func fetchedObjectList<Object: NSManagedObject>(_ type: Object.Type,
                                                    predicate: NSPredicate? = nil) -> FetchedObjectList<Object>? {
        let request = fetchRequest(type)
        request.sortDescriptors = []
        
        let fetchedList = FetchedObjectList(fetchRequest: request, managedObjectContext: self.context)
        
        return fetchedList
    }
    
    func fetchRequest<Object: NSManagedObject>(_ type: Object.Type,
                                               predicate: NSPredicate? = nil) -> NSFetchRequest<Object> {
        let fetchRequest = NSFetchRequest<Object>(entityName: type.description())
        fetchRequest.predicate = predicate
        return fetchRequest
    }
    
    func fetchNewOrWritable<Object: NSManagedObject>(_ type: Object.Type,
                                                     predicate: NSPredicate? = nil) -> Object {
        let request = fetchRequest(type, predicate: predicate)
        
        var obj: Object? = nil
        do {
            obj = try self.context.fetch(request).first
        } catch {
            Logger.error(error)
        }
        return obj ?? Object(context: self.context)
    }
    
    func new<Object: NSManagedObject>(_ type: Object.Type) -> Object {
        Object(context: self.context)
    }
    
    func save(_ object: NSManagedObject? = nil) {
        if let object = object {
            self.context.insert(object)
        }
        do {
            try self.context.save()
        } catch {
            Logger.error(error)
        }
    }
}
