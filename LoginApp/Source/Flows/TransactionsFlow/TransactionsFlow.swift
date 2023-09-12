//
//  TransactionsFlow.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit

final class TransactionsFlow {
    // MARK: - Private properties
    private let navigator: TransactionsFlowNavigatorProtocol

    // MARK: - Initializator
    init(navigator: TransactionsFlowNavigatorProtocol) {
        self.navigator = navigator
    }

    func makeStartFlow() -> UIViewController {
        let handlers = TransactionsResources.Handlers()
        return TransactionsFactory().createController(handlers: handlers)
    }
}
