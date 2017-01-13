//
//  SubscriptionCell.swift
//  youtube
//
//  Created by Daria on 27.12.16.
//  Copyright © 2016 Daria. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVideos() {
        
        ApiService.sharedInstance.fetchSubscribeFeed { (videos: [Video]) in
            
            self.videos = videos
            self.collectionView.reloadData()
            
        }

    }
}
