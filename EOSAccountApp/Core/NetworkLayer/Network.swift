//
//  Network.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol Network {
    func processRequest<Object: Decodable>(_ request: NetworkRequest, with completion: @escaping (Result<Object?, Error>) -> Void)
}
