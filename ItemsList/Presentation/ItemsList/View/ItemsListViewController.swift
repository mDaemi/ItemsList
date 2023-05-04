//
//  ViewController.swift
//  ItemsList
//
//  Created by MDA on 30/04/2023.
//

import UIKit
import Combine

final class ItemsListViewController: AbstractViewController {
    // MARK: - Properties
    private var items: [ItemUIModel] = []
    private var categories: [CategoryUIModel] = []
    private var collectionView: UICollectionView!
    private let reuseIdentifier = "cell"
    private var observers: [AnyCancellable] = []
    var viewModel: ItemsViewModel?
    
    // MARK: - Inherite
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupCollectionView()
        bindViewModel()
        loadData()
    }
    
    // MARK: - Private
    private func configureNavigationBar() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Filter"), for: .normal)
        button.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.hidesBackButton = true
    }
    
    @objc private func filterButtonTapped() {
        
    }
    
    private func bindViewModel() {
        viewModel?.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.collectionView.reloadData()
            }
            .store(in: &observers)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.constraintToSuperview()
    }
    
    private func loadData() {
        guard let viewModel = viewModel else {
            print("ViewModel is NULL.")
            return
        }
        
        Task {
            do {
                try await viewModel.fetchItems()
                try await viewModel.fetchCategories()
            } catch {
                displaySnack(text: localized("error.service"))
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ItemsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ItemCollectionViewCell, let item = viewModel?.items[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.item = item
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ItemsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}

