//
//  BQViewController.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit

let MyCellIdentifier = "BQCell"  // `cellIdentifier` AND `NibName` HAS TO BE SAME !

class BQViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    var tableHander: XTableDataDelegate?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    /**
    *  tableView的一些初始化工作
    */
    func setupTableView() {
        self.table.separatorStyle = .None;

        // 配置tableView的每个cell
        let configureCell: TableViewCellConfigureBlock = {(indexPath, obj, cell) -> Void in
            cell.configure(cell, customObj: obj, indexPath: indexPath)
        }

        // 设置点击tableView的每个cell做的一些工作
        let selectedBlock: DidSelectTableCellBlock  = { [weak self] (indexPath, item) -> Void in
            if let strongSelf = self {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewControllerWithIdentifier("ViewController2ID")
                strongSelf.presentViewController(vc, animated: true, completion: nil)
                print("click row : \((indexPath.row))")
            }
        }

        // 将上述block设置给tableHander
        self.tableHander = XTableDataDelegate.init(viewModel: BQViewModel(),
                                                                        cellIdentifier: MyCellIdentifier,
                                                                        configureCellBlock: configureCell,
                                                                        didSelectBlock: selectedBlock)
        // 设置UITableView的delegate和dataSourse为collectionHander
        self.tableHander?.handleTableViewDatasourceAndDelegate(self.table)

    }

}
