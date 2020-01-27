//
//  AppCoordinator.swift
//  LastAlbums
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit

/// The root coordinator, creates the basic services and selects the entry point to the application
class AppCoordinator {
    
    let network: Network = NetworkLayer(http: HTTPLayer())
    var eosCoordinator: EOSCoordinator?
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        eosCoordinator = EOSCoordinator(window: window, network: network)
        eosCoordinator?.start()
    }
}
