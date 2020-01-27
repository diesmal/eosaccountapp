//
//  EOSApiRouter.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

enum EOSApiRouter {
    
    case account
    
    var method: HTTPMethod {
        switch self {
        case .account:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .account:
            return "/v1/chain/get_account"
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .account:
            return ["accept": "application/json",
                    "content-type": "application/json"]
        }
    }
    
    func request(endpoint: Endpoint, queryParams: [String: String]? = nil, body: Data? = nil) -> NetworkRequest? {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = endpoint.scheme.rawValue
        urlComponents.host = endpoint.host
        urlComponents.port = endpoint.port
        
        urlComponents.path = path
        if let params = queryParams {
            urlComponents.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        return NetworkRequest(url: url, body: body, method: method, headers: headers)
    }
}
