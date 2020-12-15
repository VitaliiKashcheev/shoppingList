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
                let fetchRequestFriends: NSFetchRequest<Friend> = Friend.fetchRequest()
                
                let fetchFriend = try context.fetch(fetchRequestFriends)
                
                for friend in fetchFriend{
                    context.delete(friend)
                }
                
                let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
                
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
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            mark.name = "First category"
            mark.profileImageName = "pharmacy"
            mark.backgroundImageName = "bg-2"
            
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.friend = mark
            message.text = "First supermarket"
            message.date = NSDate() as Date
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Second category"
            steve.profileImageName = "technique"
            steve.backgroundImageName = "bg-1"
            
            let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageSteve.friend = steve
            messageSteve.text = "Second supermarket"
            messageSteve.date = NSDate() as Date
            
            do{
                try(context.save())
            }catch let err{
                print(err)
            }
            
//            events = [message,messageSteve]
        }

        loadData()
    }
    
    func loadData(){
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let fetchReqest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            
            do{
                try events = context.fetch(fetchReqest) as? [Message]
            }catch let err{
                print(err)
            }
        }
    }
}
