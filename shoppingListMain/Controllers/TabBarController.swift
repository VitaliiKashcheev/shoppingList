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
    
    var centerButton:AddButton = {
        let cb = AddButton()
        return cb
    }()
    
    private var centerButtonTappedOnce:Bool = false;
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .black
        
        self.delegate = self
        
        let resentMassageNavController = UINavigationController(rootViewController: HomeController())
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
        
        self.setupMiddleButton()

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
    
    private func setupMiddleButton()
    {
        view.addSubview(centerButton)
        centerButton.addTarget(self, action: #selector(centerButtonAction(sender:)), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    
    private func bringcenterButtonToFront()
    {
        print("bringcenterButtonToFront called...")
        self.view.bringSubviewToFront(self.centerButton);
    }
    
    


}



