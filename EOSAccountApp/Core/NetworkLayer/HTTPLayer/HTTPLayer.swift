//
//  HTTPLayer.swift
//  DeezerService
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class HTTPLayer: HTTP {
    
    enum _Error: Error {       
        case badResponse(URLResponse)
        case noResponseData
    }
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request(url: URL,
                 method: HTTPMethod = .get,
                 httpBody: Data? = nil,
                 headers: [String: String]? = nil,
                 completion: @escaping (Result<Data, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        
        headers?.forEach({ (key: String, value: String) in
            request.setValue(value, forHTTPHeaderField: key)
        })
        
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            } else if let response = response {
                self?.checkReponse(response, completion: completion)
            } else {
                completion(.failure(_Error.noResponseData))
            }
        }
        
        task.resume()
    }
    
    func checkReponse(_ response: URLResponse, completion: (Result<Data, Error>) -> Void) {
        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(_Error.badResponse(response)))
            return
        }
        if httpResponse.statusCode == 200 {
            completion(.success(Data()))
        } else {
            completion(.failure(_Error.badResponse(response)))
        }
    }
}
