//
//  VideoCell.swift
//  youtube
//
//  Created by Daria on 16.12.16.
//  Copyright © 2016 Daria. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
    }
}

class VideoCell: BaseCell {
    
    var video : Video? {
        didSet {
            titleLabel.text = video?.title
            
           setupThumbnailImage()
           setupProfileImage()
            
            if let profileImageName = video?.channel?.profileImageName {
                userProfileImageView.image = UIImage(named: profileImageName)
            }
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.views {
                let subtitleText = "\(channelName) · \(numberOfViews) \n2 month ago"
                subtitleTextView.text = subtitleText
            }
            
            
            //размер title
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }
    
    func setupThumbnailImage() {
        
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(urlString:thumbnailImageUrl)
        }
        
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false //запрещаем самому менять размер без моего ведома
        imageView.image = #imageLiteral(resourceName: "Federer1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }() // замыкание для инициализации
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        //imageView.backgroundColor = UIColor.cyan
        imageView.image = #imageLiteral(resourceName: "Federer2")
        imageView.layer.cornerRadius = 22 // круг = половина стороны квадрата
        imageView.layer.masksToBounds = true // ползволяет менять радиус угла
        imageView.contentMode = .scaleAspectFill // не растягивать картинку/ сжимать
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = UIColor.yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Roger Federer – The Greatest Athlet Of The World"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping //чтобы слова переносились во 2 строчку по слову 
        return label
    }()
    let subtitleTextView: UITextView = {
        let subtitle = UITextView()
        //subtitle.backgroundColor = UIColor.orange
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.text = "RFOfficial · 1 millon views \n2 month ago"
        subtitle.isUserInteractionEnabled = false
        subtitle.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        subtitle.textColor = UIColor.lightGray
        return subtitle
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews(){
        //backgroundColor = UIColor.green
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        // addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
        addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView, separatorView)
        addConstraintWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView, "v1": separatorView]))
        addConstraintWithFormat(format: "H:|[v0]|", views: separatorView)
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : separatorView]))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //addConstraintWithFormat(format: "V:[v0(20)]", views: titleLabel)
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: thumbnailImageView, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
}
