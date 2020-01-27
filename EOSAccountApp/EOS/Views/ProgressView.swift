//
//  ProgressView.swift
//  EOSAccountUI
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressView: UIView {
    
    private let fillingView = UIView()
    
    @IBInspectable var fillColor: UIColor? {
        get {
            return fillingView.backgroundColor
        }
        set (newValue) {
            fillingView.backgroundColor = newValue
            fillingView.layer.shadowColor = (fillingView.backgroundColor ?? UIColor.clear).cgColor
            fillingView.layer.shadowOpacity = 1
            fillingView.layer.shadowOffset = .zero
            fillingView.layer.shadowRadius = 6
        }
    }
    
    var progress: CGFloat = 0.5 {
        didSet {
            layoutSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.addSubview(fillingView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var progressFrame = self.bounds
        progressFrame.size.width *= progress
        fillingView.frame = progressFrame
        
        layer.cornerRadius = frame.size.height/2
        layer.masksToBounds = true
    }
}

