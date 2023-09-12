//
//  CustomTextField.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit

final class CustomTextField: UITextField {
    // MARK: - Private properties
    private struct Constants {
        static let iconHeight: CGFloat = 15
    }

    private let iconView = UIView()
    private let textPadding = UIEdgeInsets(top: 0, left: 2 * Constants.iconHeight, bottom: 0, right: 3 * Constants.iconHeight)

    override var placeholder: String? {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                       attributes: [.foregroundColor: UIColor.darkGray])
        }
    }

    @Published var isValid: Bool = false {
        didSet {
            self.iconView.backgroundColor = self.isValid ? .systemGreen : .systemRed
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

    // MARK: - Public methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

private extension CustomTextField {
    // MARK: - Private methods
    func setupItems() {
        backgroundColor = .white
        textAlignment = .left
        textColor = .darkGray
        font = .systemFont(ofSize: 18)
        setupIconView()
    }

    func setupIconView() {
        addSubview(iconView)
        iconView.layer.cornerRadius = Constants.iconHeight / 2
        iconView.backgroundColor = .systemRed
        iconView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(Constants.iconHeight)
            make.trailing.equalToSuperview().offset(-Constants.iconHeight)
        }
    }
}
