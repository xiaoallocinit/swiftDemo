//
//  XZBActionSheet.swift
//  demo
//
//  Created by 🍎上的豌豆 on 2018/9/26.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit
typealias ActionSheet = (_ index:Int) -> Void
class XZBActionSheet: UIView {
    
    lazy var TitleLabel:UILabel = {
        let nameLab = UILabel.init()
        nameLab.textAlignment = NSTextAlignment.left
        nameLab.font = Font_Bold_25
        nameLab.textColor = XZBColorTitle
        nameLab.text = "123"
        return nameLab
    }()
    lazy var cancel : UIButton = {
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "xieyiquxiao"), for: .normal)
    button.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(cancel(sender:))))
        
        return button
    }()
    
   
    lazy var container:UIView = {
        let container = UIView.init()
        container.backgroundColor = .clear
        
        return container
    }()
    lazy var topView:UIView = {
        let topView = UIView.init()
        topView.backgroundColor = .white
        
        
        return topView
    }()
    
    var ActionSheet: ActionSheet?
    private var _titles = [String]()
    var contentH : CGFloat {
        return 180
    }
    var buttonH : CGFloat {
        return 49
    }
    
    var titles: [String] {
        set {
            _titles = newValue.reversed()
            initSubView()
        }
        get {
            return _titles
        }
    }
    
    
    
    
    init(TitleStr: String, titles: [String]) {
        super.init(frame: screenFrame)
        self.titles = titles
        self.TitleLabel.text =  TitleStr
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubView() {
        self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(cancel(sender:))))
        self.backgroundColor = colorWithHex(hex: 0x000000, alpha: 0.8)
       
       
         container.frame = CGRect.init(x: 0, y: screenHeight, width: screenWidth, height: CGFloat(titles.count) * buttonH + contentH)
        cancel.frame = CGRect.init(x: screenWidth/2 - 20, y: 0, width: 40, height: 40)
        self.addSubview(container)
        container.addSubview(cancel)
        
        
        topView.frame = CGRect.init(x: 0, y: 60, width: screenWidth, height: CGFloat(titles.count) * buttonH + contentH - 60)
        /// 圆角设置
        let corners : UIRectCorner = [.topLeft, .topRight]
        
        let rounded = UIBezierPath(roundedRect: topView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 20, height: 20))
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        shape.frame = topView.bounds
        topView.layer.mask = shape
        container.addSubview(topView)
        
       
        topView.addSubview(TitleLabel)
        TitleLabel.frame = CGRect.init(x:30, y: 30, width: screenWidth, height: 30)
        
        
        for index in 0..<titles.count {
            let lable = UILabel.init(frame: CGRect.init(x: 30, y: 90 + CGFloat(index)*buttonH, width: screenWidth, height: buttonH))
            lable.textAlignment = NSTextAlignment.left
            lable.font = PingFang_16
            lable.textColor = XZBColorTitle
            lable.text = titles[index]
            topView.addSubview(lable)
            let imageView = UIImageView.init(frame: CGRect.init(x:screenWidth - 30, y:buttonH/2 - 6 + 90 + CGFloat(index )*buttonH, width: 8, height: 12))
            imageView.image = UIImage.init(named: "youjiantou")
            topView.addSubview(imageView)
            
            let button = UIButton.init(frame: CGRect.init(x: 0, y: 90 + CGFloat(index)*buttonH, width: screenWidth, height: buttonH))
            
            button.tag = index
            button.backgroundColor = .clear
        button.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(action(sender:))))
            topView.addSubview(button)
        }
        
        
    }
    
    
    @objc func action(sender:UITapGestureRecognizer) {
        ActionSheet?(sender.view?.tag ?? 0)
        dismiss()
    }
    
    @objc func cancel(sender:UITapGestureRecognizer) {
        var point = sender.location(in: container)
        if !container.layer.contains(point) {
            dismiss()
            return
        }
        
        point = sender.location(in: cancel)
        if cancel.layer.contains(point) {
            dismiss()
        }
    }
    
    func show() {
        let window = UIApplication.shared.delegate?.window as? UIWindow
        window?.addSubview(self)
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
            var frame = self.container.frame
            frame.origin.y = screenHeight - (CGFloat(self.titles.count) * self.buttonH + self.contentH )
            self.container.frame = frame
            
            
        }) { finished in
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: {
            var frame = self.container.frame
            frame.origin.y += frame.size.height
            self.container.frame = frame
        }) { finished in
            self.removeFromSuperview()
        }
    }
    

    

}
