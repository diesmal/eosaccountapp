//
//  DustLayer.swift
//  EOSAccountUI
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit

/// I rarely can use it, but I like to see effects from  particle system.
class DustLayer: CAEmitterLayer {
    
    override var frame: CGRect {
        didSet {
            emitterSize = frame.size
            emitterPosition = CGPoint(x: emitterSize.width/2, y: emitterSize.height/2)
        }
    }
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        name = "DustLayer"
        emitterZPosition = 0
        emitterDepth = 0.00
        emitterShape = .rectangle
        emitterMode = .surface
        renderMode = .backToFront
        seed = 3203108351
        
        let dustCell = CAEmitterCell()
        setupCell(cell: dustCell)
        emitterCells = [dustCell]
    }
    
    func setupCell(cell: CAEmitterCell) {
        cell.name = "DustCell"
        cell.isEnabled = true
        
        cell.contents = UIImage(named: "particle_base")?.cgImage
        cell.contentsRect = CGRect(x: 0.00, y: 0.00, width: 1.00, height: 1.00)
        
        cell.magnificationFilter = CALayerContentsFilter.nearest.rawValue
        cell.minificationFilter = CALayerContentsFilter.nearest.rawValue
        cell.minificationFilterBias = 0.00
        
        cell.scale = 0.08
        cell.scaleRange = 0.00
        cell.scaleSpeed = 0.00
        
        cell.color = UIColor.white.cgColor
        cell.redRange = 0.31
        cell.greenRange = 0.37
        cell.blueRange = 1.00
        cell.alphaRange = 0.00
        
        cell.redSpeed = 7.89
        cell.greenSpeed = 7.92
        cell.blueSpeed = -9.99
        cell.alphaSpeed = -0.05
        
        cell.lifetime = 10.00
        cell.lifetimeRange = 0.00
        cell.birthRate = 5
        cell.velocity = 31.69
        cell.velocityRange = 0.00
        cell.xAcceleration = -11.00
        cell.yAcceleration = -7.00
        cell.zAcceleration = 0.00
        
        cell.spin = 0.000
        cell.spinRange = 0.000
        cell.emissionLatitude = 0.000
        cell.emissionLongitude = 0.000
        cell.emissionRange = 0.000
    }
}
