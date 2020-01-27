//
//  EOSCoordinator.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit

/// EOS module coordinator
class EOSCoordinator {
    static let name = "EOS"
    let window: UIWindow
    let storyboard: UIStoryboard = UIStoryboard(name: EOSCoordinator.name, bundle: Bundle.main)
    
    let eosService: EOSService
    let coinRatesService: CoinRates
    let avatarProvider: AvatarProvider
    let navController: UINavigationController
    
    init(window: UIWindow, network: Network) {
        
        navController = UINavigationController()
        navController.isNavigationBarHidden = true
        window.rootViewController = navController
        self.window = window
        
        eosService = EOSService(persistence: CoreDataPersistence(name: EOSCoordinator.name), network: network)
        coinRatesService = CoinsRatesProvider(network: network)
        avatarProvider = AdorableAvatars()
    }
    
    func start() {
        navController.pushViewController(eosAccountsListVC(), animated: false)
    }
}

extension EOSCoordinator {
    func eosAccountVC(for account: EOSAccount) -> UIViewController {
        let viewController = EOSAccountViewController.instantiate(from: storyboard)
        let viewModel = EOSAccountViewModel(eosService: eosService, ratesService: coinRatesService, account: account)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func eosAccountsListVC() -> UIViewController {
        let viewController = AccounstListCollectionViewController.instantiate(from: storyboard)
        let viewModel = AccounstListViewModel(service: eosService,
                                              avatarProvider: avatarProvider,
                                              accountPresenter: self)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension EOSCoordinator: EOSAccountPresenter {
    func present(account: EOSAccount) {
        let viewController = eosAccountVC(for: account)
        navController.pushViewController(viewController, animated: true)
    }
}
