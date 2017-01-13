//
//  Video.swift
//  youtube
//
//  Created by Daria on 19.12.16.
//  Copyright © 2016 Daria. All rights reserved.
// создаем класс, где описываем все поля

import UIKit

class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let upperCasedFirstCharacter = String(key.characters.first!).uppercased()
        let remainder = key.substring(from: key.characters.index(after: key.characters.startIndex))
        
        let selector = NSSelectorFromString("set\(upperCasedFirstCharacter)\(remainder):")
        let respond = self.responds(to: selector)
        
        if !respond {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}

class Video: SafeJsonObject {
    var thumbnailImageName: String?
    var title: String?
    var views: NSNumber?
    var date: String?
    var channel: Channel?
    var duration: NSNumber?
    var numberOfLikes: String?
    var numberOfDislikes: String?
    var urlString: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "channel" {
            //let channelDictionary = value as! [String: AnyObject]
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: AnyObject])
            
        } else {
            super.setValue(value, forKey: key)
        }
        
    }
    
}

class Channel: SafeJsonObject{
    var name: String?
    var profileImageName: String?
    var numberOfFollowers: String?
}
