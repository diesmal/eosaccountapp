//
//  UIWebImageView.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit

/// Stupid  image downloader for avatars. It can only upload images and be round, but it fast to code.
class UIWebAvatarView: UIImageView {
    
    var imageURL: URL? = nil {
        didSet {
            self.image = nil
            if let url = imageURL {
                load(url: url)
            }
        }
    }
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if url == self?.imageURL {
                            self?.alpha = 0
                            self?.image = image
                            UIView.animate(withDuration: 0.3) {
                                self?.alpha = 1
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height/2
    }
}
