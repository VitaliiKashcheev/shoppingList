//
//  ViewController.swift
//  shoppingListMain
//
//  Created by Виталий on 7/16/20.
//  Copyright © 2020 Виталий. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class HomeController: UIViewController, CustomTabBarControllerDelegate {
    
    fileprivate let cellId = "id"
    
    var events: [Message]?
        
    //Add menu Bar
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return(mb)
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 66, left: 0, bottom: 16, right: 0)
        collectionView.backgroundColor = UIColor(white: 0.97, alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.tabBarController as! TabBarController).customTabBarControllerDelegate = self;

        
        // Navigation Bar
        let nav = self.navigationController?.navigationBar
        nav?.isTranslucent = false
        nav?.barTintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
//        nav?.prefersLargeTitles = true
        
        // Title lable
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 44, height: view.frame.height))
        titleLable.text = "List"
        titleLable.textColor = UIColor.white
        titleLable.font = UIFont.systemFont(ofSize: 24)
        titleLable.font = UIFont.boldSystemFont(ofSize: 24)
        navigationItem.titleView = titleLable
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        collectionView.pinEdgesToSuperView()
        
        view.addSubview(menuBar)
        
        setupData()
//        UIApplication.shared.keyWindow!.addSubview(addButton)
//        UIApplication.shared.keyWindow!.bringSubviewToFront(addButton)
    }
    
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            as! ItemCollectionViewCell
        
        if let message = events?[indexPath.item] {
            cell.message = message
        }
        
        cell.delegate = self
        cell.layoutSubviews()
        
        // Configure the cell
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = events?.count{
            return count
        }
        return 0
    }
    
    func addButtonAction() {
        let alert = UIAlertController(title: "Add List", message: nil, preferredStyle: .alert)
        alert.addTextField { (dessertTF) in dessertTF.placeholder = "Enter"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in guard let event = alert.textFields?.first?.text else{return}
            print(event)
//            self.events?.insert(Message, at:0)
//            self.setupData()
            self.collectionView.reloadData()
            
        }
        alert.addAction(action)
        present(alert, animated: true)
//        ItemCollectionViewCell.nameLabel
    
    }
    
    func customTabBarControllerDelegate_CenterButtonTapped(tabBarController: TabBarController, button: UIButton, buttonState: Bool) {
        
        //        tabBarController.tabBar.isHidden = true
        //        tabBarController.centerButton.isHidden = true
        self.tabBarController?.selectedIndex = 0
        
        addButtonAction()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width, height: 72)
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

}

extension HomeController: SwipeableCollectionViewCellDelegate {
    func hiddenContainerViewTapped(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        events?.remove(at: indexPath.item)
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])
        })
        
    }
    
    func visibleContainerViewTapped(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        print("Tapped item at index path: \(indexPath)")
    }
    
    func secondContainerViewTapped(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        events?.remove(at: indexPath.item)
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])
        })
    }
}


