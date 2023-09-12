//
//  AuthorizationViewModel.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import Foundation

final class AuthorizationViewModel {
    // MARK: - Private properties
    private let handlers: AuthorizationResources.Handlers
    private let authorizationManager = AuthorizationManager.shared

    var onStateChange: ((AuthorizationResources.State) -> Void)?

    // MARK: - Initializator
    init(handlers: AuthorizationResources.Handlers) {
        self.handlers = handlers
    }

    // MARK: - Public methods
    func launch() {
        setupItems()
    }
}

private extension AuthorizationViewModel {
    // MARK: - Private methods
    func setupItems() {
        let model = BaseViewController.Model(type: .authorization,
                                             onTapRegistrationButton: { [weak self] in
                                                    self?.didTapRegistrationButton()
                                            },
                                             onTapLoginButton: { [weak self] userModel in
                                                    self?.loginUser(userModel: userModel)
                                            })
        onStateChange?(.onDataReady(model))
    }

    func loginUser(userModel: UserModel) {
        authorizationManager.tryToLogin(userModel: userModel) { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .error:
                self.onStateChange?(.onError)
            case .success:
                self.handlers.onTransactions()
            }
        }
    }

    func didTapRegistrationButton() {
        handlers.onRegistration()
    }
}
