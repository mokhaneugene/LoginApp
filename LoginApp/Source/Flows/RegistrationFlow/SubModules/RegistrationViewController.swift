//
//  RegistrationViewController.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit

final class RegistrationViewController: BaseViewController {
    // MARK: - Private properties
    var viewModel: RegistrationViewModel?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }

    // MARK: - Public methods
    func configure(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }

    override func configureItems(model: BaseViewController.Model) {
        super.configureItems(model: model)
    }
}

private extension RegistrationViewController {
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
