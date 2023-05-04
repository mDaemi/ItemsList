//
//  ItemCollectionViewCell.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import UIKit



final class ItemCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var item: ItemUIModel? {
        didSet {
            update(with: item)
        }
    }
    
    private let itemImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = constraint.corderRadius
        imgView.image = UIImage(named: "place_holder")
        return imgView
    }()

    private var titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = FontConstant.boldNormal.getFont()
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        return lbl
    }()

    private var categoryLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = FontConstant.regularSmall.getFont()
        lbl.textAlignment = .left
        lbl.numberOfLines = 2
        lbl.clipsToBounds = true
        return lbl
    }()
    
    private var priceLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = FontConstant.boldNormal.getFont()
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()

    private let urgentView : UIView = {
        let view = UIView()
        view.frame.size.width = 150
        view.frame.size.height = 20
        let textLabel = UILabel()
        textLabel.text = "urgent"
        textLabel.textAlignment = .center
        textLabel.font = FontConstant.boldNormal.getFont()
        textLabel.textColor = ColorManager.shared.color("softBlack")
        view.addSubview(textLabel)
        textLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 3, paddingLeft: constraint.padding, paddingBottom: 3, paddingRight: constraint.padding)
        view.backgroundColor = ColorManager.shared.color("lightRed")
        view.layer.cornerRadius = constraint.corderRadius
        return view
    }()
    
    private var dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = FontConstant.regularTiny.getFont()
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    // MARK: - Overrides
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = constraint.corderRadius
        itemImage.addSubview(urgentView)
        urgentView.anchor(top: itemImage.topAnchor, left: nil, bottom: nil, right: itemImage.rightAnchor, paddingTop: constraint.padding, paddingLeft: 0, paddingBottom: 0, paddingRight: constraint.padding)
        
        addSubview(itemImage)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(categoryLabel)
        addSubview(dateLabel)
        
        itemImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: constraint.padding, paddingLeft: constraint.padding, paddingBottom: frame.height*0.4 , paddingRight: constraint.padding)
        
        titleLabel.anchor(top: itemImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: constraint.padding, paddingLeft: constraint.padding, paddingBottom: constraint.betweenlblPadding, paddingRight: constraint.padding)

        priceLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: constraint.betweenlblPadding, paddingLeft: constraint.padding, paddingBottom: constraint.betweenlblPadding, paddingRight: constraint.padding)

        categoryLabel.anchor(top: priceLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: constraint.betweenlblPadding, paddingLeft: constraint.padding, paddingBottom: constraint.betweenlblPadding, paddingRight: constraint.padding)
        
        dateLabel.anchor(top: categoryLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: constraint.betweenlblPadding, paddingLeft: constraint.padding, paddingBottom: 0, paddingRight: constraint.padding)
    }
    
    // MARK: - private
    private func update(with item: ItemUIModel?) {
        titleLabel.text = item?.title
        categoryLabel.text = item?.category_name
        dateLabel.text = item?.creation_date
        priceLabel.text = item?.price
        
        if let image = item?.images_url, let imageStr = image.thumb, let url = URL(string: imageStr) {
            itemImage.load(url: url)
        }
        
        if let isUrgent = item?.is_urgent, !isUrgent {
            urgentView.isHidden = true
        } else {
            urgentView.isHidden = false
        }
    }
}
