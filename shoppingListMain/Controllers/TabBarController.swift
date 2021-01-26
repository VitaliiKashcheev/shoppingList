//
//  TabBarController.swift
//  shoppingListMain
//
//  Created by Виталий on 8/10/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit

protocol CustomTabBarControllerDelegate
{
    func customTabBarControllerDelegate_CenterButtonTapped(tabBarController:TabBarController, button:UIButton, buttonState:Bool);
}

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let tabBarView: TabBarView = {
        let tb = TabBarView()
        return tb
    }()
    
    var customTabBarControllerDelegate:CustomTabBarControllerDelegate?;
    
    var centerButton:UIButton = {
        let cb = UIButton()
        cb.backgroundColor = UIColor(patternImage: UIImage(named: "createList")!)
        return cb
    }()
    
    private var centerButtonTappedOnce:Bool = false;
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .black
        
        self.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let resentMassageNavController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        resentMassageNavController.tabBarItem.tag = 1
        resentMassageNavController.tabBarItem.image = UIImage(named: "list")
        
        let secondController = ProfileController()
        secondController.tabBarItem.tag = 2
        secondController.tabBarItem.image = UIImage(named: "profile")
        
        
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .clear
        tabBar.addSubview(tabBarView)

        tabBarView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        viewControllers = [resentMassageNavController,secondController]
        
        tabBar.addSubview(centerButton)
        centerButton.addTarget(self, action: #selector(centerButtonAction(sender:)), for: .touchUpInside)
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor).isActive = true
        centerButton.topAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: -80).isActive = true
        centerButton.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: -20).isActive = true
        centerButton.layer.cornerRadius = 30
        centerButton.layer.shadowOffset = CGSize(width:0, height:5)
        centerButton.layer.shadowRadius = 5
        centerButton.layer.shadowColor = UIColor.red.cgColor
        centerButton.layer.shadowOpacity = 0.3
    }
    
//    override func viewWillLayoutSubviews() {
//        var tabFrame = self.tabBar.frame
//        // - 40 is editable , the default value is 49 px, below lowers the tabbar and above increases the tab bar size
//        tabFrame.size.height = 56
//        tabFrame.origin.y = self.view.frame.size.height - 56
//        self.tabBar.frame = tabFrame
//    }
    
    @objc private func centerButtonAction(sender: UIButton){
    
      customTabBarControllerDelegate?.customTabBarControllerDelegate_CenterButtonTapped(tabBarController: self,button: centerButton,buttonState: centerButtonTappedOnce);
        
    }
    
    func setupMiddleButton() {
        tabBar.addSubview(centerButton)
        tabBar.bringSubviewToFront(centerButton)
        centerButton.addTarget(self, action: #selector(centerButtonAction(sender:)), for: .touchUpInside)
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        centerButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        centerButton.centerXAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.centerXAnchor).isActive = true
        centerButton.topAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        centerButton.bottomAnchor.constraint(equalTo: tabBar.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        centerButton.layer.cornerRadius = 30
        centerButton.layer.shadowOffset = CGSize(width:0, height:5)
        centerButton.layer.shadowRadius = 5
        centerButton.layer.shadowColor = UIColor.red.cgColor
        centerButton.layer.shadowOpacity = 0.3
    }
    
    private func bringcenterButtonToFront() {
        
        print("bringcenterButtonToFront called...")
        self.view.bringSubviewToFront(self.centerButton);
    }

}



