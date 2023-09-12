//
//  TransactionManager.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 23/02/2022.
//

import Foundation

final class TransactionManager {
    struct Handlers {
        var onShowError: (String) -> Void
        var onFinishLoading: () -> Void
    }

    var transactions: [TransactionModel] = []
    var handlers: Handlers?

    static let shared = TransactionManager()

    private init() {}

    // MARK: - Public methods
    func fetchModel() {
        guard transactions.isEmpty else { return }
        NetworkService.getJSONData { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                switch result {
                case .success(let transactions):
                    self.transactions = transactions
                    self.handlers?.onFinishLoading()
                case .failure(let error):
                    self.handlers?.onShowError(error.localizedDescription)
                }
            }
        }
    }
}
