//
//  ProductListControllerHelper.swift
//  shoppingListMain
//
//  Created by Виталий on 1/18/21.
//  Copyright © 2021 Виталий. All rights reserved.
//

import UIKit

import CoreData

extension ProductListController{
    
    func loadData(){
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            
            messages = [EventsProductList]()
            
            if let friends = fetchFriends(){
                
                for friend in friends {
                    print(friend.text as Any)
                    
                    let fetchReqest = NSFetchRequest<NSFetchRequestResult>(entityName: "EventsProductList")
                    fetchReqest.sortDescriptors = [NSSortDescriptor(key: "text", ascending: false)]
                    fetchReqest.predicate = NSPredicate(format: "text = %@", friend.text!)
                    fetchReqest.fetchLimit = 1
                    
                    
                    do{
                        let fetchMessages = try context.fetch(fetchReqest) as? [EventsProductList]
                        
                        messages?.append(contentsOf: fetchMessages!)
                        
                    }catch let err{
                        print(err)
                    }
                }
                
                messages = messages?.sorted(by: {($0.text)?.compare($1.text!) == .orderedDescending})
            }
            
            
        }
    }
    
    private func fetchFriends() -> [EventsProductList]? {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "EventsProductList")
            
            do{
                
                return try context.fetch(request) as? [EventsProductList]
                
            }catch let err{
                print(err)
            }
        }
        return nil
    }
}
