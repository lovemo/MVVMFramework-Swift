//
//  UIView+Configure.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit
public extension UIView {
    
    /**
     根据obj配置UIView，设置UIView内容
     
     - parameter obj: obj description
     */
    public func configureViewWithCustomObj(obj: NSObject?) {
        
    }
    
    private struct AssociatedKey {
        static var viewExtension = "viewExtension"
    }
    
    weak var delegate: SMKViewProtocolDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.viewExtension) as? SMKViewProtocolDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.viewExtension, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
