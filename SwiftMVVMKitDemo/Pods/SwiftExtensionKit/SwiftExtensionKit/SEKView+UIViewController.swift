//
//  SEKView+UIViewController.swift
//  SwiftExtensionKitDemo
//
//  Created by yuantao on 16/3/8.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit
public extension UIView {
    
    /**
     找到当前view所在的viewcontroler
     
     - returns: UIViewController
     */
    public func viewController() -> UIViewController? {
        var next: UIView?
        for next = self.superview; (next != nil); next = next!.superview {
            let nextResponder = next!.nextResponder()
            if nextResponder!.isKindOfClass(UIViewController.classForCoder()) {
                return nextResponder as? UIViewController
            }
        }
        return nil
    }
    
}
