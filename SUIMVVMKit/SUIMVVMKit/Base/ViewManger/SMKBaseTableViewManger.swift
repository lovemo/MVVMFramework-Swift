//
//  SMKBaseTableViewManger.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit
import MJRefresh

/// 选中UITableViewCell的Block
typealias didSelectTableCellBlock = (NSIndexPath, AnyObject) -> Void


 // - - - - - -- - - - - - - - -- - - - 创建类 - -- - - - - -- -- - - - - -- - - -//

class SMKBaseTableViewManger: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    lazy var myCellIdentifiers =  [String]()
    var didSelectCellBlock: didSelectTableCellBlock?
    var viewModel: SMKBaseViewModel?
    
    /**
     初始化方法
     
     - parameter viewModel:       viewModel
     - parameter aCellIdentifier: aCellIdentifier
     - parameter didselectBlock:  didselectBlock
     
     - returns: return value description
     */
    init(viewModel: SMKBaseViewModel?, cellIdentifiers: [String], didSelectBlock: didSelectTableCellBlock) {
        super.init()
        self.viewModel = viewModel
        self.myCellIdentifiers = cellIdentifiers
        self.didSelectCellBlock = didSelectBlock
    }

    /**
     设置UITableView的Datasource和Delegate为self
     
     - parameter table: UITableView
     */
    func handleTableViewDatasourceAndDelegate(table: UITableView) {
        
        table.dataSource = self
        table.delegate   = self

        // 第一次刷新数据
        viewModel?.smk_viewModelWithGetDataSuccessHandler({ [weak table] () -> () in
            if let strongTable = table {
                strongTable.reloadData()
            }
        })
        
        // 下拉刷新
       table.mj_header = MJRefreshNormalHeader { [weak self] () -> Void in
            if let strongSelf = self {
                strongSelf.viewModel?.smk_viewModelWithGetDataSuccessHandler({ [weak table] () -> () in
                        if let strongTable = table {
                            strongTable.reloadData()
                        }
                    })
                    // 结束刷新
                    table.mj_header.endRefreshing()
            }
        }
        table.mj_header.automaticallyChangeAlpha = true
    }
    
    /**
     获取UITableView中Item所在的indexPath
     
     - parameter indexPath: indexPath
     
     - returns: return value description
     */
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
            return viewModel!.smk_dataArrayList[indexPath.row];
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.smk_viewModelWithNumberOfRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item: AnyObject? = itemAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(myCellIdentifiers.first!)
        if cell == nil {
            UITableViewCell .registerTable(tableView, nibIdentifier: myCellIdentifiers.first!)
        }
        cell?.configure(cell!, customObj: item!, indexPath: indexPath)

        return cell!
    }

    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        UITableViewCell.registerTable(tableView, nibIdentifier: self.myCellIdentifiers.first!)
        let item: AnyObject? = self.itemAtIndexPath(indexPath)
        return tableView.fd_heightForCellWithIdentifier(self.myCellIdentifiers.first!, configuration: { (cell: AnyObject?) -> Void in
              cell?.configure(cell! as! UITableViewCell, customObj: item!, indexPath: indexPath)
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let item: AnyObject? = self.itemAtIndexPath(indexPath)
        self.didSelectCellBlock?(indexPath, item!)
    }
    
}

