//
//  AvatarProvider.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

protocol AvatarProvider {
    func avatar(for name: String) -> URL?
}
