//
//  addButton.swift
//  shoppingListTableView
//
//  Created by Виталий on 7/24/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import  UIKit

class AddButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addButton()
    }
    
    func addButton() {
        backgroundColor = UIColor(patternImage: UIImage(named: "createList")!)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonConstraints()
    }
    
    func buttonConstraints(){
        guard let superView = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.centerXAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        self.layer.cornerRadius = 30
        self.layer.shadowOffset = CGSize(width:0, height:5)
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOpacity = 0.3
    }
    
}
