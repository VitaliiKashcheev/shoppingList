//
//  AddEventsController.swift
//  shoppingListMain
//
//  Created by Виталий on 12/28/20.
//  Copyright © 2020 Виталий. All rights reserved.
//

import UIKit

protocol addEvents_Delegate {
    
    func addString(nameString: EvetsStruct)
}

class AddEventsController: UIViewController{
    
    let texField: UITextField = {
        let tf = UITextField()
        tf.frame = CGRect(x: 20, y: 100, width: 300, height: 40)
        tf.placeholder = "Enter text here"
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        tf.delegate = self as? UITextFieldDelegate
        return tf
    }()
    
    let menuBar: AddEventsControllerView = {
        let mb = AddEventsControllerView()
        return(mb)
    }()
    
    var delegate: addEvents_Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
        
        let buttonSave = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector (actionSaveButton(sender:)))
        self.navigationItem.rightBarButtonItem  = buttonSave
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector (cancelButton(sender:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        
        view.addSubview(texField)
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.heightAnchor.constraint(equalToConstant: 160).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
        //        menuBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        menuBar.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    @objc func actionSaveButton(sender: UIButton){
        
        guard let nameText = texField.text, texField.hasText else{
            print("No Text")
            return
        }
        
        guard let itemCode = menuBar.code, menuBar.code != nil else{
            print("No code")
            return
        }
        
        let evensStruct = EvetsStruct(itemCode: itemCode, texfieldString: nameText)

        delegate?.addString(nameString: evensStruct)

    }
    
    @objc func cancelButton(sender: UIButton){
        
        self.dismiss(animated: true, completion: nil)
        
    }

    private func setupBar(){
        
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.heightAnchor.constraint(equalToConstant: 160).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -30).isActive = true
//        menuBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        menuBar.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
}


class AddEventsControllerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let screenBounds = UIScreen.main.bounds
    
    var remoteStorage = RemoteStorage()
    
    var code:Int?
    
    var arrayItem:Array<Item> = []
    
    let idCell = "idCell"
    
    let textfieldView: UIView = {
        let cv = UIView()
        cv.backgroundColor = UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        return cv
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        
        return(cv)
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        collectionView.register(EventsCell.self, forCellWithReuseIdentifier: idCell)
        
        addSubview(collectionView)
        collectionView.pinEdgesToSuperView()
        
        setupBar()

//        let selectIndexPath = NSIndexPath(item: 0, section: 0)
//        collectionView.selectItem(at: selectIndexPath as IndexPath, animated: false, scrollPosition: .left )

        arrayItem = remoteStorage.getItems()

        
    }
    
    private func setupBar(){
        
        addSubview(textfieldView)
        textfieldView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        roundCorners([.bottomLeft, .bottomRight], radius: 20.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as! EventsCell
        
        cell.menuLable.text = arrayItem[indexPath.item].name
        cell.categoryImage.image = UIImage(named: arrayItem[indexPath.row].image)
        cell.categoryBackgroundImage.image = UIImage(named: arrayItem[indexPath.row].backgroundImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let screenWidth = (screenSize.width/5)-4
//        return CGSize(width: screenWidth, height: screenWidth);
        let screenWidth = (frame.width / 5)
        return CGSize(width: screenWidth, height: screenWidth)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let codeArray = arrayItem[indexPath.item].code
        
        code = codeArray
        
        print(codeArray)
        
    }
    
}

class EventsCell: UICollectionViewCell {
    
    let cellView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 8
        return cv
    }()
    
    let categoryBackgroundImage: UIImageView = {
        let image = UIImage(named: "bg-1")
        let imageWiew = UIImageView(image: image)
        return imageWiew
    }()
    
    let categoryImage: UIImageView = {
        let image = UIImage(named: "technique")
        let imageWiew = UIImageView(image: image)
        return imageWiew
    }()
    
    let menuLable: UILabel = {
        let im = UILabel()
        im.text = ""
        im.textColor = UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        im.textAlignment = .center
        im.font = im.font.withSize(10)
        return im
    }()
    
    override var isHighlighted: Bool{
        didSet{
            menuLable.textColor = isHighlighted ? UIColor.black : UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            menuLable.textColor = isSelected ? UIColor.black : UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        
        addSubview(cellView)
        cellView.pEdgesToSuperView()
        
        cellView.addSubview(categoryBackgroundImage)
        categoryBackgroundImage.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8).isActive = true
        categoryBackgroundImage.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -8).isActive = true
        categoryBackgroundImage.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 8).isActive = true
        categoryBackgroundImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -16).isActive = true
        categoryBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        categoryBackgroundImage.addSubview(categoryImage)
        categoryImage.centerXAnchor.constraint(equalTo: categoryBackgroundImage.centerXAnchor).isActive = true
        categoryImage.centerYAnchor.constraint(equalTo: categoryBackgroundImage.centerYAnchor).isActive = true
        categoryImage.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.addSubview(menuLable)
        menuLable.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -3).isActive = true
        menuLable.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 3).isActive = true
        menuLable.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -3).isActive = true
        menuLable.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        menuLable.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

