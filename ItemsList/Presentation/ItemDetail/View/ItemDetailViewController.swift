//
//  ItemDetailViewController.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import UIKit

final class ItemDetailViewController: AbstractViewController {
    // MARK: - PROPERTIES
    let item: ItemUIModel
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let priceLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = FontConstant.regularMedium.getFont()
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        lbl.clipsToBounds = true
        return lbl
    }()
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = FontConstant.boldNormal.getFont()
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.clipsToBounds = true
        return lbl
    }()
    
    private let categoryLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = FontConstant.boldNormal.getFont()
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.clipsToBounds = true
        return lbl
    }()
    
    private let dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = FontConstant.regularSmall.getFont()
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = FontConstant.regularSmall.getFont()
        lbl.textAlignment = .justified
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let itemImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let urgentView : UIView = {
        let view = UIView()
        let textLabel = UILabel()
        textLabel.text = localized("item.urgent")
        textLabel.textAlignment = .center
        textLabel.font = FontConstant.boldMedium.getFont()
        textLabel.textColor = ColorManager.shared.color("softBlack")
        view.addSubview(textLabel)
        textLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 3, paddingLeft: constraint.padding, paddingBottom: 3, paddingRight: constraint.padding)
        view.backgroundColor = ColorManager.shared.color("lightRed")
        view.layer.cornerRadius = constraint.corderRadius
        return view
    }()
    
    override func loadView() {
        let width = UIScreen.main.bounds.width
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        containerView.addSubview(itemImage)
        containerView.addSubview(urgentView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(descriptionLabel)
        
        itemImage.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: width)
        
        urgentView.anchor(top: itemImage.topAnchor, left: nil, bottom: nil, right: itemImage.rightAnchor, paddingTop: constraint.paddingBig, paddingLeft: 0, paddingBottom: 0, paddingRight: constraint.paddingBig)
        
        categoryLabel.anchor(top: itemImage.bottomAnchor, left: containerView.leftAnchor, bottom: titleLabel.topAnchor, right: containerView.rightAnchor, paddingTop: constraint.paddingBig, paddingLeft: constraint.paddingBig, paddingBottom: constraint.padding, paddingRight: constraint.padding)
       
        titleLabel.anchor(top: categoryLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: constraint.padding, paddingLeft: constraint.paddingBig, paddingBottom: 0, paddingRight: constraint.paddingBig)
        
        priceLabel.anchor(top: titleLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: constraint.padding, paddingLeft: constraint.paddingBig, paddingBottom: 0, paddingRight: 0)
        
        dateLabel.anchor(top: titleLabel.bottomAnchor, left: nil, bottom: nil, right:  containerView.rightAnchor, paddingTop: constraint.padding, paddingLeft: 0, paddingBottom: 0, paddingRight: constraint.paddingBig)
        
        descriptionLabel.anchor(top: priceLabel.bottomAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right:  containerView.rightAnchor, paddingTop: constraint.paddingNormal, paddingLeft: constraint.paddingBig, paddingBottom: constraint.paddingBig, paddingRight: constraint.paddingBig)
    }
    
    // MARK: - INIT
    init(_ item: ItemUIModel) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        
        titleLabel.text = item.title
        titleLabel.textColor = .black
        categoryLabel.text = item.category_name
        urgentView.isHidden = !item.is_urgent
        descriptionLabel.text = item.description
        
        if let imageURL = item.images_url, let imageStr = imageURL.thumb {
            itemImage.loadImage(urlString: imageStr,
                                placeholderImage: UIImage(named: "place_holder"),
                                errorImage: UIImage(named: "place_holder"))
        }
        dateLabel.text = item.creation_date
        priceLabel.text = item.price
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
