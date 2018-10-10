//
//  DYHeadView.swift
//  demo
//
//  Created by 🍎上的豌豆 on 2018/9/29.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit

let DEFAULT_ANIMATION_TIME:TimeInterval = 0.25

let AVATAE_TAG:Int = 1000
let SEND_MESSAGE_TAG:Int = 2000
let FOCUS_TAG:Int = 3000
let FOCUS_CANCEL_TAG:Int = 4000
let SETTING_TAG:Int = 5000
let GITHUB_TAG:Int = 6000

protocol UserInfoDelegate : NSObjectProtocol {
    func onUserActionTap (tag:Int)
}
class DYHeadView: UIView {
    var delegate:UserInfoDelegate?
    var isFollowed:Bool = false
   var containerView:UIView = UIView.init()
    var avatar:UIImageView = UIImageView.init(image: UIImage.init(named: "苹果"))
    var avatarBackground:UIImageView = UIImageView.init()
    
    var sendMessage:UILabel = UILabel.init()
    var focusIcon:UIImageView = UIImageView.init(image: UIImage.init(named: "icon_titlebar_addfriend"))
    var settingIcon:UIImageView = UIImageView.init(image: UIImage.init(named: "icon_titlebar_whitemore"))
    var focusButton:UIButton = UIButton.init()
    
    var nickName:UILabel = UILabel.init()
    var douyinNum:UILabel = UILabel.init()
    var brief:UILabel = UILabel.init()
    var likeNum:UILabel = UILabel.init()
    var followNum:UILabel = UILabel.init()
    var followedNum:UILabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initAvatarBackground()
        initAvatar()
        
        initActionsView()
        initInfoView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initAvatarBackground() {
        avatarBackground.frame = self.bounds
        avatarBackground.clipsToBounds = true
        avatarBackground.image = UIImage.init(named: "苹果")
        avatarBackground.backgroundColor = ColorThemeGray
        avatarBackground.contentMode = .scaleAspectFill
        self.addSubview(avatarBackground)
        
        let blurEffect = UIBlurEffect.init(style: UIBlurEffect.Style.dark)
        let visualEffectView = UIVisualEffectView.init(effect: blurEffect)
        visualEffectView.frame = self.bounds
        visualEffectView.alpha = 1
        avatarBackground.addSubview(visualEffectView)
        
        containerView.frame = self.bounds
        self.addSubview(containerView)
    }
    
    func initAvatar() {
        let avatarRadius:CGFloat = 45
        avatar.isUserInteractionEnabled = true
        avatar.tag = AVATAE_TAG
        avatar.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTapAction(sender:))))
        containerView.addSubview(avatar)
        
        let paddingLayer = CALayer.init()
        paddingLayer.frame = CGRect.init(x: 0, y: 0, width: avatarRadius * 2, height: avatarRadius * 2)
        paddingLayer.borderColor = ColorWhiteAlpha20.cgColor
        paddingLayer.borderWidth = 2
        paddingLayer.cornerRadius = avatarRadius
        avatar.layer.addSublayer(paddingLayer)
        
        avatar.snp.makeConstraints { make in
            make.top.equalTo(self).offset(25 + 44 + statusBarHeight)
            make.left.equalTo(self).offset(15)
            make.width.height.equalTo(avatarRadius * 2)
        }
    }
    
    func initActionsView() {
        settingIcon.contentMode = .center
        settingIcon.layer.backgroundColor = ColorWhiteAlpha20.cgColor
        settingIcon.layer.cornerRadius = 2
        settingIcon.tag = SETTING_TAG
        settingIcon.isUserInteractionEnabled = true
        settingIcon.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTapAction(sender:))))
        containerView.addSubview(settingIcon)
        settingIcon.snp.makeConstraints { make in
            make.centerY.equalTo(self.avatar)
            make.right.equalTo(self).inset(15)
            make.width.height.equalTo(40)
        }
        
        focusIcon.contentMode = .center
        focusIcon.isUserInteractionEnabled = true
        focusIcon.clipsToBounds = true
        focusIcon.isHidden = !isFollowed
        focusIcon.layer.backgroundColor = ColorWhiteAlpha20.cgColor
        focusIcon.layer.cornerRadius = 2
        focusIcon.tag = FOCUS_CANCEL_TAG
        focusIcon.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onTapAction(sender:))))
        containerView.addSubview(focusIcon)
        focusIcon.snp.makeConstraints { make in
            make.centerY.equalTo(self.settingIcon)
            make.right.equalTo(self.settingIcon.snp.left).inset(-5)
            make.width.height.equalTo(40)
        }
 
    }
    func initInfoView() {
        nickName.text = "🍎上的豌豆"
        nickName.textColor = ColorWhite
        nickName.font = SuperBigBoldFont
        containerView.addSubview(nickName)
        nickName.snp.makeConstraints { make in
            make.top.equalTo(self.avatar.snp.bottom).offset(20)
            make.left.equalTo(self.avatar)
            make.right.equalTo(self.settingIcon)
        }
        
        douyinNum.text = "抖音号：299970"
        douyinNum.textColor = ColorWhite
        douyinNum.font = SmallFont
        containerView.addSubview(douyinNum)
        douyinNum.snp.makeConstraints { make in
            make.top.equalTo(self.nickName.snp.bottom).offset(3)
            make.left.right.equalTo(self.nickName)
        }
        
       
        
        let splitLine = UIView.init()
        splitLine.backgroundColor = ColorWhiteAlpha20
        containerView.addSubview(splitLine)
        splitLine.snp.makeConstraints { make in
            make.top.equalTo(self.douyinNum.snp.bottom).offset(10)
            make.left.right.equalTo(self.nickName)
            make.height.equalTo(0.5)
        }
        
        brief.text = "🍎上的豌豆爱吃吗"
        brief.textColor = ColorWhiteAlpha60
        brief.font = SmallFont
        brief.numberOfLines = 0
        containerView .addSubview(brief)
        brief.snp.makeConstraints { make in
            make.top.equalTo(splitLine.snp.bottom).offset(10)
            make.left.right.equalTo(self.nickName)
        }
        
        
        
        likeNum.text = "8880获赞"
        likeNum.textColor = ColorWhite
        likeNum.font = BigBoldFont
        containerView.addSubview(likeNum)
        likeNum.snp.makeConstraints { make in
            make.top.equalTo(self.brief.snp.bottom).offset(15)
            make.left.equalTo(self.avatar)
        }
        
        followNum.text = "23关注"
        followNum.textColor = ColorWhite
        followNum.font = BigBoldFont
        containerView.addSubview(followNum)
        followNum.snp.makeConstraints { make in
            make.top.equalTo(self.likeNum)
            make.left.equalTo(self.likeNum.snp.right).offset(30)
        }
        
        followedNum.text = "120W粉丝"
        followedNum.textColor = ColorWhite
        followedNum.font = BigBoldFont
        containerView.addSubview(followedNum)
        followedNum.snp.makeConstraints { make in
            make.top.equalTo(self.likeNum)
            make.left.equalTo(self.followNum.snp.right).offset(30)
        }
    }
    @objc func onTapAction(sender: UITapGestureRecognizer) {
        if(self.delegate != nil) {
            self.delegate?.onUserActionTap(tag: (sender.view?.tag)!)
        }
    }
}
//scroll action
extension DYHeadView {
    
    func overScrollAction(offsetY:CGFloat)  {
        //计算背景容器缩放比例
        let scaleRatio:CGFloat = abs(offsetY)/370.0
        //计算容器缩放后y方向的偏移量
        let overScaleHeight:CGFloat = (370.0 * scaleRatio)/2.0
        //缩放同时平移背景容器
        avatarBackground.transform = CGAffineTransform.init(scaleX: scaleRatio + 1.0, y: scaleRatio + 1.0).concatenating(CGAffineTransform.init(translationX: 0, y: -overScaleHeight))
    }
    
    func scrollToTopAction(offsetY:CGFloat) {
        let alphaRatio = offsetY/(370.0 - 44.0 - statusBarHeight)
        containerView.alpha = 1.0 - alphaRatio
    }
    
}
