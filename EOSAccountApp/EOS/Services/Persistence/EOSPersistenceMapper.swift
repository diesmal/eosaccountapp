//
//  EOSPersistenceMapper.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation
import CoreData

/// Keep only flat objects in view model level
final class EOSPersistenceMapper {
    static func map(_ dbAccount: EOSDBAccount) -> EOSAccount {
        let account = EOSAccount(name: dbAccount.name ?? "",
                                 coreLiquidBalance: dbAccount.coreLiquidBalance,
                                 ramQuota: dbAccount.ramQuota,
                                 netLimit: EOSAccount.ResourceLimit(used: dbAccount.netUsed, max: dbAccount.netMax),
                                 cpuLimit: EOSAccount.ResourceLimit(used: dbAccount.cpuUsed, max: dbAccount.cpuMax),
                                 ramUsage: dbAccount.ramUsage)
        return account
    }
    
    static func map(_ account: EOSAccount, to dbAccount: EOSDBAccount) {
        dbAccount.name = account.name
        dbAccount.coreLiquidBalance = account.coreLiquidBalance
        dbAccount.ramQuota = account.ramQuota ?? 0
        dbAccount.ramUsage = account.ramUsage ?? 0
        dbAccount.cpuUsed = account.cpuLimit?.used ?? 0
        dbAccount.cpuMax = account.cpuLimit?.max ?? 0
        dbAccount.netUsed = account.netLimit?.used ?? 0
        dbAccount.netMax = account.netLimit?.max ?? 0
    }
}
