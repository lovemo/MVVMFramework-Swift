//
//  SMKViewProtocolDelegate.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

@objc public protocol SMKViewProtocolDelegate: NSObjectProtocol {
    
     /**
     将view中的事件通过代理传递出去
     
     - parameter view:   view自己
     - parameter events: 所触发事件的一些描述信息
     */
    optional func smk_view(view: UIView,  events: [NSObject : AnyObject]?)
}