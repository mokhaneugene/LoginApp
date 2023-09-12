//
//  RegistrationViewModel.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import Foundation

final class RegistrationViewModel {
    // MARK: - Private properties
    private let handlers: RegistrationResources.Handlers
    private let authorizationManager = AuthorizationManager.shared

    var onStateChange: ((RegistrationResources.State) -> Void)?

    // MARK: - Initializator
    init(handlers: RegistrationResources.Handlers) {
        self.handlers = handlers
    }

    // MARK: - Public methods
    func launch() {
        setupItems()
    }
}

private extension RegistrationViewModel {
    // MARK: - Private methods
    func setupItems() {
        let model = BaseViewController.Model(type: .registration,
                                             onRegisterUser: { [weak self] userModel in
                                                self?.registerUser(userModel: userModel)
                                            })
        onStateChange?(.onDataReady(model))
    }

    func registerUser(userModel: UserModel) {
        authorizationManager.tryToRegister(userModel: userModel) { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                self.handlers.onFinish()
            case .error:
                self.onStateChange?(.onError)
            }
        }
    }
}
