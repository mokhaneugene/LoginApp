//
//  MainFlow+Navigation.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit

extension MainFlow {
    func makeLaunchScreen() -> UIViewController {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        return storyboard.instantiateViewController(identifier: "LaunchScreen")
    }

    func goToAuthorizationFlow() {
        let controller = makeAuthorizationFlow()
        navigator.replaceWindowRootController(controller, animated: true)
    }

    func goToTransactionsFlow() {
        let controller = makeTransactionsFlow()
        navigator.replaceWindowRootController(controller, animated: true)
    }
}
