//
//  VideoLauncher.swift
//  youtube
//
//  Created by Daria on 04.01.17.
//  Copyright © 2017 Daria. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndificatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.clear
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        
        return button
    }()
    
    func isPlaying() -> Bool {
        return player!.rate != 0 && player!.error == nil
    }
    
    func handlePause(){ // выбор картинки и остановка/запуск плеера при нажатии кнопки
        if isPlaying(){
            player?.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        } else {
            player?.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        
        
    }
    
    let videoLenghtLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        
        return label
    }()
    
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = UIColor.red // цвет слайдера до точки
        slider.setThumbImage(#imageLiteral(resourceName: "thumb"), for: .normal)
        slider.maximumTrackTintColor = UIColor.white // цвет слайдера после точки
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        
        return slider
        
    }()
    
    func handleSliderChange() { //перемотка видео когда двигаем слайдер
        if let duration = player?.currentItem?.duration {
            let seconds = CMTimeGetSeconds(duration)
            let value = Float64(slider.value) * seconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (comletedSeek) in
                
            })
        }
    }
    
    var isContolHidden = false //сначала видны
    
    // обработчик касания
    func handleTap(_ sender: UITapGestureRecognizer) {
        if !isContolHidden {
            videoLenghtLabel.isHidden = true
            currentTimeLabel.isHidden = true
            playPauseButton.isHidden = true
            slider.isHidden = true
            
            isContolHidden = true //теперь уже спрятан
        } else {
            videoLenghtLabel.isHidden = false
            currentTimeLabel.isHidden = false
            playPauseButton.isHidden = false
            slider.isHidden = false
            
            isContolHidden = false
        }
        
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    func setupControls() {
        setupGradient()
        
        controlsContainerView.frame = frame
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        controlsContainerView.addGestureRecognizer(tap)
        controlsContainerView.isUserInteractionEnabled = true
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndificatorView)
        activityIndificatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndificatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLenghtLabel)
        videoLenghtLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLenghtLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        videoLenghtLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLenghtLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        
        controlsContainerView.addSubview(slider)
        slider.rightAnchor.constraint(equalTo: videoLenghtLabel.leftAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        slider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        backgroundColor = UIColor.black
    }
    
    var player: AVPlayer?
    
    func setupPlayerView(urlString: String) {
        if let url = URL(string: urlString){
            
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progresstime) in
                let seconds = CMTimeGetSeconds(progresstime)//  текуцщая секунда
                let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                let minutesString = String(format: "%02d", Int(seconds / 60))
                
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                if let duration = self.player?.currentItem?.duration {
                
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.slider.value = Float(seconds / durationSeconds)
                }
            })
        }

    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"{
            activityIndificatorView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            playPauseButton.tintColor = UIColor.white // изначально прозрачная, но, когда видео подругжается, кнопка становится белой
            
            if let duration = player?.currentItem?.duration { // понимает длину видео
                let seconds = CMTimeGetSeconds(duration) // получаем количество секунд видео 
                
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLenghtLabel.text = "\(minutesText):\(secondsText)"
            }
        }
        
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2] // где будет градиент
        
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer(video: Video?) {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            UIApplication.shared.statusBarView?.backgroundColor = .clear
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            videoPlayerView.setupPlayerView(urlString: (video?.urlString)!)
            videoPlayerView.setupControls()
            view.addSubview(videoPlayerView)
            
            let descriptionFrame = CGRect(x: 0, y: height, width: keyWindow.frame.width, height: 600)
            let descriptionView = DescriptionView(frame: descriptionFrame)
            descriptionView.titleLabel.text = video?.title
            descriptionView.channelLabel.text = video?.channel?.name
            descriptionView.channelImage.loadImageUsingUrlString(urlString: (video?.channel?.profileImageName)!) // скачать изображение и установить его
            descriptionView.viewsLabel.text = "\((video?.views)!) views"
            descriptionView.likesLabel.text = video?.numberOfLikes
            descriptionView.dislikesLabel.text = video?.numberOfDislikes
            descriptionView.followersLabel.text = "\((video?.channel?.numberOfFollowers)!) followers"
            view.addSubview(descriptionView)
            descriptionView.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor).isActive = true
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}


class DescriptionView: UIView {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupDescription()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.text = "Rolex - Roger Federer's milestone"
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.text = "70000000 views"
        return label
    }()
    
    let like: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "like")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let dislike: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "dislike")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "21k"
        return label
    }()
    
    let dislikesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.text = "0"
        return label
    }()
    
    let separatorUP: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separatorDOWN: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let channelImage: CustomImageView = {
        let imageView = CustomImageView()
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Federer1")
        return imageView
    }()
    
    let channelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Rolex"
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        label.text = "10 000 000 followers"
        return label
    }()
    
    let subscribe: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "subscribe"), for: .normal)
        return button
    }()
    
    func setupDescription() {
        addSubview(titleLabel)
        addSubview(viewsLabel)
        addSubview(like)
        addSubview(dislike)
        addSubview(likesLabel)
        addSubview(dislikesLabel)
        addSubview(separatorUP)
        addSubview(separatorDOWN)
        addSubview(channelImage)
        addSubview(channelLabel)
        addSubview(followersLabel)
        addSubview(subscribe)
        
        
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: titleLabel)
        addConstraintWithFormat(format: "V:|-16-[v0(40)]-8-[v1(11)]-8-[v2(25)]", views: titleLabel,viewsLabel, like)
        
        viewsLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        viewsLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        
        like.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        like.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        likesLabel.leftAnchor.constraint(equalTo: like.rightAnchor, constant: 4).isActive = true
        likesLabel.topAnchor.constraint(equalTo: viewsLabel.bottomAnchor, constant: 8).isActive = true
        likesLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        likesLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        dislike.leftAnchor.constraint(equalTo: likesLabel.rightAnchor, constant: 8).isActive = true
        dislike.topAnchor.constraint(equalTo: viewsLabel.bottomAnchor, constant: 8).isActive = true
        dislike.widthAnchor.constraint(equalToConstant: 25).isActive = true
        dislike.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        dislikesLabel.leftAnchor.constraint(equalTo: dislike.rightAnchor, constant: 4).isActive = true
        dislikesLabel.topAnchor.constraint(equalTo: viewsLabel.bottomAnchor, constant: 8).isActive = true
        dislikesLabel.widthAnchor.constraint(equalToConstant: 35).isActive = true
        dislikesLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        addConstraintWithFormat(format: "H:|[v0]|", views: separatorUP)
        separatorUP.topAnchor.constraint(equalTo: like.bottomAnchor, constant: 8).isActive = true
        separatorUP.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addConstraintWithFormat(format: "H:|[v0]|", views: separatorDOWN)
        separatorDOWN.topAnchor.constraint(equalTo: channelImage.bottomAnchor, constant: 8).isActive = true
        separatorDOWN.heightAnchor.constraint(equalToConstant: 1).isActive = true

        
        channelImage.leftAnchor.constraint(equalTo: like.leftAnchor).isActive = true
        channelImage.topAnchor.constraint(equalTo: separatorUP.bottomAnchor, constant: 8).isActive = true
        channelImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        channelImage.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        channelLabel.leftAnchor.constraint(equalTo: channelImage.rightAnchor, constant: 8).isActive = true
        channelLabel.rightAnchor.constraint(equalTo: subscribe.leftAnchor, constant: 8)
        channelLabel.topAnchor.constraint(equalTo: separatorUP.bottomAnchor, constant: 8).isActive = true
        channelLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        followersLabel.leftAnchor.constraint(equalTo: channelImage.rightAnchor, constant: 8).isActive = true
        followersLabel.rightAnchor.constraint(equalTo: subscribe.leftAnchor, constant: 8)
        followersLabel.topAnchor.constraint(equalTo: channelLabel.bottomAnchor, constant: 4).isActive = true
        followersLabel.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        addConstraintWithFormat(format: "H:[v0]-16-|", views: subscribe)
        subscribe.topAnchor.constraint(equalTo: separatorUP.bottomAnchor, constant: 8).isActive = true
        subscribe.widthAnchor.constraint(equalToConstant: 125).isActive = true
        subscribe.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        
    }
    
}
