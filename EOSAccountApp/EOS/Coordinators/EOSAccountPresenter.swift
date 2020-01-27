//
//  EOSAccountPresenter.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import Foundation

/// Connecting view model with coordinator
protocol EOSAccountPresenter: class {
    func present(account: EOSAccount)
}
