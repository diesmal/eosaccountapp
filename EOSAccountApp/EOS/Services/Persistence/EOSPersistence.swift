//
//  EOSPersistence.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation
import CoreData

/// Unfortunately, it is not so easy to abstract from Core Data, I do not think that it is so necessary for this task
final class EOSPersistence {
    
    let storage: Persistence
    
    init(storage: Persistence) {
        self.storage = storage
    }
    
    func accounts() -> [EOSAccount] {
        return fetchAccounts()
    }
    
    func account(name: String) -> EOSAccount? {
        return fetchAccounts(name: name).first
    }
    
    func save(_ account: EOSAccount) {
        let dbAccount = storage.fetchNewOrWritable(EOSDBAccount.self, predicate: predicateFor(account.name))
        
        EOSPersistenceMapper.map(account, to: dbAccount)
        
        storage.save(dbAccount.isUpdated ? nil : dbAccount)
    }
    
    func fetchedObjectList(for accountName: String) -> MappedFetchedList<EOSDBAccount, EOSAccount>? {
        let predicate = predicateFor(accountName)
        guard let controller = self.storage.fetchedObjectList(EOSDBAccount.self, predicate: predicate) else {
            return nil
        }
        return MappedFetchedList(fetchedList: controller, mapping: { EOSPersistenceMapper.map($0) })
    }
    
    private func fetchAccounts(name: String? = nil) -> [EOSAccount]{
        let predicate = predicateFor(name)
        let dbAccounts = self.storage.fetch(EOSDBAccount.self, predicate: predicate)
        return dbAccounts.map({ EOSPersistenceMapper.map($0) })
    }
    
    private func predicateFor(_ name: String?) -> NSPredicate? {
        var predicate: NSPredicate? = nil
        if let name = name {
            predicate = NSPredicate(format: "name == %@", name)
        }
        return predicate
    }
}


