//
//  XTTableDataDelegate.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit

/**
 *  配置UITableViewCell的内容Block
 */
typealias TableViewCellConfigureBlock = (NSIndexPath, AnyObject, UITableViewCell) -> Void
/**
 *  选中UITableViewCell的Block
 */
typealias DidSelectTableCellBlock = (NSIndexPath, AnyObject) -> Void
/**
 *  设置UITableViewCell高度的Block (已集成UITableView+FDTemplateLayoutCell，现在创建的cell自动计算高度)
 */
typealias CellHeightBlock = (NSIndexPath, AnyObject) -> CGFloat


 // - - - - - -- - - - - - - - -- - - - 创建类 - -- - - - - -- -- - - - - -- - - -//

class XTableDataDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var cellIdentifier = ""
    var configureCellBlock: TableViewCellConfigureBlock?
    var heightConfigureBlock: CellHeightBlock?
    var didSelectCellBlock: DidSelectTableCellBlock?
    var viewModel: BQBaseViewModel?
    
    /**
     *  初始化方法
     */
    init(viewModel: BQBaseViewModel, cellIdentifier aCellIdentifier: String, configureCellBlock aConfigureCellBlock: TableViewCellConfigureBlock, didSelectBlock didselectBlock: DidSelectTableCellBlock) {
        
        self.viewModel = viewModel
        self.cellIdentifier = aCellIdentifier
        self.configureCellBlock = aConfigureCellBlock
        self.didSelectCellBlock = didselectBlock
    }
    /**
     *  设置UITableView的Datasource和Delegate为self
     */
    func handleTableViewDatasourceAndDelegate(table: UITableView) {
        
        table.dataSource = self ;
        table.delegate   = self ;

        // 第一次刷新数据
        self.viewModel?.getDataListSuccess({ [weak table] (Void) -> Void in
            if let strongTable = table {
                strongTable.reloadData()
            }
            }, failure: { (Void) -> Void in
        })

        // 下拉刷新
       table.mj_header = MJRefreshNormalHeader { [weak self] () -> Void in
            if let strongSelf = self {
                // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
                let time: NSTimeInterval = 2.0
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                dispatch_after(delay, dispatch_get_main_queue()) {
                    strongSelf.viewModel?.getDataListSuccess({ [weak table] (Void) -> Void in
                        if let strongTable = table {
                            strongTable.reloadData()
                        }
                        }, failure: { (Void) -> Void in
                    })
                    // 结束刷新
                    table.mj_header.endRefreshing()
                }
            }
        }
    }
    
    /**
     *  获取UITableView中Item所在的indexPath
     */
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
            return self.viewModel!.dataArrayList[indexPath.row];
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (self.viewModel?.numberOfSections())!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.viewModel?.numberOfRowsInSection(section))!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item: AnyObject? = self.itemAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier)
        if cell == nil {
            UITableViewCell .registerTable(tableView, nibIdentifier: self.cellIdentifier)
        }
    
        self.configureCellBlock?(indexPath, item!, cell!)
        return cell!
    }

    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        UITableViewCell.registerTable(tableView, nibIdentifier: self.cellIdentifier)
        let item: AnyObject? = self.itemAtIndexPath(indexPath)
        return tableView.fd_heightForCellWithIdentifier(self.cellIdentifier, configuration: { (cell: AnyObject?) -> Void in
            self.configureCellBlock!(indexPath, item!, cell as! UITableViewCell)
        })
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let item: AnyObject? = self.itemAtIndexPath(indexPath)
        self.didSelectCellBlock?(indexPath, item!)
    }
    
}

    
