//
//  AuthorizationFactory.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit

final class AuthorizationFactory {
    func createController(handlers: AuthorizationResources.Handlers) -> UIViewController {
        let viewModel = AuthorizationViewModel(handlers: handlers)
        let viewController = AuthorizationViewController()

        viewController.configure(viewModel: viewModel)

        return viewController
    }
}
