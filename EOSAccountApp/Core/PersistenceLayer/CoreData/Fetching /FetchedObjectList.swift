//
//  FetchedObjectList.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation
import CoreData
import Combine

class FetchedObjectList<Object: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    let fetchedResultsController: NSFetchedResultsController<Object>
    
    private let onContentChange = PassthroughSubject<(), Never>()
    private let onObjectChange = PassthroughSubject<Object, Never>()
    
    init?(fetchRequest: NSFetchRequest<Object>,
          managedObjectContext: NSManagedObjectContext) {
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        super.init()
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            Logger.error(error)
            return nil
        }
    }
    
    var objects: [Object] {
        fetchedResultsController.fetchedObjects ?? []
    }
    
    var contentDidChange: AnyPublisher<(), Never> {
        onContentChange.eraseToAnyPublisher()
    }
    
    var objectDidChange: AnyPublisher<Object, Never> {
        onObjectChange.eraseToAnyPublisher()
    }
    
    //MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        onContentChange.send()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        onObjectChange.send(anObject as! Object)
    }
}
