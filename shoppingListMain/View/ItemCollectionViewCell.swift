//
//  ItemCollectionViewCell.swift
//  SwipeableCollectionViewCell
//
//  Created by Виталий on 7/24/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit
import CoreData

class ItemCollectionViewCell: SwipeableCollectionViewCell {
   
    
    var message: EventsProductList? {
        didSet{
            
            nameLabel.text = message?.event?.name
            
            categoryLable.text = message?.event?.category
            
            if let profileImageName = message?.event?.profileImageName{
            categoryImage.image = UIImage(named: profileImageName)
            }
            
            if let backgroundImageName = message?.event?.backgroundImageName{
                categoryBackgroundImage.image = UIImage(named: backgroundImageName)
            }
            
//            nameLabel.text = message?.text
            
            if let date = message?.date{
                let formatter = DateFormatter()
                formatter.dateFormat = "d MMM yyyy"
                
                dateLable.text = formatter.string(for: date)
            }
        }
    }
    
    // Properties

    let cellView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 8
        return cv
    }()
    
    let categoryBackgroundImage: UIImageView = {
        let image = UIImage(named: "bg-1")
        let imageWiew = UIImageView(image: image)
        return imageWiew
    }()
    
    let categoryImage: UIImageView = {
        let image = UIImage(named: "technique")
        let imageWiew = UIImageView(image: image)
        return imageWiew
    }()

    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        label.text = "Name Label"
        label.textAlignment = .left
        return label
    }()
 
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        label.text = "0 UAH"
        label.textAlignment = .right
        return label
    }()
    
    let categoryLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        label.text = "CATEGORY"
        label.textAlignment = .left
        return label
    }()
    
    let dateLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        label.text = formatter.string(from: date as Date)
        label.textAlignment = .right
        return label
    }()
    
    let firstHiddenButtonImage: UIImageView = {
        let image = UIImage(named: "shareLight")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        return imageView
    }()

    
    let secondHiddenButtonImage: UIImageView = {
        let image = UIImage(named: "archiveLight")?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        return imageView
    }()
    
    
    
    // Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  Constraints
    
    private func setupSubviews() {
        
        visibleContainerView.backgroundColor = .clear
        
        visibleContainerView.addSubview(cellView)
        cellView.topAnchor.constraint(equalTo: visibleContainerView.topAnchor, constant: 0).isActive = true
        cellView.bottomAnchor.constraint(equalTo: visibleContainerView.bottomAnchor, constant: 0).isActive = true
        cellView.leftAnchor.constraint(equalTo: visibleContainerView.leftAnchor, constant: 16).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.addSubview(categoryBackgroundImage)
        categoryBackgroundImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8).isActive = true
        categoryBackgroundImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8).isActive = true
        categoryBackgroundImage.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 8).isActive = true
        categoryBackgroundImage.widthAnchor.constraint(equalToConstant: 56).isActive = true
        categoryBackgroundImage.heightAnchor.constraint(equalToConstant: 56).isActive = true
        categoryBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        categoryBackgroundImage.addSubview(categoryImage)
        categoryImage.centerXAnchor.constraint(equalTo: categoryBackgroundImage.centerXAnchor).isActive = true
        categoryImage.centerYAnchor.constraint(equalTo: categoryBackgroundImage.centerYAnchor).isActive = true
        categoryImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        categoryImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -45).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 80).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        cellView.addSubview(priceLabel)
        priceLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 9).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -46).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -16).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        cellView.addSubview(categoryLable)
        categoryLable.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 47).isActive = true
        categoryLable.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8).isActive = true
        categoryLable.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 80).isActive = true
        categoryLable.heightAnchor.constraint(equalToConstant: 17).isActive = true
        categoryLable.translatesAutoresizingMaskIntoConstraints = false

        cellView.addSubview(dateLable)
        dateLable.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 47).isActive = true
        dateLable.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8).isActive = true
        dateLable.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -16).isActive = true
        dateLable.heightAnchor.constraint(equalToConstant: 17).isActive = true
        dateLable.translatesAutoresizingMaskIntoConstraints = false

        visibleContainerView.addSubview(firstHiddenButton)
        firstHiddenButton.backgroundColor = .white
        firstHiddenButton.layer.cornerRadius = 16
        firstHiddenButton.widthAnchor.constraint(equalToConstant: 72).isActive = true
        firstHiddenButton.heightAnchor.constraint(equalToConstant: 72).isActive = true
        firstHiddenButton.leadingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        firstHiddenButton.translatesAutoresizingMaskIntoConstraints = false
        
        firstHiddenButton.addSubview(firstHiddenButtonImage)
        firstHiddenButtonImage.translatesAutoresizingMaskIntoConstraints = false
        firstHiddenButtonImage.centerXAnchor.constraint(equalTo: firstHiddenButton.centerXAnchor).isActive = true
        firstHiddenButtonImage.centerYAnchor.constraint(equalTo: firstHiddenButton.centerYAnchor).isActive = true
        firstHiddenButtonImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        firstHiddenButtonImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        visibleContainerView.addSubview(secondHiddenButton)
        secondHiddenButton.backgroundColor = .white
        secondHiddenButton.layer.cornerRadius = 16
        secondHiddenButton.widthAnchor.constraint(equalToConstant: 72).isActive = true
        secondHiddenButton.heightAnchor.constraint(equalToConstant: 72).isActive = true
        secondHiddenButton.leftAnchor.constraint(equalTo: firstHiddenButton.rightAnchor, constant: 16).isActive = true
        secondHiddenButton.translatesAutoresizingMaskIntoConstraints = false

        secondHiddenButton.addSubview(secondHiddenButtonImage)
        secondHiddenButtonImage.translatesAutoresizingMaskIntoConstraints = false
        secondHiddenButtonImage.centerXAnchor.constraint(equalTo: secondHiddenButton.centerXAnchor).isActive = true
        secondHiddenButtonImage.centerYAnchor.constraint(equalTo: secondHiddenButton.centerYAnchor).isActive = true
        secondHiddenButtonImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        secondHiddenButtonImage.heightAnchor.constraint(equalToConstant: 24).isActive = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if scrollView.contentOffset.x > 0 {
            scrollView.contentOffset.x = 0
            print(scrollView.contentOffset.x)
            
        }
    }
    
    
}
