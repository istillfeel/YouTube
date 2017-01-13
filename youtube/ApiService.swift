//
//  ApiService.swift
//  youtube
//
//  Created by Daria on 22.12.16.
//  Copyright © 2016 Daria. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchVideos (completion:@escaping ([Video]) ->()) {
        
        let url = URL(string: "https://www.dropbox.com/s/n0ifw6zpo577fm0/home.json?dl=1")
        URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            
            if error != nil {
                print(error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]() //cоздаем все видосы
                
                for dictionary in json as! [[String:AnyObject]]{ // массив словарей, парсим
                    
                    let video = Video() // создаем по одному все видосы
                    video.setValuesForKeys(dictionary)
                    
                    //                    video.title = dictionary["title"] as? String // название видосов  - это title в json
                    //                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    //
                    //                    video.views = dictionary["number_of_views"] as? Int
                    //
                    //                    let channelDictonary = dictionary["channel"] as! [String : AnyObject]
                    //                    let channel = Channel()
                    //                    channel.setValuesForKeys(channelDictonary)
                    //                    channel.name = channelDictonary["name"] as? String
                    //                    channel.profileImageName = channelDictonary["profile_image_name"] as? String
                    //                    video.duration = dictionary["duration"] as? NSNumber
                    
                    //                    video.channel = channel
                    
                    videos.append(video)
                    
                }
                DispatchQueue.main.async( execute:{
                    
                    // self.collectionView?.reloadData() //обновляем экран каждый раз это было когда videos был self
                    
                    completion(videos)
                    
                })
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
//            if error != nil {
//                print(error!)
//                return
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                
//                var videos = [Video]() //cоздаем все видосы
//                
//                for dictionary in json as! [[String:AnyObject]]{ // массив словарей, парсим
//                    print(dictionary["title"]!)
//                    
//                    let video = Video() // создаем по одному все видосы
//                    video.title = dictionary["title"] as? String // название видосов  - это title в json
//                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//                    video.views = dictionary["number_of_views"] as? Int
//                    video.duration = dictionary["duration"] as? NSNumber
//                    
//                    let channelDictonary = dictionary["channel"] as! [String : AnyObject]
//                    let channel = Channel()
//                    channel.name = channelDictonary["name"] as? String
//                    channel.profileImageName = channelDictonary["profile_image_name"] as? String
//                    
//                    video.channel = channel
//                    
//                    videos.append(video)
//                    
//                }
//                DispatchQueue.main.async( execute:{
//                    
//                   // self.collectionView?.reloadData() //обновляем экран каждый раз это было когда videos был self
//                    
//                    completion(videos)
//                    
//                })
//                
//            } catch let jsonError {
//                print(jsonError)
//            }
//            
//            }.resume()
    }
    
    func fetchTrendingFeed (completion:@escaping ([Video]) ->()) {
        
        let url = URL(string: "https://www.dropbox.com/s/jkxymgzj0w9crxb/trendings.json?dl=1")
        URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            
            if error != nil {
                print(error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]() //cоздаем все видосы
                
                for dictionary in json as! [[String:AnyObject]]{ // массив словарей, парсим
                    
                    let video = Video() // создаем по одному все видосы
                    video.setValuesForKeys(dictionary)
                    
//                    video.title = dictionary["title"] as? String // название видосов  - это title в json
//                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//                    
//                    video.views = dictionary["number_of_views"] as? Int
//                    
//                    let channelDictonary = dictionary["channel"] as! [String : AnyObject]
//                    let channel = Channel()
//                    channel.setValuesForKeys(channelDictonary)
                    //                    channel.name = channelDictonary["name"] as? String
//                    channel.profileImageName = channelDictonary["profile_image_name"] as? String
//                    video.duration = dictionary["duration"] as? NSNumber
                    
//                    video.channel = channel
                    
                    videos.append(video)
                    
                }
                DispatchQueue.main.async( execute:{
                    
                    // self.collectionView?.reloadData() //обновляем экран каждый раз это было когда videos был self
                    
                    completion(videos)
                    
                })
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }

    func fetchSubscribeFeed (completion:@escaping ([Video]) ->()) {
        
        let url = URL(string: "https://www.dropbox.com/s/44z2n9usdzber17/subscriptions.json?dl=1")
        URLSession.shared.dataTask(with: url!) { (data, responce, error) in
            
            if error != nil {
                print(error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]() //cоздаем все видосы
                
                for dictionary in json as! [[String:AnyObject]]{ // массив словарей, парсим
                    
                    let video = Video() // создаем по одному все видосы
                    video.setValuesForKeys(dictionary)
                    
                    //                    video.title = dictionary["title"] as? String // название видосов  - это title в json
                    //                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    //
                    //                    video.views = dictionary["number_of_views"] as? Int
                    //
                    //                    let channelDictonary = dictionary["channel"] as! [String : AnyObject]
                    //                    let channel = Channel()
                    //                    channel.setValuesForKeys(channelDictonary)
                    //                    channel.name = channelDictonary["name"] as? String
                    //                    channel.profileImageName = channelDictonary["profile_image_name"] as? String
                    //                    video.duration = dictionary["duration"] as? NSNumber
                    
                    //                    video.channel = channel
                    
                    videos.append(video)
                    
                }
                DispatchQueue.main.async( execute:{
                    
                    // self.collectionView?.reloadData() //обновляем экран каждый раз это было когда videos был self
                    
                    completion(videos)
                    
                })
                
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
            
//            if error != nil {
//                print(error!)
//                return
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                
//                var videos = [Video]() //cоздаем все видосы
//                
//                for dictionary in json as! [[String:AnyObject]]{ // массив словарей, парсим
//                    print(dictionary["title"]!)
//                    
//                    let video = Video() // создаем по одному все видосы
//                    video.title = dictionary["title"] as? String // название видосов  - это title в json
//                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//                    video.views = dictionary["number_of_views"] as? Int
//                    video.duration = dictionary["duration"] as? NSNumber
//                    
//                    let channelDictonary = dictionary["channel"] as! [String : AnyObject]
//                    let channel = Channel()
//                    channel.name = channelDictonary["name"] as? String
//                    channel.profileImageName = channelDictonary["profile_image_name"] as? String
//                    
//                    video.channel = channel
//                    
//                    videos.append(video)
//                    
//                }
//                DispatchQueue.main.async( execute:{
//                    
//                    // self.collectionView?.reloadData() //обновляем экран каждый раз это было когда videos был self
//                    
//                    completion(videos)
//                    
//                })
//                
//            } catch let jsonError {
//                print(jsonError)
//            }
//            
//            }.resume()
    }

}
