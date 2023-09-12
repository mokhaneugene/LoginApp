//
//  UINavigator.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 14/02/2022.
//

import UIKit
import Combine

protocol NavigatorProtocol {
    var rootNavigationController: UINavigationController? { get }
    var activePresentingController: UIViewController? { get }
    var activeNavigationController: UINavigationController? { get }

    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool, completion: (() -> Void)?)
    func present(_ viewController: UIViewController, insideNavigation: Bool, style: UIModalPresentationStyle, animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)

    func goToRoot(clearRootStack: Bool, animated: Bool, completion: (() -> Void)?)
    func goToViewController(_ viewController: UIViewController, clearRootStack: Bool, animated: Bool, completion: (() -> Void)?)

    func replaceWindowRootController(_ controller: UIViewController, animated: Bool)
}

class UINavigator: NavigatorProtocol {
    enum TypeRootPresenting {
        case basic
        case custom
    }

    // MARK: - Private properties
    private(set) var typeRootPresenting: TypeRootPresenting = .basic
    private(set) var rootPresentingController: UIViewController?
    private var cancellable: AnyCancellable?

    var rootNavigationController: UINavigationController? {
        return rootPresentingController as? UINavigationController
    }

    var activePresentingController: UIViewController? {
        var controller = rootPresentingController
        while controller?.presentedViewController != nil {
            controller = controller?.presentedViewController
        }

        return controller
    }

    var activeNavigationController: UINavigationController? {
        let controller = activePresentingController == rootPresentingController
        ? rootNavigationController
        : activePresentingController

        return controller as? UINavigationController
    }

    // MARK: - Initializator
    init(rootPresentingController: UIViewController? = nil) {
        defer {
            setupSubscriber()
        }

        guard let rootController = rootPresentingController else {
            self.typeRootPresenting = .basic
            self.rootPresentingController = AppDelegate.shared.window?.rootViewController
            return
        }

        self.typeRootPresenting = .custom
        self.rootPresentingController = rootController
    }

    deinit {
        cancellable?.cancel()
    }

    // MARK: - Setup Subscriver
    func setupSubscriber() {
        cancellable = UIChangedRootControllerPublisher.shared.publisher.sink(receiveValue: { [weak self] controller in
            guard let self = self else { return }

            if self.typeRootPresenting == .basic {
                self.rootPresentingController = controller
            }
        })
    }

    // MARK: - navigatorProtocol
    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        activeNavigationController?.pushViewController(viewController: viewController, withAnimation: animated, completion: completion)
    }

    func pop(animated: Bool, completion: (() -> Void)?) {
        activeNavigationController?.popViewController(withAnimation: animated, completion: completion ?? {})
    }

    func present(_ viewController: UIViewController, insideNavigation: Bool, style: UIModalPresentationStyle, animated: Bool) {
        // TODO: - Add present logic
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        // TODO: - Add dismiss logic
    }

    func goToRoot(clearRootStack: Bool, animated: Bool, completion: (() -> Void)?) {
        // TODO: - Add goToRoot logic
    }

    func goToViewController(_ viewController: UIViewController, clearRootStack: Bool, animated: Bool, completion: (() -> Void)?) {
        // TODO: - Add goToViewContorller logic
    }

    func replaceWindowRootController(_ controller: UIViewController, animated: Bool) {
        guard let window = AppDelegate.shared.window else {
            print("Root window not found!")
            return
        }

        guard animated, let snapshot = window.snapshotView(afterScreenUpdates: true) else {
            window.rootViewController = controller
            window.makeKeyAndVisible()
            return
        }

        controller.view.addSubview(snapshot)

        UIChangedRootControllerPublisher.shared.changeRootController(controller: controller)

        UIView.transition(with: snapshot,
                          duration: 0.3,
                          options: .transitionCrossDissolve) {
                                snapshot.layer.opacity = 0
                          } completion: { _ in
                                snapshot.removeFromSuperview()
                          }
    }
}
