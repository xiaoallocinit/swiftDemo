//
//  XZBPageViewController.swift
//  demo
//
//  Created by 🍎上的豌豆 on 2018/10/10.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit


protocol UComicViewWillEndDraggingDelegate: class {
    func comicWillEndDragging(_ scrollView: UIScrollView)
}
enum UNavigationBarStyle {
    case theme
    case clear
    case white
}

class XZBPageViewController: UIViewController {
    private lazy var mainScrollView: UIScrollView = {
        let sw = UIScrollView()
        sw.delegate = self
        return sw
    }()
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        return contentView
    }()
    private lazy var RecVC: DYViewController = {
        let Rec = DYViewController()
        Rec.delegate = self
        return Rec
    }()
    private lazy var CommentVC: DYViewController = {
        let Comment = DYViewController()
        Comment.delegate = self
        return Comment
    }()
    private lazy var navigationBarY: CGFloat = {
        return navigationController?.navigationBar.frame.maxY ?? 0
    }()
    private lazy var headView: DYHeadView = {
        
        return DYHeadView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarY + XZBHeadH))
    }()
    private lazy var pageVC: XZBBasePageViewController = {
        return XZBBasePageViewController(titles: ["详情", "评论"],
                                   vcs: [RecVC,CommentVC],
                                   pageStyle: .topTabBar)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        barStyle(.clear)
        mainScrollView.contentOffset = CGPoint(x: 0, y: -mainScrollView.parallaxHeader.height)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .top
        configUI()
        
        
    }
    func barStyle(_ style: UNavigationBarStyle) {
        switch style {
        case .theme:
            self.navigationController?.navigationBar.barStyle = .black
            self.navigationController?.navigationBar.setBackgroundImage(UIColor.black.image(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        case .clear:
            self.navigationController?.navigationBar.barStyle = .default
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
        case .white:
            self.navigationController?.navigationBar.barStyle = .default
            self.navigationController?.navigationBar.setBackgroundImage(UIColor.white.image(), for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
        }
        
        
    }
    
    func configUI() {
         view.backgroundColor = .white
        view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.usnp.edges).priority(.low)
            $0.top.equalToSuperview()
        }
        
        mainScrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().offset(-navigationBarY)
        }
        addChild(pageVC)
        contentView.addSubview(pageVC.view)
        pageVC.view.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        headView.delegate = self
        mainScrollView.parallaxHeader.view = headView
        mainScrollView.parallaxHeader.height = navigationBarY + XZBHeadH
        mainScrollView.parallaxHeader.minimumHeight = navigationBarY
        mainScrollView.parallaxHeader.mode = .fill
        
    }
    
    
}
extension XZBPageViewController: UIScrollViewDelegate, UComicViewWillEndDraggingDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= -scrollView.parallaxHeader.minimumHeight {
            barStyle(.white)
            navigationItem.title = "苹果上的豌豆"
        } else {
            barStyle(.clear)
            navigationItem.title = ""
        }
    }
    
    func comicWillEndDragging(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            mainScrollView.setContentOffset(CGPoint(x: 0,
                                                    y: -self.mainScrollView.parallaxHeader.minimumHeight),
                                            animated: true)
        } else if scrollView.contentOffset.y < 0 {
            mainScrollView.setContentOffset(CGPoint(x: 0,
                                                    y: -self.mainScrollView.parallaxHeader.height),
                                            animated: true)
        }
    }
}
extension XZBPageViewController: UserInfoDelegate {
    
    func onUserActionTap(tag: Int) {
        switch tag {
        case AVATAE_TAG:
            XZBShowMessage.ShowTopTips(msg: "头像")
            break
        case SEND_MESSAGE_TAG:
            XZBShowMessage.ShowTopTips(msg: "消息")
            break
        case FOCUS_CANCEL_TAG,FOCUS_TAG:
            XZBShowMessage.ShowTopTips(msg: "关注")
            
            break
        case SETTING_TAG:
            XZBShowMessage.ShowTopTips(msg: "设置")
            break
            
        default:
            break
        }
    }
    
    
}
