//
//  menuBar.swift
//  shoppingListTableView
//
//  Created by Виталий on 7/30/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let screenBounds = UIScreen.main.bounds
    
    var remoteStorage = RemoteStorage()
    
    var arrayItem:Array<Item> = []

    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        cv.dataSource = self
        cv.delegate = self

        return(cv)
    }()

    let cellIdd = "cellIdd"
    
    let menuLableTabs = ["ALL", "PERSONAL", "SHARED", "ARCHIVE"]

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellIdd)
        
        addSubview(collectionView)
        collectionView.pinEdgesToSuperView()
        
        let selectIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectIndexPath as IndexPath, animated: false, scrollPosition: .left )
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners([.bottomLeft, .bottomRight], radius: 20.0)
        menuBarConstrains()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdd, for: indexPath) as! MenuCell
        
        cell.menuLable.text = menuLableTabs[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func menuBarConstrains(){
        guard let superView = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: superView.frame.width).isActive = true
        self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
    }
    
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

}

class MenuCell: UICollectionViewCell {

    let menuLable: UILabel = {
        let im = UILabel()
        im.text = ""
//        im.tintColor = UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        im.textColor = UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        im.font = im.font.withSize(14)
        return im
    }()
    
    override var isHighlighted: Bool{
        didSet{
            menuLable.textColor = isHighlighted ? UIColor.white : UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            menuLable.textColor = isSelected ? UIColor.white : UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupView()
    }
    
    func setupView(){
        
        addSubview(menuLable)
        menuLable.heightAnchor.constraint(equalToConstant: 14).isActive = true
        menuLable.pinToSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
