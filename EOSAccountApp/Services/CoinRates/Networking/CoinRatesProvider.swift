//
//  CoinsRatesProvider.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class CoinsRatesProvider: CoinRates {
    
    enum _Error: Error {
        case cannotBuildURL
    }
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func getRates(pair: String, completion: @escaping (Result<Double?, Error>) -> Void) {
        guard let request = CoinsRatesRouter.rate(pair).request() else {
            completion(.failure(_Error.cannotBuildURL))
            return
        }
        
        let mapResult: (Result<CoinRate?, Error>) -> Void = { result in
            switch result {
            case .success(let rate):
                completion(.success(rate?.last))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        network.processRequest(request, with: mapResult)
    }
}
