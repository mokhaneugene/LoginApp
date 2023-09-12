//
//  AuthorizationFlow.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit

final class AuthorizationFlow {
    // MARK: - Private properties
    private let navigator: AuthorizationFlowNavigatorProtocol

    private let registrationFlow: RegistrationFlow
    private let transactionsFlow: TransactionsFlow

    // MARK: - Initializator
    init(navigator: AuthorizationFlowNavigatorProtocol) {
        self.navigator = navigator

        self.registrationFlow = .init(navigator: RegistrationFlowNavigator())
        self.transactionsFlow = .init(navigator: TransactionsFlowNavigator())
    }

    // MARK: - Public methods
    func makeStartFlow() -> UIViewController {
        let handlers = AuthorizationResources.Handlers(
            onRegistration: { [weak self] in
                guard let self = self else { return }
                let controller = self.makeRegistrationFlow()
                self.navigator.push(controller, animated: true, completion: nil)
            },
            onTransactions: { [weak self] in
                guard let self = self else { return }
                let controller = self.makeTransactionsFlow()
                self.navigator.push(controller, animated: true, completion: nil)
            }
        )
        return AuthorizationFactory().createController(handlers: handlers)
    }
}

private extension AuthorizationFlow {
    // MARK: - Private methods
    func makeRegistrationFlow() -> UIViewController {
        return registrationFlow.makeStartFlow()
    }

    func makeTransactionsFlow() -> UIViewController {
        return transactionsFlow.makeStartFlow()
    }
}
