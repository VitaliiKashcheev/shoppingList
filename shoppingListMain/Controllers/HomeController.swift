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

struct EvetsStruct {
    
    var itemCode:Int
    
    var texfieldString: String
}


class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CustomTabBarControllerDelegate {
    
    fileprivate let cellId = "id"

    var events: [EventsProductList]?
    
    var remoteStorage = RemoteStorage()
    
    var array:Array<Item> = []
    
    var stringName:String?

//Add menu Bar
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return(mb)
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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(image: UIImage(named: "onDarkSearchLight"), style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = .white

//        nav?.prefersLargeTitles = true
        
        // Title lable
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 44, height: view.frame.height))
        titleLable.text = "List"
        titleLable.textColor = UIColor.white
        titleLable.font = UIFont.systemFont(ofSize: 24)
        titleLable.font = UIFont.boldSystemFont(ofSize: 24)
        navigationItem.titleView = titleLable
        

        collectionView?.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        collectionView?.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsets(top: 66, left: 0, bottom: 16, right: 0)
        collectionView?.backgroundColor = UIColor(white: 0.97, alpha: 1)
//        collectionView?.dataSource = self
//        collectionView?.delegate = self
        
        setupMenuBar()
        loadData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        tabBarController?.tabBar.isHidden = false
    }
    
    //    private func setupNavigationButton(){
    //        let btn1 = UIButton(type: .custom)
    //        btn1.setImage(UIImage(named: "imagename"), for: .normal)
    //        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    //        btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
    //        let item1 = UIBarButtonItem(customView: btn1)
    //
    //        let btn2 = UIButton(type: .custom)
    //        btn2.setImage(UIImage(named: "imagename"), for: .normal)
    //        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    //        btn2.addTarget(self, action: #selector(Class.MethodName), for: .touchUpInside)
    //        let item2 = UIBarButtonItem(customView: btn2)
    //
    //        self.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
    //    }


    
    private func setupMenuBar(){
        
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        menuBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = events?.count{
            return count
        }
        return 0
    
    }
    
    func addButtonAction(){

        let controller = AddEventsController()
        self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        tabBarController?.tabBar.isHidden = true
        controller.delegate = self
        print("On Click")
    }
    
    
    func customTabBarControllerDelegate_CenterButtonTapped(tabBarController: TabBarController, button: UIButton, buttonState: Bool) {
        
        self.tabBarController?.selectedIndex = 0
        
        addButtonAction()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width, height: 72)
        return size
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

}

extension HomeController: addEvents_Delegate{
    
    func addString(nameString: EvetsStruct) {
        self.dismiss(animated: true){
            let delegate = UIApplication.shared.delegate as? AppDelegate
            
            if let context = delegate?.persistentContainer.viewContext {
                let code = self.remoteStorage.getItemCode(code: nameString.itemCode)
//                print(code?.name as Any)

                let eventList = NSEntityDescription.insertNewObject(forEntityName: "Events", into: context) as! Events
                eventList.name = nameString.texfieldString
                eventList.category = code?.name
                eventList.profileImageName = code?.image
                eventList.backgroundImageName = code?.backgroundImage

                let message = NSEntityDescription.insertNewObject(forEntityName: "EventsProductList", into: context) as! EventsProductList
                message.event = eventList
//                message.text =
                message.date = NSDate() as Date

                do{
                    try(context.save())

                    self.events?.append(message)

                    self.collectionView.reloadData()

                    self.loadData()

                }catch let err{
                    print(err)
                }
             }
        }
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
        let layout = UICollectionViewFlowLayout()
        let controller = ProductListController(collectionViewLayout: layout)
        controller.friend = events?[indexPath.item].event
        navigationController?.pushViewController(controller, animated: true)
        print("Tapped item at index path: \(indexPath)")
    }
    
    
    func secondContainerViewTapped(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])

            let delegate = UIApplication.shared.delegate as? AppDelegate

            if let context = delegate?.persistentContainer.viewContext {

                do{
                    
                    let fetchRequestFriends: NSFetchRequest<Events> = Events.fetchRequest()

                    let fetchFriend = try context.fetch(fetchRequestFriends)
                    
                    let fr = events?[indexPath.item].event
                    
                    for _ in fetchFriend{
                    context.delete(fr!)
                    }
                    
                    events?.remove(at: indexPath.item)
                    try(context.save())
//                    self.collectionView.reloadData()

                }catch let err{
                    print(err)
                }
            }
        })
    }
 }


