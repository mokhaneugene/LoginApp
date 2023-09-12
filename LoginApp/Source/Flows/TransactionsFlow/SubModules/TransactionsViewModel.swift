//
//  TransactionsViewModel.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import Foundation

final class TransactionsViewModel {
    // MARK: - Private properties
    private let handlers: TransactionsResources.Handlers
    private let transactionManager = TransactionManager.shared

    var onStateChange: ((TransactionsResources.State) -> Void)?

    // MARK: - Initializator
    init(handlers: TransactionsResources.Handlers) {
        self.handlers = handlers
    }

    func launch() {
        onStateChange?(.onSetupItems(transactionManager.transactions.isEmpty))
        setupTransactionManager()
    }

    func transactionsCount() -> Int {
        return transactionManager.transactions.count
    }

    func transactionModel(at indexPath: IndexPath) -> TransactionModel? {
        return transactionManager.transactions[safe: indexPath.row]
    }
}

private extension TransactionsViewModel {
    // MARK: - Private methods
    func setupTransactionManager() {
        transactionManager.handlers = TransactionManager.Handlers(
            onShowError: { [weak self] error in
                self?.onStateChange?(.onError(error))
            },
            onFinishLoading: { [weak self] in
                self?.onStateChange?(.onDateUpdate)
            }
        )
        transactionManager.fetchModel()
    }
}
