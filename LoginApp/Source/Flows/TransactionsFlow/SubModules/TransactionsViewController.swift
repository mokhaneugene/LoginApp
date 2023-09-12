//
//  TransactionsViewController.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 15/02/2022.
//

import UIKit

final class TransactionsViewController: UIViewController {
    // MARK: - Private properties
    private var collectionView: UICollectionView?
    private var loadingLabel = UILabel()
    private var viewModel: TransactionsViewModel?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Configure
    func configure(viewModel: TransactionsViewModel) {
        self.viewModel = viewModel
        setupViewModel()
    }
}

private extension TransactionsViewController {
    // MARK: - Private methods
    func setupViewModel() {
        viewModel?.onStateChange = { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .onSetupItems(let isHideLoading):
                self.setupItems()
                self.loadingLabel.isHidden = !isHideLoading
            case .onDateUpdate:
                self.setupDateUpdate()
            case .onError(let titleError):
                self.showError(titleError: titleError)
            }
        }

        viewModel?.launch()
    }

    func setupItems() {
        view.backgroundColor = .systemPurple
        navigationItem.title = "Transactions"
        setupCollectionView()
        setupLoadingLabel()
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        collectionView.backgroundColor = .clear
        collectionView.register(TransactionCell.self, forCellWithReuseIdentifier: TransactionCell.reuseId)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
    }

    func setupLoadingLabel() {
        view.addSubview(loadingLabel)
        loadingLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        loadingLabel.textColor = .white
        loadingLabel.textAlignment = .center
        loadingLabel.font = .systemFont(ofSize: 24, weight: .medium)
        loadingLabel.text = "Loading..."
    }

    // MARK: - States
    func setupDateUpdate() {
        collectionView?.reloadData()
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.loadingLabel.isHidden = true
        }
    }

    func showError(titleError: String) {
        let alert = UIAlertController(title: "Ooops", message: titleError, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension TransactionsViewController: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.transactionsCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.reuseId, for: indexPath) as? TransactionCell else {
            return .init()
        }

        if let cellModel = viewModel?.transactionModel(at: indexPath) {
            cell.configure(model: cellModel)
        }
        
        return cell
    }
}

extension TransactionsViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.bounds.width, height: 300)
    }
}
