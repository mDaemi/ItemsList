//
//  SplashViewController.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import UIKit

final class SplashViewController: AbstractViewController {
    // MARK: - properties
    var viewModel: SplashViewModel!
    private var timer: Timer?
    private let splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splashImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Inherits
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SplashViewModel()
        view.addSubview(splashImageView)
        splashImageView.constraintToSuperview()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.0, repeats: false, block: { [weak self] _ in
            if let viewModel = self?.viewModel {
                viewModel.toItems()
            }
        })
    }
}
