//
//  ViewController.swift
//  demo
//
//  Created by yinian on 2018/9/26.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class ViewController: UIViewController {
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
        tableView.backgroundColor = .white
        
        
        return tableView
        
    }();
    var textView = ChatTextView.init()
    
    fileprivate let cellIdentifier = "tableViewCell"
    fileprivate let sectionTitles = ["",
                                     "ShowTips",
                                     "ShowSwiftMessages",
                                     "Share分享仿抖音",
                                     "XZBSystemActionSheet",
                                     "XZBActionSheet",
                                     "聊天弹出输入框",
                                     "ScaleAnimation",
                                     "Custom"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(table)
        self.title = "🍎上的豌豆"
        initRightBarButton(imageName: "youjiantou")
    }
    func initRightBarButton(imageName: String) {
        let rightButton = UIBarButtonItem.init(image: UIImage.init(named: imageName), style: .plain, target: self, action: #selector(munu))
        rightButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightButton;
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
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.selectionStyle = .none
        cell.textLabel?.text = sectionTitles[indexPath.row]
        
        
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
extension ViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            UIWindow.showTips(text: "🍎上的豌豆")
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
            
        case 7:
            XZBShareView.init().show()
            break
            
            
        case 8:
            XZBShareView.init().show()
            break
            
            
        case 9:
            XZBShareView.init().show()
            break
        default: break
            
        }
        
    }
}
extension ViewController:ChatTextViewDelegate {
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


