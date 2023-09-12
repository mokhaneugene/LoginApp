//
//  UINavigationController.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 14/02/2022.
//

import UIKit

extension UINavigationController {
    func popViewController(withAnimation animation: Bool, completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animation)
        CATransaction.commit()
        guard !animation else { return }
        completion()
    }

    func pushViewController(viewController: UIViewController, withAnimation animation: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animation)
        CATransaction.commit()
        guard !animation else { return }
        completion?()
    }
}
