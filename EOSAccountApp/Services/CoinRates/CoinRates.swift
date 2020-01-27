//
//  CoinRates.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol CoinRates {
    func getRates(pair: String, completion: @escaping (Result<Double?, Error>) -> Void)
}
