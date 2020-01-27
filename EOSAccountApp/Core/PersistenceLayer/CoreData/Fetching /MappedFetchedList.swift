//
//  MappedFetchedList.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import CoreData
import Combine

class MappedFetchedList<ManagedObject: NSManagedObject, FlatObject> {
    private let fetchedList: FetchedObjectList<ManagedObject>
    private let mapping: (ManagedObject) -> FlatObject
    
    init(fetchedList: FetchedObjectList<ManagedObject>,
         mapping:@escaping (ManagedObject) -> FlatObject) {
        
        self.fetchedList = fetchedList
        self.mapping = mapping
    }
    
    var objectDidChange: AnyPublisher<FlatObject, Never> {
        fetchedList.objectDidChange.map({ self.mapping($0) } ).eraseToAnyPublisher()
    }
    
    var contentDidChange: AnyPublisher<(), Never> {
        fetchedList.contentDidChange
    }
}
