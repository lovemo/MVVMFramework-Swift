//
//  FirstVC.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit
import MJRefresh

let MyCellIdentifier = "BQCell"  // `cellIdentifier` AND `NibName` HAS TO BE SAME !

class FirstVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    lazy var viewModel = BQViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    /**
     tableView的一些初始化工作
     */
    func setupTableView() {

        table.separatorStyle = .None
        
        // 下拉刷新
       table.mj_header = MJRefreshNormalHeader { [weak self] () -> Void in
            if let strongSelf = self {
                strongSelf.viewModel.smk_viewModelWithGetDataSuccessHandler({ (array) -> () in
                    strongSelf.table.reloadData()
                })
                // 结束刷新
                self!.table.mj_header.endRefreshing()
            }
        }
        table.mj_header.automaticallyChangeAlpha = true
        
        table.tableHander = SMKBaseTableViewManger(cellIdentifiers: [MyCellIdentifier], didSelectBlock: { (_, _) -> Void in
            let vc = UIViewController.viewControllerWithStoryboardName("Main", vcIdentifier: "SecondVCID")
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        viewModel.smk_viewModelWithGetDataSuccessHandler { (array) -> () in
            self.table.tableHander .getItemsWithModelArray({ () -> [AnyObject] in
                    return array
                }, completion: { () -> () in
                    self.table.reloadData()
            })
        }
    }
}
