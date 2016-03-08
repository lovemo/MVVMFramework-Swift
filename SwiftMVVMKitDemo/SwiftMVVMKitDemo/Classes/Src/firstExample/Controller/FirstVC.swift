//
//  FirstVC.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit
import MJExtension

let MyCellIdentifier = "BQCell"  // `cellIdentifier` AND `NibName` HAS TO BE SAME !

class FirstVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    /**
     tableView的一些初始化工作
     */
    func setupTableView() {

        self.table.separatorStyle = .None
        table.tableHander = SMKBaseTableViewManger.init(viewModel: BQViewModel(), cellIdentifiers: [MyCellIdentifier], didSelectBlock: { (_, _) -> Void in
            let vc = UIViewController.smk_viewControllerWithStoryboardName("Main", vcIdentifier: "SecondVCID")
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
}
