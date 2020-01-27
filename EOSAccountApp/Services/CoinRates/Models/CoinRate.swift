//
//  CoinRate.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

struct CoinRate : Decodable {
	let last : Double?
	
	enum CodingKeys: String, CodingKey {
		case last = "last"
    }
}
