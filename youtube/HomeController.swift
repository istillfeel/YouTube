//
//  ViewController.swift
//  youtube
//
//  Created by Daria on 15.12.16.
//  Copyright © 2016 Daria. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    /* var videos : [Video] = {
        
        var fedChannel = Channel()
        fedChannel.name = "RFOfficial"
        fedChannel.profileImageName = "Federer1"
        
        var thegreatestathlet = Video()
        thegreatestathlet.title = "Roger Federer – The Greatest Athlet Of the World"
        thegreatestathlet.thumbnailImageName = "Federer1"
        thegreatestathlet.views = "7 million views"
        thegreatestathlet.channel = fedChannel
        var bestshots = Video()
        bestshots.title = "Roger Federer - The Best Shots"
        bestshots.thumbnailImageName = "Federer3"
        bestshots.views = "3 millions views"
        bestshots.channel = fedChannel
        
        return [thegreatestathlet,bestshots]
    
    }() */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        navigationItem.title = "YouTube"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  YouTube" //создали лэйбл и поместили в верхний левый угол НБ(аналогично сверху надписи ютуб, но слева)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setUpCollectionView()
        setupMenuBar()
        setupNavBarButton()
    }
    
    func setUpCollectionView() {
        //горизонтальный скролл
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 50, 0)
        
        collectionView?.isPagingEnabled = true
        collectionView?.isScrollEnabled = false
        
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: "trendingCellId")
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: "subscriptionCellId")
        
        //collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "Cell")
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.register(LibraryCell.self, forCellWithReuseIdentifier: "libraryCellId")
    }
    
   lazy var menuBar:  MenuBar = {
        let mb = MenuBar()
        mb.homeController = self //так как считается нулем
        return mb
    }()
    
    let separatorView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return sv

    }()
    func setupNavBarButton() {
        let searchImage = #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal)
        let videoImage = #imageLiteral(resourceName: "video").withRenderingMode(.alwaysOriginal)
        let userprofileImage = #imageLiteral(resourceName: "user").withRenderingMode(.alwaysOriginal)
        
        let searchButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let videoButtonItem = UIBarButtonItem(image: videoImage, style: .plain, target: self, action: #selector(handleVideo))
        let userButtonItem = UIBarButtonItem(image: userprofileImage, style: .plain, target: self, action: #selector(handleUser))


        
        navigationItem.rightBarButtonItems = [userButtonItem,searchButtonItem,videoButtonItem]
    }
    
    func handleSearch() {
        
        scrollToMenuIndex(menuIndex: 2)
    }
    
    func handleVideo() {
        
    }
    
    func handleUser() {
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true // убираем NB
        
        view.addSubview(menuBar)
        view.addSubview(separatorView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:[v0(1)]-0-[v1(50)]|", views:separatorView, menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: separatorView)

    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "trendingCellId", for: indexPath)
        } else if indexPath.item == 2 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "subscriptionCellId", for: indexPath)
        } else if indexPath.item == 3 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "libraryCellId", for: indexPath)
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }

}


















