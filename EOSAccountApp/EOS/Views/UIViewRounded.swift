//
//  UIViewRounded.swift
//  EOSAccountUI
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit

@IBDesignable
class UIViewRounded: UIView {
    override func layoutSubviews() {
      super.layoutSubviews()
      layer.cornerRadius = frame.size.width/2
    }
}
