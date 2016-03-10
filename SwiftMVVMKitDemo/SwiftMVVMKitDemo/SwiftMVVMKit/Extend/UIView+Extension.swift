//
//  UIView+Extension.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/10.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

public class ClosureWrapper {
    var closure: ((events: AnyObject...) -> Void)?
    
    init(_ closure: ((events: AnyObject...) -> Void)?) {
        self.closure = closure
    }
}

public extension UIView {

    /// view中的事件Block
    typealias ViewEventsBlock = (events: AnyObject...) -> Void
    
    private struct AssociatedKey {
        static var viewExtension = "viewExtension"
    }
    
    var viewEventsBlock: ViewEventsBlock? {
        get {
            if let cl = objc_getAssociatedObject(self, &AssociatedKey.viewExtension) as? ClosureWrapper {
                return cl.closure
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.viewExtension, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}