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
    private var toolBar = UIToolbar()
    private var picker  = UIPickerView()
    private var filteredItems: [ItemUIModel] = []
    private var filterWord: String?
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
   
    private func bindViewModel() {
        viewModel?.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.filteredItems = items
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

    // MARK: - Actions
    @objc private func filterButtonTapped() {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubview(picker)
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc private func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
        
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


