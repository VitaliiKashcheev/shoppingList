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
    
    func setupData(text: String) {
        
//        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Events", into: context) as! Events
            mark.category = text
            mark.profileImageName = "pharmacy"
            mark.backgroundImageName = "bg-2"

            let message = NSEntityDescription.insertNewObject(forEntityName: "EventsProductList", into: context) as! EventsProductList
            message.event = mark
            message.text = "First supermarket"
            message.date = NSDate() as Date
//
//
//            let steve = NSEntityDescription.insertNewObject(forEntityName: "Events", into: context) as! Events
//            steve.name = "Second category"
//            steve.profileImageName = "technique"
//            steve.backgroundImageName = "bg-1"
//
//            createMassageWithText(text: "Hello", friend: steve , context: context)
//            createMassageWithText(text: "i'm", friend: steve , context: context)
//            createMassageWithText(text: "Ok", friend: steve , context: context)

 
            do{
                try(context.save())
            }catch let err{
                print(err)
            }
            
        }

        loadData()
    }
    
    private func createMassageWithText(text: String, friend: Events, context: NSManagedObjectContext){
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "EventsProductList", into: context) as! EventsProductList
        message.event = friend
        message.text = text
        message.date = NSDate() as Date
        
    }
    
    func loadData(){
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            
            events = [EventsProductList]()
            
            if let friends = fetchFriends(){
            for friend in friends {
                print(friend.name as Any)
                
                let fetchReqest = NSFetchRequest<NSFetchRequestResult>(entityName: "EventsProductList")
                fetchReqest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                fetchReqest.predicate = NSPredicate(format: "event.name = %@", friend.name!)
                fetchReqest.fetchLimit = 1
                
                
                do{
                    let fetchMessages = try context.fetch(fetchReqest) as? [EventsProductList]
                    
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
