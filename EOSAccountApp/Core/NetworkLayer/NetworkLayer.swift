//
//  NetworkLayer.swift
//  DeezerService
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class NetworkLayer: Network {
    
    private let http: HTTP
    private let decoder: JSONDecoder
    private static let networkQueue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "" + "network.queue", attributes: .concurrent)
    
    
    init(http: HTTP, decoder: JSONDecoder = JSONDecoder()) {
        self.http = http
        self.decoder = decoder
    }
    
    func processRequest<Object: Decodable>(_ request: NetworkRequest, with completion: @escaping (Result<Object?, Error>) -> Void) {
        NetworkLayer.networkQueue.async {
            self.http.request( url:request.url,
                               method: request.method,
                               httpBody: request.body,
                               headers: request.headers )
            { [weak self] (result) in
                guard let strongSelf = self else {
                    Logger.info("\(NetworkLayer.self) deallocated during request execution")
                    completion(.success(nil))
                    return
                }
                
                switch result {
                case .success(let data):
                    completion(strongSelf.parseData(data, type: Object.self))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func parseData<Object: Decodable>(_ data: Data,  type: Object.Type) -> Result<Object?, Error> {
        if type == Data.self {
            return .success(data as? Object)
        }
        return Result { try  decoder.decode(Object.self, from: data) }
    }
    
}
