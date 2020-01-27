//
//  AccounstListViewModel.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation
import Combine

class AccounstListViewModel {
    let onContentChange = PassthroughSubject<(), Never>()
    let error = PassthroughSubject<String, Never>()
    
    private var accounts = [EOSAccount]()
    private let eosService: EOSService
    private let avatarProvider: AvatarProvider
    private weak var accountPresenter: EOSAccountPresenter?
    
    var count: Int {        
        return accounts.count
    }
    
    init(service: EOSService, avatarProvider: AvatarProvider, accountPresenter: EOSAccountPresenter) {
        eosService = service
        self.accountPresenter = accountPresenter
        self.avatarProvider = avatarProvider
        updateAccounts()
    }
    
    func updateAccounts() {
        self.accounts = eosService.accounts
        onContentChange.send()
    }
    
    func imageUrl(at index: Int) -> URL? {
        return avatarProvider.avatar(for: accounts[index].name)
    }
    
    func accountName(at index: Int) -> String? {
        return accounts[index].name
    }
    
    func onAddAccount(name: String) {
        eosService.getAccount(account: name) { [weak self] (result) in
            switch result {
            case .success(let account):
                if let account = account {
                    self?.eosService.save(account: account)
                    self?.updateAccounts()
                }
            case .failure(let error):
                Logger.error(error)
                self?.error.send(error.localizedDescription)
            }
        }
    }
    
    func onAccount(ar index: Int) {
        accountPresenter?.present(account: accounts[index])
    }
}
