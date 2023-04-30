//
//  LoadingView.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import UIKit

final class LoadingView: UIView {
    
    // MARK: - Properties
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Inherit
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    // MARK: - Public
    func start() {
        self.activityIndicator.startAnimating()
    }

    func stop() {
        self.activityIndicator.stopAnimating()
    }
    
    func initialize() {
        self.activityIndicator.style = .large
        self.activityIndicator.color = .gray
        addSubview(activityIndicator)
        activityIndicator.constraintToSuperview(centerX: 0, centerY: 0)
    }
}
