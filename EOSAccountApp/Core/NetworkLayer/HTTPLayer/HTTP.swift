//
//  HTTP.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol HTTP {    
    func request(url: URL,
                 method: HTTPMethod,
                 httpBody: Data?,
                 headers: [String: String]?,
                 completion: @escaping (Result<Data, Error>) -> Void)
}

