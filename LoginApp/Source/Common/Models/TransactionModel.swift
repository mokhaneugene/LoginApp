//
//  TransactionModel.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 23/02/2022.
//

import Foundation

struct TransactionModel: Decodable {
    let id: String
    let fullName: String
    let account: String
    let type: `Type`
    let amount: String
    let description: String
    let date: String

    enum `Type`: String, Decodable {
        case credit
        case debit
    }

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "counterPartyName"
        case account = "counterPartyAccount"
        case type
        case amount
        case description
        case date
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.account = try container.decode(String.self, forKey: .account)
        self.type = try container.decode(`Type`.self, forKey: .type)
        self.amount = try container.decode(String.self, forKey: .amount)
        self.description = try container.decode(String.self, forKey: .description)
        self.date = try container.decode(String.self, forKey: .date)
    }

    init(id: String, fullName: String, account: String, type: `Type`, amount: String, description: String, date: String) {
        self.id = id
        self.fullName = fullName
        self.account = account
        self.type = type
        self.amount = amount
        self.description = description
        self.date = date
    }

    static var mock: Self {
        return .init(id: "c2a394ff-73b8-4c14-a11c-c78ff16bd356",
                     fullName: "Valerie Ayala",
                     account: "LT024911651994432842",
                     type: .credit,
                     amount: "9.86",
                     description: "Packaged Foods",
                     date: "2020-10-29")
    }
}
