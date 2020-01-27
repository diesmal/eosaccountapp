//
//  EOSEndpointsTests.swift
//  EOSAccountTests
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import XCTest

class EOSEndpointsTests: XCTestCase {
    
    func testDefaultEndoint() {
        let expectedEndopoint = Endpoint(scheme: .https, host: "api.eosnewyork.io", port: nil)
        let endpoint = EOSEndpoints().peek()
        
        XCTAssertTrue(expectedEndopoint.scheme == endpoint.scheme &&
            expectedEndopoint.host == endpoint.host &&
            expectedEndopoint.port == endpoint.port)
    }
    
}
