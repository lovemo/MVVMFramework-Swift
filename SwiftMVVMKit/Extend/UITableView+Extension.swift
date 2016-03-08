//
//  UITableView+Extension.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

extension UITableView {
    
    private struct AssociatedKey {
        static var viewExtension = "viewExtension"
    }
    
    var tableHander: SMKBaseTableViewManger {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.viewExtension) as! SMKBaseTableViewManger
        }
        set {
            newValue.handleTableViewDatasourceAndDelegate(self)
            objc_setAssociatedObject(self, &AssociatedKey.viewExtension, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
