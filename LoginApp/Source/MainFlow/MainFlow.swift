//
//  MainFlow.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 14/02/2022.
//

import UIKit

final class MainFlow {
    // MARK: - Private properties
    private(set) var navigator: MainFlowNavigatorProtocol

    private let authorizationFlow: AuthorizationFlow
    private let transactionsFlow: TransactionsFlow

    // MARK: - Initializator
    init(navigator: MainFlowNavigatorProtocol) {
        self.navigator = navigator

        self.authorizationFlow = AuthorizationFlow(navigator: AuthorizationFlowNavigator())
        self.transactionsFlow = TransactionsFlow(navigator: TransactionsFlowNavigator())
        
        self.setupAppearance()
    }

    // MARK: - Public methods
    func makeStartFlow(window: UIWindow?) -> Bool {
        guard let window = window else { return false }

        window.rootViewController = makeLaunchScreen()
        window.makeKeyAndVisible()

        goToAuthorizationFlow()

        return true
    }
}

extension MainFlow {
    // MARK: - Flows
    func makeAuthorizationFlow() -> UIViewController {
        let controller = authorizationFlow.makeStartFlow()
        return UINavigationController(rootViewController: controller)
    }

    func makeTransactionsFlow() -> UIViewController {
        return transactionsFlow.makeStartFlow()
    }
}
