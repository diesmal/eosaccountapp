//
//  EOSAccount.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

struct EOSAccount {
    let name: String
    let coreLiquidBalance: String?
    let ramQuota: Int64?
    let netLimit: ResourceLimit?
    let cpuLimit: ResourceLimit?
    let ramUsage: Int64?
    let totalResourses: TotalResourses?
    
    struct ResourceLimit: Decodable {
        let used: Int64?
        let max: Int64?
    }
    
    struct TotalResourses {
         let netWeight: String?
         let cpuWeight: String?
    }
}

extension EOSAccount: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "account_name"
        case coreLiquidBalance = "core_liquid_balance"
        case ramQuota = "ram_quota"
        case netLimit = "net_limit"
        case cpuLimit = "cpu_limit"
        case ramUsage = "ram_usage"
        case totalResourses = "total_resources"
    }
}

extension EOSAccount.TotalResourses: Decodable {
    enum CodingKeys: String, CodingKey {
        case netWeight = "net_weight"
        case cpuWeight = "cpu_weight"
    }
}
