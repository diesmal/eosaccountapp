//
//  IdentificationProvider.swift
//  LastAlbums
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable  {
    static var identifier: String {
        return String(describing: self)
    }
}
