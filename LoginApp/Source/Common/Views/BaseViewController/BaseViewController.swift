//
//  BaseViewController.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 17/02/2022.
//

import UIKit
import SnapKit
import Combine

class BaseViewController: UIViewController {
    struct Model {
        var type: `Type`
        var onTapRegistrationButton: (() -> Void)? = nil
        var onRegisterUser: ((UserModel) -> Void)? = nil
        var onTapLoginButton: ((UserModel) -> Void)? = nil

        enum `Type`: String {
            case authorization = "Authorization"
            case registration = "Registration"
        }
    }

    // MARK: - Private properties
    private let stackView = UIStackView()
    private let loginTextField = CustomTextField()
    private let passwordTextField = CustomTextField()
    private let horizontalStackView = UIStackView()
    private let loginButton = CustomButton()
    private let registrationButton = CustomButton()

    private var onTapLoginButton: ((UserModel) -> Void)?
    private var onTapRegistrationButton: (() -> Void)?
    private var onRegisterUser: ((UserModel) -> Void)?

    private var type: Model.`Type` = .authorization
    private var cancellables: [AnyCancellable] = []

    // MARK: - Public methods
    func configureItems(model: Model) {
        navigationItem.title = model.type.rawValue
        type = model.type
        loginButton.isHidden = model.type == .registration
        self.onTapLoginButton = model.onTapLoginButton
        self.onTapRegistrationButton = model.onTapRegistrationButton
        self.onRegisterUser = model.onRegisterUser
        setupItems()
    }

    func showError() {
        let alert = UIAlertController(title: "Ooops", message: "Something going wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

private extension BaseViewController {
    // MARK: - Private methods
    func setupItems() {
        view.backgroundColor = .systemPurple
        navigationController?.navigationBar.prefersLargeTitles = true
        setupStackView()
        setupLoginTextField()
        setupPasswordTextField()
        setupHorizontalStackView()
        setupLoginButton()
        setupRegistrationButton()
    }

    func setupStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(horizontalStackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.center.equalToSuperview()
        }
    }

    func setupLoginTextField() {
        loginTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        loginTextField.placeholder = "Login"
        loginTextField.textPublisher()
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.loginTextField.isValid = self.checkLoginForValid(for: value)
            })
            .store(in: &cancellables)
    }

    func setupPasswordTextField() {
        passwordTextField.placeholder = "Password"
        passwordTextField.textPublisher()
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.passwordTextField.isValid = self.checkPasswordForValid(for: value)
            })
            .store(in: &cancellables)
    }

    func setupHorizontalStackView() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 15
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.addArrangedSubview(loginButton)
        horizontalStackView.addArrangedSubview(registrationButton)
    }

    func setupLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        checkButtonForValid(for: loginButton)
    }

    @objc func didTapLoginButton() {
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        onTapLoginButton?(UserModel(login: login, password: password))
    }

    func setupRegistrationButton() {
        registrationButton.isEnabled = type == .authorization
        registrationButton.setTitle("Registration", for: .normal)
        registrationButton.addTarget(self, action: #selector(didTapRegistrationButton), for: .touchUpInside)
        guard type == .registration else { return }
        checkButtonForValid(for: registrationButton)
    }

    @objc func didTapRegistrationButton() {
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        type == .authorization ? onTapRegistrationButton?() : onRegisterUser?(UserModel(login: login, password: password))
    }

    // MARK: - Authorization logic
    func checkLoginForValid(for login: String) -> Bool {
        var countOfEmptySymbols = 0
        login.forEach({
            guard $0 == " " else { return }
            countOfEmptySymbols += 1
        })
        return !login.isEmpty && countOfEmptySymbols != login.count
    }

    func checkPasswordForValid(for password: String) -> Bool {
        return password.count >= 6
    }

    func checkButtonForValid(for button: UIButton) {
        Publishers.CombineLatest(loginTextField.$isValid, passwordTextField.$isValid)
            .map({ $0 && $1 })
            .assign(to: \.isEnabled, on: button)
            .store(in: &cancellables)
    }
}
