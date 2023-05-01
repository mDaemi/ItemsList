//
//  ViewController.swift
//  ItemsList
//
//  Created by MDA on 30/04/2023.
//

import UIKit

final class ItemsListViewController: AbstractViewController {
    // MARK: - Properties
    fileprivate var items: [Item] = []
    fileprivate let collectionView : UICollectionView = {
        let cv = UICollectionView()
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    // MARK: - Inherite
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}

// MARK: - UICollectionViewDataSource
extension ItemsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ItemsListViewController: UICollectionViewDelegate {
    
}

