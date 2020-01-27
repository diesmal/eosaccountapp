//
//  EOSService.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

/// Facade for eos storage and eos api services
class EOSService {
    
    private let storage: EOSPersistence
    private let api: EOSApi
    private lazy var updateTimer: BackgroundRepeatingTimer? = nil
    
    var accounts: [EOSAccount] {
        return storage.accounts()
    }
    
    init(persistence: Persistence, network: Network) {
        storage = EOSPersistence(storage: persistence)
        api = EOSApi(network: network)
    }
    
    func startAccountUpdating(name: String, timeInterval: TimeInterval = 3) {
        guard updateTimer == nil else {
            Logger.error("Repeating updates can only be run for one account")
            return
        }
        updateTimer = BackgroundRepeatingTimer(timeInterval: timeInterval)
        updateTimer?.eventHandler = { [weak self] () in
            self?.update(account: name)
        }
        updateTimer?.resume()
    }
    
    func stopAccountUpdating() {
        updateTimer = nil
    }
    
    func update(account: String) {
        api.getAccountInfo(for: account) { [weak self] (result) in
            switch result {
            case .success(let account):
                if let account = account {
                    self?.storage.save(account)
                } else {
                    Logger.error("no account data")
                }
            case .failure(let error):
                Logger.error(error)
            }
        }
    }
    
    func fetchedObjectList(for account: String) -> MappedFetchedList<EOSDBAccount, EOSAccount>? {
        self.storage.fetchedObjectList(for: account)
    }
    
    func getAccount(account: String, with completion: @escaping (Result<EOSAccount?, Error>) -> Void) {
        if let account = self.storage.account(name: account) {
            completion(.success(account))
        } else {
            api.getAccountInfo(for: account, completion: completion)
        }
    }
    
    func save(account: EOSAccount) {
        self.storage.save(account)
    }
}
