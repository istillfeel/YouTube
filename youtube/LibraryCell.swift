//
//  CollectionViewCell.swift
//  youtube
//
//  Created by Daria on 10.01.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import UIKit

class LibraryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func setupCell() {
        addSubview(collectionView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(InsideLibraryCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 //количество ячеек = 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InsideLibraryCell
        
        switch indexPath.item {
        case 1:
            cell.label.text = "My Videos"
            cell.imageView.image = UIImage(named: "my_videos")?.withRenderingMode(.alwaysTemplate)
            cell.imageView.tintColor = .lightGray
        case 2:
            cell.label.text = "Watch Later"
            cell.imageView.image = UIImage(named: "watch_later")?.withRenderingMode(.alwaysTemplate)
            cell.imageView.tintColor = .lightGray
            cell.separator.isHidden = false
        case 3:
            cell.playlistLabel.isHidden = false
            cell.imageView.isHidden = true
            cell.label.isHidden = true
        case 4:
            cell.label.isHidden = true
            cell.playlistNameLabel.isHidden = false
            cell.playlistNameLabel.text = "Favourite"
            cell.numberOfVideosLabel.isHidden = false
            cell.numberOfVideosLabel.text = "9 videos"
            cell.playlistImageView.isHidden = false
            cell.playlistImageView.image = UIImage(named: "filledStar")?.withRenderingMode(.alwaysTemplate)
            cell.playlistImageView.tintColor = .lightGray
        case 5:
            cell.label.isHidden = true
            cell.playlistNameLabel.isHidden = false
            cell.playlistNameLabel.text = "Liked"
            cell.numberOfVideosLabel.isHidden = false
            cell.numberOfVideosLabel.text = "34 videos"
            cell.playlistImageView.isHidden = false
            cell.playlistImageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
            cell.playlistImageView.tintColor = .lightGray
        default:
            cell.label.text = "Viewed"
            cell.imageView.image = UIImage(named: "viewed")?.withRenderingMode(.alwaysTemplate)
            cell.imageView.tintColor = .lightGray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 50) // одна ячейка размер
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 //расстояние между ячейками
    }
}


class InsideLibraryCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let imageView: UIImageView = {
        let iw = UIImageView()
        iw.translatesAutoresizingMaskIntoConstraints = false
        return iw
    }()
    
    let label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 18)
        return lb
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let playlistLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isHidden = true
        lb.textColor = .gray
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.text = "Playlists"
        return lb
    }()
    
    let playlistNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isHidden = true
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    let numberOfVideosLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isHidden = true
        lb.textColor = .gray
        lb.font = UIFont.systemFont(ofSize: 15)
        return lb
    }()
    
    let playlistImageView: UIImageView = {
        let iw = UIImageView()
        iw.translatesAutoresizingMaskIntoConstraints = false
        iw.isHidden = true
        return iw
    }()
    
    
    func setupCell() {
        addSubview(imageView)
        addSubview(label)
        addSubview(separator)
        addSubview(playlistLabel)
        addSubview(playlistImageView)
        addSubview(playlistNameLabel)
        addSubview(numberOfVideosLabel)
        addSubview(playlistNameLabel)
        
        addConstraintWithFormat(format: "H:|-16-[v0]-16-[v1]", views: imageView, label)
        addConstraintWithFormat(format: "V:|-16-[v0]", views: imageView)
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separator.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        separator.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        playlistLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        playlistLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        playlistImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        playlistImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        playlistImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        playlistNameLabel.leftAnchor.constraint(equalTo: playlistImageView.rightAnchor, constant: 16).isActive = true
        playlistNameLabel.topAnchor.constraint(equalTo: playlistImageView.topAnchor).isActive = true
        playlistNameLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        numberOfVideosLabel.leftAnchor.constraint(equalTo: playlistImageView.rightAnchor, constant: 16).isActive = true
        numberOfVideosLabel.bottomAnchor.constraint(equalTo: playlistImageView.bottomAnchor).isActive = true
        numberOfVideosLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
    }
}














