//
//  Combinable.swift
//  ThisOrThat
//
//  Created by Ilia Nikolaenko on 25.01.20.
//  Copyright © 2020 Ilya Nikolaenko. All rights reserved.
//

import Foundation
import Combine

/// The attempt to make work with the combine more clear
protocol Combinable: class {
    var cancellableCollector: [AnyCancellable] { get set }
}

extension Combinable {
    func mainBind<S: Publisher>(_ subject: S, receiveValue: @escaping ((S.Output) -> Void)) where S.Failure == Never {
        let cancellable = subject.receive(on: RunLoop.main).sink(receiveValue: receiveValue)
        cancellableCollector.append(cancellable)
    }
    
    func bind<S: Publisher>(_ subject: S, receiveValue: @escaping ((S.Output) -> Void)) where S.Failure == Never {
        let cancellable = subject.sink(receiveValue: receiveValue)
        cancellableCollector.append(cancellable)
    }
    
    func assign<S: Publisher, Root>(_ subject: S, to keyPath: ReferenceWritableKeyPath<Root, S.Output>, on object: Root) where S.Failure == Never {
        let cancellable = subject.assign(to: keyPath, on: object)
        cancellableCollector.append(cancellable)
    }
    
    func mainAssign<S: Publisher, Root>(_ subject: S, to keyPath: ReferenceWritableKeyPath<Root, S.Output>, on object: Root) where S.Failure == Never {
        let cancellable = subject.receive(on: RunLoop.main).assign(to: keyPath, on: object)
        cancellableCollector.append(cancellable)
    }
}
