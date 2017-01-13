//
//  FeedCell.swift
//  youtube
//
//  Created by Daria on 26.12.16.
//  Copyright © 2016 Daria. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var videos: [Video]?
    
    func fetchVideos() {
        
        ApiService.sharedInstance.fetchVideos{ (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

    
    override func setupViews() {
        
        fetchVideos()
        super.setupViews()
        
        backgroundColor = .cyan
        
        addSubview(collectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "Cell")
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

         if let count = videos?.count {
            return count
        }

        return 0
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! VideoCell

        cell.video = videos?[indexPath.item]

        return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16 //от общей ширины экрана отнимаем 2 отступа и подгоняем под соотношение сторон 16:9
        return CGSize(width: frame.width, height: height + 16 + 88) // 16+ 68 - высота всех отступов
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer(video: videos?[indexPath.item])
        
        
    }
}
