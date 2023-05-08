//
//  PickerView.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 04/05/2023.
//

import UIKit
import Combine

final class PickerView: UIView {
    
    // MARK: - Properties
    var picker: UIPickerView = UIPickerView.init()
    @Published var didSelect: Bool = false
    
    // MARK: - Inherit
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    // MARK: - private
    private func initialize() {
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: -UIScreen.main.bounds.size.width*0.5, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        addSubview(picker)
      
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.items = [UIBarButtonItem.init(title: localized("item.done"), style: .done, target: self, action: #selector(onButtonTapped))]
        addSubview(toolBar)
    }
    
    @objc private func onButtonTapped() {
        didSelect = true
    }
}

