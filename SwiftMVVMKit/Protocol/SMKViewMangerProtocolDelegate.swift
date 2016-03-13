//
//  SMKViewMangerProtocolDelegate.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

@objc public protocol SMKViewMangerProtocolDelegate: NSObjectProtocol {

     /**
     设置Controller的子视图的管理者为self
     
     - parameter superView: 一般指subView所在控制器的view
     
     - returns: return value description
     */
    optional func smk_viewMangerWithSuperView(superView: UIView)
    
     /**
     设置subView的管理者为self
     
     - parameter subView: 管理的subView
     
     - returns: return value description
     */
    optional func smk_viewMangerWithSubView(subView: UIView?)
    
     /**
     设置添加subView的事件
     
     - parameter subView: 管理的subView
     - parameter info:    附带信息，用于区分调用
     
     - returns: return value description
     */
    optional func smk_viewMangerWithHandleOfSubView(subView: UIView, info: String?)
    
     /**
     返回viewManger所管理的视图
     
     - returns: viewManger所管理的视图
     */
    optional func smk_viewMangerOfSubView() -> UIView
    
     /**
     得到其它viewManger所管理的subView，用于自己内部
     
     - parameter viewInfos: 其它的subViews
     
     - returns: return value description
     */
    optional func smk_viewMangerWithOtherSubViews(viewInfos: [NSObject : AnyObject]?)
    
     /**
     需要重新布局subView时，更改subView的frame或者约束
     
     - parameter updateBlock: 更新布局完成的block
     */
    optional func smk_viewMangerWithLayoutSubViews(updateBlock: (( ) -> ( ))?)
    
    /**
     使子视图更新到最新的布局约束或者frame
     */
    optional func smk_viewMangerWithUpdateLayoutSubViews()

    /**
     将model数据传递给viewManger
     
     - parameter dictBlock: dictBlock description
     */
    optional func smk_viewMangerWithModel(dictBlock: (( ) -> [NSObject : AnyObject]?)?)
}

