//
//  EOSEndpoints.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

struct Endpoint {
    let scheme: NetworkScheme
    let host: String
    let port: Int?
}

/// There are many endpoints to interact with the EOS production chain, and I had an idea to make a manager to choose, but I don’t have time
class EOSEndpoints {
    func peek() -> Endpoint {
        return Endpoint(scheme: .https, host: "api.eosnewyork.io", port: nil)
    }
}
