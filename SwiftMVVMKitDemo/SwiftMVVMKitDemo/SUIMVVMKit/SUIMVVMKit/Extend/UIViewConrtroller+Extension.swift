//
//  UIViewConrtroller+Extension.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/8.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public class func smk_viewControllerWithStoryboardName(stroryboardName: String, vcIdentifier: String) -> UIViewController {
        let sb = UIStoryboard(name: stroryboardName, bundle: NSBundle.mainBundle())
        return sb.instantiateViewControllerWithIdentifier(vcIdentifier)
    }
    
}