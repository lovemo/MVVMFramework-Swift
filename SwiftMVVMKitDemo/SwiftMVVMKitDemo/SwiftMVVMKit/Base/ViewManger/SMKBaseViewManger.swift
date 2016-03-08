//
//  SMKBaseViewManger.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

class SMKBaseViewManger: NSObject, SMKViewMangerProtocolDelegate {

    /// 用于传递数据的基模型
    var smk_model: NSObject?
    
    override init() {
        super.init()
        self.smk_viewMangerWithSubView(nil)
    }
    
    func smk_viewMangerWithSubView(subView: UIView?) {
        
    }
}