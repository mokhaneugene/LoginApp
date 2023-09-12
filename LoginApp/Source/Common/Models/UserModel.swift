//
//  UserModel.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 17/02/2022.
//

import Foundation

struct UserModelInfo {
    @UserDefault("user_model", defaultValue: [])
    static var element: [UserModel]
}

struct UserModel: Codable {
    enum CodingKeys: CodingKey {
        case login
        case password
    }

    var login: String
    var password: String

    init(login: String, password: String) {
        self.login = login
        self.password = password
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.login = try container.decode(String.self, forKey: .login)
        self.password = try container.decode(String.self, forKey: .password)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(login, forKey: .login)
        try container.encode(password, forKey: .password)
    }
}
