//
//  UIChangedRootControllerPublisher.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 14/02/2022.
//

import UIKit
import Combine

class UIChangedRootControllerPublisher {
    private let subject = PassthroughSubject<UIViewController?, Never>()

    public static let shared = UIChangedRootControllerPublisher()
    public var publisher: AnyPublisher<UIViewController?, Never> {
        subject.eraseToAnyPublisher()
    }

    public func changeRootController(controller: UIViewController?) {
        guard let window = AppDelegate.shared.window else {
            print("Root window not found!")
            return
        }

        window.rootViewController = controller
        subject.send(controller)
    }
}
