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
    private var categories: [CategoryUIModel] = []
    private var collectionView: UICollectionView!
    private let reuseIdentifier = "cell"
    private var observers: [AnyCancellable] = []
    private var pickerView  = PickerView()
    private var filteredItems: [ItemUIModel] = []
    private var filterWord: String?
    var viewModel: ItemsViewModel?
    
    // MARK: - Inherite
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        // Navigation bar configuration
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Filter"), for: .normal)
        button.addTarget(self, action: #selector(filterButtonWasTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.isEnabled = !view.isHaveSubview(ofType: PickerView.self)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.hidesBackButton = true
        
        // Add loadingView
        view.showLoader()
        
        // Set up collectionView
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
        collectionView.isHidden = true
        
        // Data
        bindViewModel()
        loadData()
        
        // Filtering
        pickerView.$didSelect
            .sink { [weak self] filterWasSelected in
                if filterWasSelected {
                    self?.pickerView.removeFromSuperview()
                    self?.startFiltering()
                    if let count = self?.filteredItems.count, count > 2 {
                        self?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                }
            }
            .store(in: &observers)
    }
    
    override func viewWillLayoutSubviews() {
        view.layoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Private
    private func bindViewModel() {
        viewModel?.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.collectionView.isHidden = false
                self?.filteredItems = items
                self?.collectionView.reloadData()
                self?.view.hideLoader()
            }
            .store(in: &observers)
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
    
    private func startFiltering() {
        guard let items = viewModel?.items else {
            return
        }
        
        if filterWord == localized("item.filter") {
            filteredItems = items
        } else {
            filteredItems = items.filter({ item in
                return item.category_name == filterWord
            })
        }
        
        collectionView.reloadData()
    }

    // MARK: - Actions
    @objc private func filterButtonWasTapped() {
        guard let items = viewModel?.items, !items.isEmpty else {
            return
        }
        pickerView.picker.delegate = self
        pickerView.picker.dataSource = self
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200)
        view.addSubview(pickerView)
    }
}

// MARK: - UICollectionViewDataSource
extension ItemsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.item = filteredItems[indexPath.row]
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.toDetails(of: filteredItems[indexPath.row])
    }
}

// MARK: - UIPickerView
extension ItemsListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.categoriesNames.count ?? 0
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.categoriesNames[row] ?? ""
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        filterWord = viewModel?.categoriesNames[row]
    }
}

