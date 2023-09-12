//
//  AuthorizationResources.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import Foundation

struct AuthorizationResources {
    struct Handlers {
        var onRegistration: () -> Void
        var onTransactions: () -> Void
    }

    enum State {
        case onDataReady(BaseViewController.Model)
        case onError
    }
}
