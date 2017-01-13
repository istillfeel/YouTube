//
//  Extensions.swift
//  youtube
//
//  Created by Daria on 16.12.16.
//  Copyright © 2016 Daria. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>() // создаем переменную Cache, чтобы хранить подгруженную картинку

extension UIView{
    //заменяем "размер" одним значением(расширение)
    func addConstraintWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String:UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        image = nil // чтобы каждый раз картинка удалялась
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {[unowned self] in
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            
                
            }
            
        }).resume()
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
