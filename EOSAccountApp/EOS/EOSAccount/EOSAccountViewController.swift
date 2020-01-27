//
//  EOSAccountViewController.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit
import Combine

class EOSAccountViewController: UIViewController, Combinable {
    
    var viewModel: EOSAccountViewModel!
    var cancellableCollector = [AnyCancellable]()
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var balance: UILabel!    
    @IBOutlet weak var netProgress: ProgressView!
    @IBOutlet weak var netTitle: UILabel!
    @IBOutlet weak var cpuProgress: ProgressView!
    @IBOutlet weak var cpuTitle: UILabel!
    @IBOutlet weak var ramProgress: ProgressView!
    @IBOutlet weak var ramTitle: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var netStacked: UILabel!
    @IBOutlet weak var cpuStacked: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        bind()
        viewModel.viewReady()
    }
    
    func setupHeader() {
        headerView.layer.shadowColor = (headerView.backgroundColor ?? UIColor.clear).cgColor
        headerView.layer.shadowOpacity = 1
        headerView.layer.shadowOffset = .zero
        headerView.layer.shadowRadius = 10
        
        let dustLayer = DustLayer()
        dustLayer.frame = headerView.bounds
        headerView.layer.addSublayer(dustLayer)
    }
    
    func bind() {
        mainAssign(viewModel.$name, to: \.text, on: accountName)
        mainAssign(viewModel.$balance, to: \.text, on: balance)
        mainAssign(viewModel.$cost, to: \.text, on: cost)
        mainAssign(viewModel.$netUsage, to: \.text, on: netTitle)
        mainAssign(viewModel.$cpuUsage, to: \.text, on: cpuTitle)
        mainAssign(viewModel.$ramUsage, to: \.text, on: ramTitle)
        mainAssign(viewModel.$netStacked, to: \.text, on: netStacked)
        mainAssign(viewModel.$cpuStacked, to: \.text, on: cpuStacked)
        
        mainBind(viewModel.$netNormalizedUsage) { [weak self] (usage) in
            self?.updateUsage(progressView: self?.netProgress, usage: usage)
        }
        mainBind(viewModel.$cpuNormalizedUsage) { [weak self] (usage) in
            self?.updateUsage(progressView: self?.cpuProgress, usage: usage)
        }
        mainBind(viewModel.$ramNormalizedUsage) { [weak self] (usage) in
            self?.updateUsage(progressView: self?.ramProgress, usage: usage)
        }
    }
    
    func updateUsage(progressView: ProgressView?, usage: Float) {
        UIView.animate(withDuration: 0.3) {
            progressView?.progress = CGFloat(usage)
        }
    }
    
    @IBAction func onSend(_ sender: UIButton) {
        viewModel.onSend()
    }
    
    @IBAction func onReceive(_ sender: UIButton) {
        viewModel.onReceive()
    }
    
    @IBAction func onDeposit(_ sender: UIButton) {
        viewModel.onDeposit()
    }
}

// MARK: - Storyboarded
extension EOSAccountViewController: Storyboarded {}
