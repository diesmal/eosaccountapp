//
//  NumberExtractable.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

fileprivate let decimals = Set("0123456789.")

protocol NumberExtractable {
    func number() -> Double?
}

extension String : NumberExtractable {
    
    func number() -> Double? {
        let filtered = String( self.filter{ decimals.contains($0) } )
        return Double(filtered)
    }
}
