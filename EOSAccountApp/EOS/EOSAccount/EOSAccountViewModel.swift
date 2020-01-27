//
//  EOSAccountViewModel.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 26.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation
import Combine

class EOSAccountViewModel: Combinable {
    
    var cancellableCollector = [AnyCancellable]()
    private var fetchStorage: Any?
    private let eosService: EOSService
    private let ratesService: CoinRates
    private var account: EOSAccount {
        didSet {
            name = account.name
            balance = account.coreLiquidBalance ?? "0 EOS"
            netUsage = formatUsageData(account.netLimit?.used, account.netLimit?.max)
            cpuUsage = "\(account.cpuLimit?.used ?? 0) μs /  \(account.cpuLimit?.max ?? 0) μs"
            ramUsage = formatUsageData(account.ramUsage, account.ramQuota)
            netNormalizedUsage = normalize(current: account.netLimit?.used ?? 0,
                                           max: account.netLimit?.max ?? 0)
            cpuNormalizedUsage = normalize(current: account.cpuLimit?.used ?? 0,
                                           max: account.cpuLimit?.max ?? 0)
            ramNormalizedUsage = normalize(current: account.ramUsage ?? 0,
                                           max: account.ramQuota ?? 0)
            updateCost()
        }
    }
    
    @Published var name: String? = ""
    @Published var balance: String? = ""
    @Published var cost: String? = nil
    @Published var netUsage: String? = ""
    @Published var cpuUsage: String? = ""
    @Published var ramUsage: String? = ""
    @Published var netNormalizedUsage: Float = 0
    @Published var cpuNormalizedUsage: Float = 0
    @Published var ramNormalizedUsage: Float = 0
    
    init(eosService: EOSService, ratesService: CoinRates, account: EOSAccount) {
        self.eosService = eosService
        self.ratesService = ratesService
        self.account = account
        setupFetch(for: account.name)
        eosService.startAccountUpdating(name: account.name)
    }
    
    /// Workaround due to @Published do not provide initial value
    func viewReady() {
        let tmpAccount = account
        self.account = tmpAccount
    }
    
    func setupFetch(for accountName: String) {
        if let fetchList = eosService.fetchedObjectList(for: accountName) {
            bind(fetchList.objectDidChange) { [weak self] (account) in
                self?.account = account
            }
            fetchStorage = fetchList
        }
    }
    
    func updateCost() {
        ratesService.getRates(pair: "EOSUSD") { [weak self] (result) in
            switch result {
            case .success(let rate):
                if let rate = rate,
                    let balance = self?.account.coreLiquidBalance?.number() {
                    self?.cost = "≈\(String(format: "%.2f", balance * rate))$"
                } else {
                    self?.cost = nil
                }
            case .failure(let error):
                Logger.error(error)
            }
        }
    }
    
    func formatUsageData(_ used: Int64?, _ max: Int64?) -> String {
        "\((used ?? 0).formattedBitUnit) /  \((max ?? 0).formattedBitUnit)"
    }
    
    func normalize(current: Int64, max: Int64) -> Float {
        guard max > 0, max >= current else {
            return 0
        }
        return Float(current) / Float(max)
    }
}
