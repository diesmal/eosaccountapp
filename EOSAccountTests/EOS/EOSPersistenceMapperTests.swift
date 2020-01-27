//
//  EOSPersistenceMapperTests.swift
//  EOSAccountTests
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import XCTest

class EOSPersistenceMapperTests: XCTestCase {
    
    func testEOSAccountToEOSDBAccountMapping() {
        let eosAccount = getEosAccount()
        let eosDBAccount = EOSDBAccount()
        
        EOSPersistenceMapper.map(eosAccount, to: eosDBAccount)
        
        XCTAssertTrue(isEqual(eosAccount: eosAccount, eosDBAccount: eosDBAccount))
    }
    
    func testEOSDBAccountToEOSAccountMapping() {
        let eosDBAccount = getEosDBAccount()
        
        let eosAccount = EOSPersistenceMapper.map(eosDBAccount)
        
        XCTAssertTrue(isEqual(eosAccount: eosAccount, eosDBAccount: eosDBAccount))
    }
    
    //MARK: - Helpers
    
    func isEqual(eosAccount: EOSAccount, eosDBAccount: EOSDBAccount) -> Bool {
        eosAccount.name == eosDBAccount.name &&
            eosAccount.coreLiquidBalance == eosDBAccount.coreLiquidBalance &&
            eosAccount.ramQuota ?? 0 == eosDBAccount.ramQuota &&
            eosAccount.ramUsage ?? 0 == eosDBAccount.ramUsage &&
            eosAccount.cpuLimit?.used ?? 0 == eosDBAccount.cpuUsed &&
            eosAccount.cpuLimit?.max ?? 0 == eosDBAccount.cpuMax &&
            eosAccount.netLimit?.used ?? 0 == eosDBAccount.netUsed &&
            eosAccount.netLimit?.max ?? 0 == eosDBAccount.netMax
    }
    
    func getEosAccount() -> EOSAccount {
        return EOSAccount(name: "swiftercodeword",
                          coreLiquidBalance: "1.1570 EOS",
            ramQuota: 1375112636333789869,
            netLimit: EOSAccount.ResourceLimit(used: 276475120956143454,
                                               max: 398452198996935373),
            cpuLimit: EOSAccount.ResourceLimit(used: 1360185766404912725,
                                               max: 2403681607635462262),
            ramUsage: 344554966664123230)
    }
    
    func getEosDBAccount() -> EOSDBAccount {
        let eosDBAccount = EOSDBAccount()
        eosDBAccount.name = "spoonbilldenver"
        eosDBAccount.coreLiquidBalance = "1.4629 EOS"
        eosDBAccount.netMax = 450781178762024464
        eosDBAccount.netUsed = 130438159021454758
        eosDBAccount.cpuMax = 6319342149277089527
        eosDBAccount.cpuUsed = 656588581919617257
        eosDBAccount.ramQuota = 1126679153921201460
        eosDBAccount.ramUsage = 130438159021454758
        
        return eosDBAccount
    }
    
}
