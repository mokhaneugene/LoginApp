//
//  TransactionCell.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 23/02/2022.
//

import UIKit

final class TransactionCell: UICollectionViewCell {
    // MARK: - Private properties
    private let bgView = UIView()
    private let stackView = UIStackView()
    private let verticalStackView = UIStackView()
    private let textStackView = UIStackView()
    private let nameLabel = UILabel()
    private let iconStackView = UIStackView()
    private let bgIconView = UIView()
    private let iconImageView = UIImageView()
    private let iconLabel = UILabel()
    private let amountLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()

    static var reuseId: String {
        String(describing: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func configure(model: TransactionModel) {
        dateLabel.text = model.date
        nameLabel.text = model.fullName
        descriptionLabel.text = model.description
        amountLabel.text = model.amount + "€"
        iconImageView.image = model.type == .credit ? UIImage(systemName: "creditcard") : UIImage(systemName: "creditcard.fill")
        iconLabel.text = model.type.rawValue
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}

private extension TransactionCell {
    func setupItems() {
        backgroundColor = .clear
        setupBGView()
        setupStackView()
        setupVerticalStackView()
        setupTextStackView()
        setupNameLabel()
        setupIconImageView()
        setupIconStackView()
        setupIconLabel()
        setupAmountLabel()
        setupDescriptionLabel()
        setupDateLabel()
    }

    func setupBGView() {
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(2)
            make.center.equalToSuperview()
        }
        bgView.backgroundColor = .white.withAlphaComponent(0.75)
        bgView.layer.cornerRadius = 25
    }

    func setupStackView() {
        bgView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.addArrangedSubview(bgIconView)
        stackView.addArrangedSubview(verticalStackView)
        stackView.addArrangedSubview(amountLabel)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(bgView).offset(15)
            make.centerY.equalTo(bgView)
            make.leading.equalTo(bgView).offset(10)
            make.trailing.equalTo(bgView).offset(-15)
        }
    }

    func setupIconImageView() {
        bgIconView.snp.makeConstraints { make in
            make.width.equalTo(stackView.snp.width).multipliedBy(0.2)
        }
        bgIconView.backgroundColor = .clear
        bgIconView.addSubview(iconStackView)
    }

    func setupIconStackView() {
        iconStackView.axis = .vertical
        iconStackView.spacing = 2
        iconStackView.addArrangedSubview(iconImageView)
        iconStackView.addArrangedSubview(iconLabel)
        iconStackView.snp.makeConstraints { make in
            make.center.equalTo(bgIconView)
        }

        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(stackView.snp.width).multipliedBy(0.1)
        }
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.backgroundColor = .clear
        iconImageView.tintColor = .black
    }

    func setupIconLabel() {
        iconLabel.textColor = .black
        iconLabel.textAlignment = .center
        iconLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }

    func setupVerticalStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 5
        verticalStackView.addArrangedSubview(dateLabel)
        verticalStackView.addArrangedSubview(textStackView)
    }

    func setupTextStackView() {
        textStackView.axis = .vertical
        textStackView.spacing = 2
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(descriptionLabel)
    }

    func setupDateLabel() {
        dateLabel.textAlignment = .left
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 1
        dateLabel.font = .systemFont(ofSize: 14, weight: .light)
    }

    func setupNameLabel() {
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
    }

    func setupDescriptionLabel() {
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
    }


    func setupAmountLabel() {
        amountLabel.textAlignment = .center
        amountLabel.textColor = .black
        amountLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        amountLabel.snp.makeConstraints { make in
            make.width.equalTo(stackView.snp.width).multipliedBy(0.2)
        }
    }
}
