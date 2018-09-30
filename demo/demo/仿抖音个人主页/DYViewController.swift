//
//  DYViewController.swift
//  demo
//
//  Created by 🍎上的豌豆 on 2018/9/29.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit
import SKPhotoBrowser
var USER_INFO_HEADER_HEIGHT:CGFloat = 320 + statusBarHeight
class DYViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationSetting()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    lazy  var table:UITableView = {
        
        let tableView = UITableView.init(frame: UIScreen.main.bounds, style: UITableView.Style.grouped)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight          = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.estimatedSectionFooterHeight   = 0
        tableView.estimatedSectionHeaderHeight   = 0
        if #available(iOS 11.0, *) {
            
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = ColorClear
        
        
        return tableView
        
    }();
    fileprivate let cellIdentifier = "tableViewCell"
    //头部视图
    fileprivate  var header = DYHeadView.init(frame: CGRect(x:0,y:0,width:screenWidth,height:USER_INFO_HEADER_HEIGHT))
    
    fileprivate var textView = ChatTextView.init()
    fileprivate let sectionTitles = ["",
                                     "ShowTips",
                                     "ShowSwiftMessages",
                                     "Share分享仿抖音",
                                     "XZBSystemActionSheet",
                                     "XZBActionSheet",
                                     "聊天弹出输入框",
                                    "","","","","","","","","","","",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(table)
        table.tableHeaderView = header
        header.delegate = self
    }


}
extension DYViewController{
    func navigationSetting(){
        //self.navigationItem.title = "🍎上的豌豆"
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .default)//这句代码很重要
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.clear]
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
    }
    func createImage(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }
    func navagationBarHeight()->CGFloat {
        return self.navigationController?.navigationBar.frame.size.height ?? 0;
    }
    func initRightBarButton(imageName: String) {
        let rightButton = UIBarButtonItem.init(image: UIImage.init(named: imageName), style: .plain, target: self, action: #selector(munu))
        rightButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    func circleText(cell :UITableViewCell){
        let gradientLayer:CAGradientLayer = CAGradientLayer.init()
        gradientLayer.colors = [ColorClear.cgColor, ColorBlackAlpha20.cgColor, ColorBlackAlpha40.cgColor]
        gradientLayer.locations = [0.3, 0.6, 1.0]
        gradientLayer.startPoint = CGPoint.init(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint.init(x: 0.0, y: 1.0)
        cell.layer.addSublayer(gradientLayer)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        gradientLayer.frame = cell.bounds
        CATransaction.commit()
        
        let circleText = CircleTextView.init()
        circleText.frame = cell.bounds
        circleText.textColor = UIColor.randomColor()
        circleText.text = "🍎上的豌豆"
        cell.addSubview(circleText)
    }
    @objc func munu() {
        let menu = UIMenuController.shared
        self.becomeFirstResponder()
        if !menu.isMenuVisible {
            menu.arrowDirection = .down
            menu.setTargetRect(CGRect.init(x: 60, y: 100, width: 120, height: 50), in: self.view)
            let copy = UIMenuItem.init(title: "复制", action: #selector(onMenuCopy))
            let delete = UIMenuItem.init(title: "删除", action: #selector(onMenuDelete))
            menu.menuItems = [copy, delete]
            menu.setMenuVisible(true, animated: true)
        }
    }
    @objc func onMenuCopy() {
        XZBShowMessage.ShowTopTips(msg: "Copy成功")
    }
    
    @objc func onMenuDelete() {
        XZBShowMessage.ShowTopTips(msg: "Delete成功")
        
    }
}

// MARK: - UITableViewDataSource
extension DYViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.selectionStyle = .none
        cell.textLabel?.text = sectionTitles[indexPath.row]
        if  indexPath.row == 0 {
            self.circleText(cell: cell)
        }
        cell.textLabel?.font = Font_Bold_25
        cell.textLabel?.textColor = UIColor.randomColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitles.count
    }
}
//MARK:UITableViewDelegate
extension DYViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
           
            break
        case 1:
            UIWindow.showTips(text: "🍎上的豌豆")
            break
        case 2:
            
            XZBShowMessage.ShowTopTips(msg: "🍎上的豌豆")
            break
        case 3:
            XZBShareView.init().show()
            break
        case 4:
            let menu = XZBSystemActionSheet.init(titles: ["清除缓存","举报"])
            menu.onAction = { index in
                if index == 0 {
                    XZBShowMessage.ShowTopTips(msg: "清除缓存成功")
                }else if index == 1 {
                    XZBShowMessage.ShowTopTips(msg: "举报成功")
                }
                
            }
            menu.show()
            break
        case 5:
            let menu = XZBActionSheet.init(TitleStr: "更多操作", titles: ["清除缓存","举报"])
            
            menu.ActionSheet = { index in
                if index == 0 {
                    XZBShowMessage.ShowTopTips(msg: "清除缓存成功")
                }else if index == 1 {
                    XZBShowMessage.ShowTopTips(msg: "举报成功")
                }
                
            }
            menu.show()
            break
            
        case 6:
            textView.show()
            textView.delegate = self
            break
            
        
        default: break
            
        }
        
    }
}
//MARK:ChatTextViewDelegate
extension DYViewController:ChatTextViewDelegate {
    func onSendText(text: String) {
        XZBShowMessage.ShowTopTips(msg: text)
        
    }
    
    func onSendImages(images: [UIImage]) {
        
        var SKPhotoImages = [SKPhoto]()
        
        for image in images {
            let photo = SKPhoto.photoWithImage(image as UIImage)
            SKPhotoImages.append(photo)
        }
        
        textView.dismiss()
        
        let browser = SKPhotoBrowser(photos: SKPhotoImages)
        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})
    }
    
    func onEditBoardHeightChange(height: CGFloat) {
        table.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: height, right: 0)
        
    }
    
    
}

extension DYViewController: UIScrollViewDelegate {
    //实现UIScrollViewDelegate中的scrollViewDidScroll方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取当前控件y方向的偏移量
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            header.overScrollAction(offsetY: offsetY)
        } else {
            header.scrollToTopAction(offsetY: offsetY)
            updateNavigationTitle(offsetY: offsetY)
        }
    }
    
    func updateNavigationTitle(offsetY:CGFloat) {
        if USER_INFO_HEADER_HEIGHT - self.navagationBarHeight()*2 > offsetY {
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:ColorClear]
        }
        
        if USER_INFO_HEADER_HEIGHT - self.navagationBarHeight()*2 < offsetY && offsetY < USER_INFO_HEADER_HEIGHT - self.navagationBarHeight() {
            let alphaRatio = 1.0 - (USER_INFO_HEADER_HEIGHT - self.navagationBarHeight() - offsetY)/self.navagationBarHeight()
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: alphaRatio)]
        }
        
        if offsetY > USER_INFO_HEADER_HEIGHT - self.navagationBarHeight() {
            
            
             self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:ColorWhite]
        }
    }
}
extension DYViewController: UserInfoDelegate {
    
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
