//
//  UICollectionView+Extension.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    private struct AssociatedKey {
        static var viewExtension = "viewExtension"
    }
    
    var collectionHander: SMKBaseCollectionViewManger {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.viewExtension) as! SMKBaseCollectionViewManger
        }
        set {
            newValue.handleCollectionViewDatasourceAndDelegate(self)
            objc_setAssociatedObject(self, &AssociatedKey.viewExtension, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}