//
//  SnackView.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import UIKit

protocol PSnackBarView: NSObjectProtocol {
    func closeSnackBar(_ snackBar: SnackView)
}

final class SnackView: UIView {
    
    // MARK: - Properties
    private var isLoaded: Bool = false
    private let label : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.clipsToBounds = true
        return lbl
    }()
   
    private var roundedView : UIView = {
        let view = UIView()
        view.backgroundColor = ColorManager.shared.color("Red")
        view.layer.cornerRadius = 8
        return view
    }()
    
    var text: String? {
        didSet {
            if isLoaded {
                label.text = text
            }
        }
    }
    
    // MARK: - Inherit
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutIfNeeded()
        updateRounded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    // MARK: - Public
    func initialize() {
        self.layer.zPosition = 1
        if let text = text {
            label.text = text
            roundedView.addSubview(label)
            label.constraintToSuperview(top: 8, bottom: 8, left: 8, right: 8)
        }
    }
    
    // MARK: - Actions
    fileprivate func updateRounded() {
        let radius = 5
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: roundedView.bounds,
                                byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: radius, height: radius))
        maskLayer.path = path.cgPath
        
        roundedView.layer.mask = maskLayer
    }
}
