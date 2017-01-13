//
//  MenuBar.swift
//  youtube
//
//  Created by Daria on 16.12.16.
//  Copyright © 2016 Daria. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let imageNames = ["home","trending","subscriptions","library"]
    
    var homeController: HomeController?
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "Cell")
        
        addSubview(collectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left) // какая выделена ячейка по умолчанию
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MenuCell //приведение типа к MenuCell
        
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate) //массив имен картинок
        cell.tintColor = UIColor.lightGray
        cell.labelText.text = imageNames[indexPath.item].capitalized
        //cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: frame.height) //framе.height - высота колекшн вью
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0     //убрали пробелы между кнопками
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate) //картинка используется как шаблон, поэтому можем по-разному отрисовывать
        iv.tintColor = UIColor.lightGray
        return iv
    }()
    
    
    let labelText: UILabel = {
        let lt = UILabel()
        lt.textColor = UIColor.lightGray
        lt.font = UIFont.systemFont(ofSize: 10)
        return lt
    }()
    
    override var isHighlighted: Bool {
        didSet{
            imageView.tintColor = isHighlighted ? UIColor.red : UIColor.lightGray //цвет при выделении
            labelText.textColor = isHighlighted ? UIColor.red : UIColor.lightGray
        }
    }
    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ? UIColor.red : UIColor.lightGray
            labelText.textColor = isSelected ? UIColor.red : UIColor.lightGray

        }
    }
    override func setupViews() {
        super.setupViews()
        
        //backgroundColor = UIColor.yellow
        addSubview(imageView)
        addSubview(labelText)
        addConstraintWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintWithFormat(format: "V:|-5-[v0(28)]-2-[v1(10)]-5-|", views: imageView, labelText)
        addConstraintWithFormat(format: "H:[v0]", views: labelText)
        
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: labelText, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)) //центрируем  по горизонтали

        

    }

}














