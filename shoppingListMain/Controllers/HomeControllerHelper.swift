//
//  HomeControllerHelper.swift
//  shoppingListMain
//
//  Created by Виталий on 12/14/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit

import CoreData

extension HomeController {
    
    func clearData() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do{
                let fetchRequestFriends: NSFetchRequest<Events> = Events.fetchRequest()
                
                let fetchFriend = try context.fetch(fetchRequestFriends)
                
                for friend in fetchFriend{
                    context.delete(friend)
                }
                
                let fetchRequest: NSFetchRequest<EventsProductList> = EventsProductList.fetchRequest()
                
                let fetchedMassage = try context.fetch(fetchRequest)
                
                for message in fetchedMassage{
                    context.delete(message)
                }
                
                try context.save()
               
            }catch let err{
                print(err)
            }
        }
        
    }
   
    static func createMassageWithText(text: String, friend: Events, context: NSManagedObjectContext) -> EventsProductList{
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "EventsProductList", into: context) as! EventsProductList
        message.event = friend
        message.text = text
        message.date = NSDate() as Date
        return message
    }
    
    
    func loadData(){
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            
            events = [Events]()
            
            if let friends = fetchFriends(){
            for friend in friends {
                print(friend.name as Any)
                
                let fetchReqest = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
                fetchReqest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                fetchReqest.predicate = NSPredicate(format: "guid = %@", friend.guid!)
                fetchReqest.fetchLimit = 1
                
                do{
                    let fetchMessages = try context.fetch(fetchReqest) as? [Events]
                    
                    events?.append(contentsOf: fetchMessages!)
                    
                }catch let err{
                    print(err)
                }
            }
                events = events?.sorted(by: {($0.date)?.compare($1.date! as Date) == .orderedDescending})
        }
    }
}
    
    private func fetchFriends() -> [Events]? {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
            
            do{
                
               return try context.fetch(request) as? [Events]
                
            }catch let err{
                print(err)
            }
        }
         return nil
    }
}
