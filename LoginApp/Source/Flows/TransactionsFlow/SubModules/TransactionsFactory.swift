//
//  TransactionsFactory.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit

final class TransactionsFactory {
    func createController(handlers: TransactionsResources.Handlers) -> UIViewController {
        let viewModel = TransactionsViewModel(handlers: handlers)
        let viewController = TransactionsViewController()

        viewController.configure(viewModel: viewModel)

        return viewController
    }
}
