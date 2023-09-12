//
//  RegistrationFactory.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit

final class RegistrationFactory {
    func createController(handlers: RegistrationResources.Handlers) -> UIViewController {
        let viewModel = RegistrationViewModel(handlers: handlers)
        let viewController = RegistrationViewController()

        viewController.configure(viewModel: viewModel)

        return viewController
    }
}
