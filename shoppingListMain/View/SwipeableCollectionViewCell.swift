//
//  SwipeableCollectionViewCell.swift
//  SwipeableCollectionViewCell
//
//  Created by Виталий on 7/24/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit

protocol SwipeableCollectionViewCellDelegate: class {
    func visibleContainerViewTapped(inCell cell: UICollectionViewCell)
    func hiddenContainerViewTapped(inCell cell: UICollectionViewCell)
    func secondContainerViewTapped(inCell cell: UICollectionViewCell)

}

class SwipeableCollectionViewCell: UICollectionViewCell {
    
    // Properties
    
     let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let visibleContainerView = UIView()
    let secondHiddenButton = UIView()
    let firstHiddenButton = UIView()
    let stackView = UIStackView()
    let size: Float = 176
    let screenBounds = Float(CGFloat(UIScreen.main.bounds.width))
    
    weak var delegate: SwipeableCollectionViewCellDelegate?
    
    // Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(visibleContainerView)
        
        addSubview(scrollView)
        scrollView.pEdgesToSuperView()
        scrollView.addSubview(stackView)
        stackView.pEdgesToSuperView()
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1 + CGFloat(size / screenBounds)).isActive = true
    }
    
    private func setupGestureRecognizer() {
        let hiddenContainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hiddenContainerViewTapped))
        secondHiddenButton.addGestureRecognizer(hiddenContainerTapGestureRecognizer)
        
        let visibleContainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(visibleContainerViewTapped))
        visibleContainerView.addGestureRecognizer(visibleContainerTapGestureRecognizer)
        
        let secondContainerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(secondContainerViewTapped))
        firstHiddenButton.addGestureRecognizer(secondContainerTapGestureRecognizer)

        
    }
    
    @objc private func visibleContainerViewTapped() {
        delegate?.visibleContainerViewTapped(inCell: self)
    }
    
    @objc private func hiddenContainerViewTapped() {
        delegate?.hiddenContainerViewTapped(inCell: self)
    }
    
    @objc private func secondContainerViewTapped() {
        delegate?.secondContainerViewTapped(inCell: self)
    }



}
