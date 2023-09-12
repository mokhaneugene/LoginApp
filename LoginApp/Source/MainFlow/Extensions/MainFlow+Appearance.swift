//
//  MainFlow+Appearance.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 17/02/2022.
//

import UIKit

extension MainFlow {
    func setupAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.tintColor = .white
        appearance.barTintColor = .systemPurple

    }
}
