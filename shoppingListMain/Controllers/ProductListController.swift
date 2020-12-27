//
//  ProductListController.swift
//  shoppingListMain
//
//  Created by Виталий on 12/15/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit

class ProductListController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    
    var friend: Events?{
        
        didSet{
            
            navigationItem.title = friend?.name
            
            messages = friend?.messages?.allObjects as? [EventsProductList]
        }
    }
    
    var messages:[EventsProductList]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count{
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)

        cell.backgroundColor = .red
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width, height: 20)
        return size
    }
    
}
