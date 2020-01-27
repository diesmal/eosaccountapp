//
//  CoinsRatesRouter.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

enum CoinsRatesRouter {
    
    case rate(String)
    
    static let host = "apiv2.bitcoinaverage.com"
    
    var method: HTTPMethod {
        switch self {
        case .rate:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .rate(let pair):
            return "/indices/tokens/ticker/\(pair)"
        }
    }
    
    var scheme: NetworkScheme {
        switch self {
        case .rate:
            return NetworkScheme.https
        }
    }
    
    func request() -> NetworkRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme.rawValue
        urlComponents.host = CoinsRatesRouter.host
        urlComponents.path = path
        
        guard let url = urlComponents.url else {
            return nil
        }
        return NetworkRequest(url: url, body: nil, method: method, headers: nil)
    }
}
