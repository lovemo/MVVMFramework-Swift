//
//  SMKBaseTableViewManger.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell

/// 选中UITableViewCell的Block
typealias didSelectTableCellBlock = (NSIndexPath, AnyObject) -> Void


 // - - - - - -- - - - - - - - -- - - - 创建类 - -- - - - - -- -- - - - - -- - - -//

class SMKBaseTableViewManger: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    lazy var myCellIdentifiers =  [String]()
    lazy var smk_dataArrayList = []
    var didSelectCellBlock: didSelectTableCellBlock?
    
    /**
     初始化方法
     
     - parameter aCellIdentifier: aCellIdentifier
     - parameter didselectBlock:  didselectBlock
     
     - returns: return value description
     */
    init(cellIdentifiers: [String], didSelectBlock: didSelectTableCellBlock) {
        super.init()
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

    }
    
     /**
     获取模型数组
     
     - parameter modelArrayBlock: 返回模型数组Block
     - parameter completion:      获取数据完成时
     */
    func getItemsWithModelArray(modelArrayBlock:( () -> [AnyObject] )?, completion: (() -> ())?) -> Void {
        if let _ = modelArrayBlock {
            smk_dataArrayList = modelArrayBlock!()
            if let _ = completion {
                completion!()
            }
        }

    }
    
    /**
     获取UITableView中Item所在的indexPath
     
     - parameter indexPath: indexPath
     
     - returns: return value description
     */
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
            return smk_dataArrayList[indexPath.row];
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smk_dataArrayList.count
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

