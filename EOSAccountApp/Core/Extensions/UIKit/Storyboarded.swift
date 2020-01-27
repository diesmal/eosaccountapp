//
//  Storyboarded.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(from storyboard: UIStoryboard?) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(from storyboard: UIStoryboard? = nil) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = storyboard ?? UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
