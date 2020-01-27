//
//  BitUnitTests.swift
//  EOSAccountTests
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import XCTest

class BitUnitTests: XCTestCase {
    
    func testBytes() {
        XCTAssertEqual(123.formattedBitUnit, "123 bytes")
    }
    
    func testNegativeBytes() {
        XCTAssertEqual((-123).formattedBitUnit, "-123 bytes")
    }
    
    func testKilobytes() {
        XCTAssertEqual(1234.formattedBitUnit, "1.21 kb")
    }
    
    func testNegativeKilobytes() {
        XCTAssertEqual((-1234).formattedBitUnit, "-1.21 kb")
    }
    
    func testMegabytes() {
        XCTAssertEqual(1234567.formattedBitUnit, "1.18 mb")
    }
    
    func testNegativeMegabytes() {
        XCTAssertEqual((-1234567).formattedBitUnit, "-1.18 mb")
    }
    
    func testGigabytes() {
        XCTAssertEqual(1234567890.formattedBitUnit, "1.15 gb")
    }
    
    func testNegativeGigabytes() {
        XCTAssertEqual((-1234567890).formattedBitUnit, "-1.15 gb")
    }
    
}
