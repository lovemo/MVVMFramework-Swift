//
//  SEKUIViewController+Storyboard.swift
//  SwiftExtensionKitDemo
//
//  Created by yuantao on 16/3/8.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public class func viewControllerWithStoryboardName(stroryboardName: String, vcIdentifier: String) -> UIViewController {
        let sb = UIStoryboard(name: stroryboardName, bundle: NSBundle.mainBundle())
        return sb.instantiateViewControllerWithIdentifier(vcIdentifier)
    }
    
}
