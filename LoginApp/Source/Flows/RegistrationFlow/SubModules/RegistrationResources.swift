//
//  RegistrationResources.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import Foundation

struct RegistrationResources {
    struct Handlers {
    var onFinish: () -> Void
    }

    enum State {
        case onDataReady(BaseViewController.Model)
        case onError
    }
}
