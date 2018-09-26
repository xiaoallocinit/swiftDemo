//
//  ViewController.swift
//  demo
//
//  Created by yinian on 2018/9/26.
//  Copyright © 2018年 xiao. All rights reserved.
//

import UIKit

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
    fileprivate let cellIdentifier = "tableViewCell"
    fileprivate let sectionTitles = ["",
                                     "ShowTips",
                                     "ShowSwiftMessages",
                                     "Share分享仿抖音",
                                     "XZBSystemActionSheet",
                                     "XZBActionSheet",
                                     "YawRotation",
                                     "ScaleAnimation",
                                     "Custom"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(table)
        self.title = "🍎上的豌豆"
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
        default: break
            
        }
        
    }
}
