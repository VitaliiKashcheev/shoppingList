//
//  Dictionary.swift
//  shoppingListMain
//
//  Created by Виталий on 12/27/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit

struct Item{
    var code:Int
    var name:String
    var image:String
    var backgroundImage:String
}


class RemoteStorage: NSObject{

    var itemArray: Array = [
        Item(code:111, name:"FOOD", image:"food", backgroundImage:"bg"),
        Item(code:222, name:"TECHNIQUE", image:"technique", backgroundImage:"bg-1"),
        Item(code:333, name:"PHARMACY", image:"pharmacy", backgroundImage:"bg-2"),
        Item(code:444, name:"PARTY/EVENT", image:"event", backgroundImage:"bg-3"),
        Item(code:555, name:"MIX", image:"goods", backgroundImage:"bg-4"),
        ]
    
    func getItems() -> Array<Item>{
        return itemArray
    }
    
    func getItemCode(code:Int) -> Item?{
        for item in itemArray{
            if item.code == code{
                return item
            }
        }
        return nil
    }
}
