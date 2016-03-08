//
//  UICollectionViewCell+Extension.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import Foundation
import UIKit

public extension UITableViewCell {
    
    class internal func nibWithIdentifier(identifier: String) -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }

    /**
     从nib文件中根据重用标识符注册UITableViewCell
     
     - parameter table:      table description
     - parameter identifier: identifier description
     */
    class func registerTable(table: UITableView, nibIdentifier identifier: String) {
        return table.registerNib(self.nibWithIdentifier(identifier), forCellReuseIdentifier: identifier)
    }

    /**
     配置UITableViewCell，设置UITableViewCell内容
     
     - parameter cell:      cell description
     - parameter obj:       obj description
     - parameter indexPath: indexPath description
     */
    func configure(cell: UITableViewCell, customObj obj: AnyObject, indexPath: NSIndexPath) {
          // Rewrite this func in SubClass !
    }

    /**
     获取自定义对象的cell高度 (已集成UITableView+FDTemplateLayoutCell，现在创建的cell自动计算高度)
     
     - parameter obj:       obj description
     - parameter indexPath: indexPath description
     
     - returns: return value description
     */
    class func getCellHeightWithCustomObj(obj: AnyObject?, indexPath: NSIndexPath) -> CGFloat {
        // Rewrite this func in SubClass if necessary
        return obj == nil ? 44.0 : 0.0   // default cell height 44.0
    }
}