//
//  Logger.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

class Logger {
    
    static func error(_ text: String) {
        Thread.callStackSymbols.forEach{ print($0) }
        print("🔴 \(Date()): \(text)")
    }
    
    static func error(_ error: Error) {
        Thread.callStackSymbols.forEach{ print($0) }
        print("🔴 \(Date()): \(error)")
    }
    
    static func warning(_ text: String) {
        print("🟡 \(Date()): \(text)")
    }
    
    static func info(_ text: String) {
        print("⚪️ \(Date()): \(text)")
    }
}
