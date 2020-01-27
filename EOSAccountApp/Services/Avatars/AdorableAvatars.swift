//
//  AdorableAvatars.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

/// Weird avatars, just for fun
class AdorableAvatars: AvatarProvider {
    func avatar(for name: String) -> URL? {
        var components = URLComponents()
        components.scheme = NetworkScheme.https.rawValue
        components.host = "api.adorable.io"
        components.path = "/avatars/285/\(name).png"
        
        return components.url
    }
}
