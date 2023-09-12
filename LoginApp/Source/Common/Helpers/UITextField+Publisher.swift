//
//  UITextField+Publisher.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 22/02/2022.
//

import UIKit
import Combine

extension UITextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map({ ($0.object as? UITextField)?.text ?? ""})
            .eraseToAnyPublisher()
    }
}
