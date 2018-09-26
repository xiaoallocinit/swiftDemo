//
//  XZBShowMessage.swift
//  demo
//
//  Created by 🍎上的豌豆 on 2018/9/26.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit

import SwiftMessages
class XZBShowMessage: NSObject {
    class func ShowTopTips(msg : String){
        let status2 = MessageView.viewFromNib(layout: .statusLine)
        status2.backgroundView.backgroundColor = UIColor.yellow
        status2.bodyLabel?.textColor = UIColor.black
        status2.configureContent(body: msg)
        var status2Config = SwiftMessages.defaultConfig
        status2Config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        status2Config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: status2Config, view: status2)
    }
    class func ShowError(){
        let status2 = MessageView.viewFromNib(layout: .statusLine)
        status2.backgroundView.backgroundColor = UIColor.yellow
        status2.bodyLabel?.textColor = UIColor.white
        status2.configureContent(body: "网络异常")
        var status2Config = SwiftMessages.defaultConfig
        status2Config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        status2Config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: status2Config, view: status2)
    }
    
    class func ShowWarning(msg : String){
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        warning.configureContent(title: "提示", body: msg, iconText: "appIcon")
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
}
