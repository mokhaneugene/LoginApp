//
//  AuthorizationViewController.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit
import SnapKit

final class AuthorizationViewController: BaseViewController {
    // MARK: - Private properties
    private var viewModel: AuthorizationViewModel?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }

    // MARK: - Public methods
    func configure(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
    }

    override func configureItems(model: BaseViewController.Model) {
        super.configureItems(model: model)
    }
}

private extension AuthorizationViewController {
    // MARK: - Private methods
    func setupViewModel() {
        viewModel?.onStateChange = { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .onDataReady(let model):
                self.configureItems(model: model)
            case .onError:
                self.showError()
            }
        }

        viewModel?.launch()
    }
}
