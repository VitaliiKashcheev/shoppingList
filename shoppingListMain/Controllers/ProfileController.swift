//
//  ProfileController.swift
//  shoppingListMain
//
//  Created by Виталий on 8/13/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return(mb)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        tabBarController?.tabBar.backgroundColor = .white
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        tabBarController?.tabBar.backgroundColor = .clear
//    }

}


