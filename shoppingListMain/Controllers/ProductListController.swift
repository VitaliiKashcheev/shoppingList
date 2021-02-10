//
//  ProductListController.swift
//  shoppingListMain
//
//  Created by Виталий on 12/15/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit

class ProductListController: UITableViewController {
    
    private let cellId = "cellId"
    
    var checkButton:UIButton = {
        let cb = UIButton(frame: CGRect(x: 100, y: 400, width: 60, height: 60))
        cb.backgroundColor = UIColor(patternImage: UIImage(named: "createList")!)
        cb.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)

        return cb
    }()
    
    
    var friend: Events?{
        
        didSet{
            
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [EventsProductList]
        }
    }
    
    var messages:[EventsProductList]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector (cancelButton(sender:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector (addButton(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)



        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
//        tableView?.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.tableView.reloadData()
//        view.addSubview(checkButton)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @objc func buttonClicked() {
        loadData()
        print("Button Clicked")
    }

    
    @objc func cancelButton(sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func addButton(sender: UIButton){
        
        let alert = UIAlertController(title: "Add List", message: nil, preferredStyle: .alert)
        alert.addTextField { (dessertTF) in dessertTF.placeholder = "Enter"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in guard let event = alert.textFields?.first?.text else{return}
        

                let delegate = UIApplication.shared.delegate as? AppDelegate
            
                let context = delegate?.persistentContainer.viewContext
            
                    let message = HomeController.createMassageWithText(text: event, friend: self.friend!, context: context!)
            
                do{
                    try context?.save()
                    
                    self.messages?.insert(message, at: 0)
                    
                    self.tableView.reloadData()
                    
                }catch let err{
                    print(err)
                }
            
        }
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = messages?.count{
            return count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = messages?[indexPath.item].text
        
        return cell
    }
    
   
}

class TableCell: UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        label.text = "my text"
        label.textAlignment = .right
        return label
    }()
    
    func setupView(){
        addSubview(nameLabel)
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 16).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo:superView.centerYAnchor).isActive = true
    }
    
}
