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
    fileprivate var items: [ItemUIModel] = []
    fileprivate var categories: [CategoryUIModel] = []
    fileprivate var collectionView: UICollectionView!
    fileprivate let reuseIdentifier = "cell"
    private var observers: [AnyCancellable] = []
    var viewModel: ItemsViewModel?
    
    // MARK: - Inherite
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindViewModel()
        loadData()
    }
    
    // MARK: - Private
    private func bindViewModel() {
        viewModel?.$items
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
                displaySnack(text: localized("error.service"), color: .red)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ItemsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ItemsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        // the cell's height is 1.5 times its width
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}

