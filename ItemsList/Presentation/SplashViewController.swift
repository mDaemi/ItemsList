//
//  SplashViewController.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import UIKit

final class SplashViewController: AbstractViewController {
    // MARK: - properties
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
        
        view.addSubview(splashImageView)
        splashImageView.constraintToSuperview()
        
//        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { [weak self] _ in
//            AppNavigator(services: UseCaseProvider(), navigationController: UINavigationController())
//        })
    }
}
