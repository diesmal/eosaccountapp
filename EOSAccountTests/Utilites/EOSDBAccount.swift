//
//  EOSDBAccount.swift
//  EOSAccountTests
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class EOSDBAccount {
    var name: String? = nil
    var coreLiquidBalance: String? = nil
    var ramQuota: Int64? = nil
    var netUsed: Int64? = nil
    var netMax: Int64? = nil
    var cpuUsed: Int64? = nil
    var cpuMax: Int64? = nil
    var ramUsage: Int64? = nil
}
