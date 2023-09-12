//
//  RegistrationFlow.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit

final class RegistrationFlow {
    // MARK: - Private properties
    private let navigator: RegistrationFlowNavigatorProtocol

    // MARK: - Initializator
    init(navigator: RegistrationFlowNavigatorProtocol) {
        self.navigator = navigator
    }

    func makeStartFlow() -> UIViewController {
        let handlers = RegistrationResources.Handlers(
            onFinish: { [weak self] in
                self?.navigator.pop(animated: true, completion: nil)
            }
        )
        return RegistrationFactory().createController(handlers: handlers)
    }
}
