//
//  CustomButton.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 17/02/2022.
//

import UIKit

final class CustomButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .systemYellow : .systemGray2
        }
    }

    // MARK: - Initializator
    init() {
        super.init(frame: .zero)
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}

private extension CustomButton {
    // MARK: - Private methods
    func setupItems() {
        backgroundColor = .systemGray2
        setTitleColor(.darkGray, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    }
}
