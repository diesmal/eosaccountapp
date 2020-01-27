//
//  EOSApi.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

final class EOSApi {
    
    private let network: Network
    private let endpoint = EOSEndpoints().peek()
    
    enum _Error: Error {
        case cannotBuildURL
        case emptyAccountName
    }
    
    init(network: Network) {
        self.network = network
    }
    
    func getAccountInfo(for accountName: String, completion: @escaping (Result<EOSAccount?, Error>) -> Void) {
        guard accountName.count > 0 else {
            completion(.failure(_Error.emptyAccountName))
            return
        }
        let parameters = ["account_name": accountName]
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completion(.failure(error))
            return
        }
        
        guard let request = EOSApiRouter.account.request(endpoint: endpoint, body: jsonData) else {
            completion(.failure(_Error.cannotBuildURL))
            return
        }
        network.processRequest(request, with: completion)
    }
}
