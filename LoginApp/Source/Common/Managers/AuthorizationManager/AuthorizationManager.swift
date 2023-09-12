//
//  AuthorizationManager.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 17/02/2022.
//

import Foundation

final class AuthorizationManager {
    // MARK: - Private properties
    enum State {
        case success
        case error
    }
    private var userModels: [UserModel] { UserModelInfo.element }

    static let shared = AuthorizationManager()

    private init() {}

    // MARK: - Public methods
    func tryToLogin(userModel: UserModel, onFinish: (State) -> Void) {
        if userModels.first(where: { $0.login == userModel.login && $0.password == userModel.password }) != nil {
            onFinish(.success)
            return
        }
        onFinish(.error)
    }

    func tryToRegister(userModel: UserModel, onFinish: (State) -> Void) {
        if userModels.first(where: { $0.login == userModel.login }) == nil {
            UserModelInfo.element.append(userModel)
            onFinish(.success)
            return
        }
        onFinish(.error)
    }
}

private extension AuthorizationManager {
    // MARK: - Private methods
}
