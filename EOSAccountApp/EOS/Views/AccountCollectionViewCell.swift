//
//  AccountCollectionViewCell.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell, Identifiable {
    
    @IBOutlet var imageView: UIWebAvatarView!
    @IBOutlet weak var titleView: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
    }
}
