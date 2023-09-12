//
//  AppDelegate.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 14/02/2022.
//

import UIKit

protocol AppDelegateProtocol {
    var window: UIWindow? { get }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AppDelegateProtocol {
    static let shared: AppDelegateProtocol = UIApplication.shared.delegate as! AppDelegateProtocol

    var mainFlow: MainFlow!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        mainFlow = MainFlow(navigator: MainFlowNavigator())
        guard mainFlow.makeStartFlow(window: window) else { return false }

        return true
    }
}

