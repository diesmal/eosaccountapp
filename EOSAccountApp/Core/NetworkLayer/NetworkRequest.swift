//
//  NetworkRequest.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

struct NetworkRequest {
    let url: URL
    let body: Data?
    let method: HTTPMethod
    let headers: [String: String]?
}
