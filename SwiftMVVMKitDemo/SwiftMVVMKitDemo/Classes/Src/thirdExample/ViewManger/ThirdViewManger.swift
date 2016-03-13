//
//  ThirdViewManger.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit
import SwiftExtensionKit

class ThirdViewManger: NSObject, SMKViewMangerProtocolDelegate, SMKViewProtocolDelegate {
    
    lazy var thirdView = ThirdView.loadInstanceFromNib() as? ThirdView
    lazy var dict = [ : ]
    
    override init() {
        super.init()
        
        thirdView?.delegate = self
        // btnClickBlock
        thirdView?.viewEventsBlock = { (events: AnyObject...) -> ( ) in
            for event in events {
                print(event)
            }
            self.smk_viewMangerWithHandleOfSubView(self.thirdView!, info: "click")
        }
    }

    // UIView的delegate方法 ，两种消息传递方式，开发时任选其一即可 根据传入的events信息处理事件
    func smk_view(view: UIView, events: [NSObject : AnyObject]?) {
        
        print("----------\(events)")
        for key in events!.keys {
            if key == "jump" {
                let firstVC = UIViewController.viewControllerWithStoryboardName("Main", vcIdentifier: "FirstVCID")
                view.viewController()?.navigationController?.pushViewController(firstVC, animated: true)
            }
        }

    }
    
    // 得到父视图，添加subView -> superView
    func smk_viewMangerWithSuperView(superView: UIView) {
        thirdView?.frame = CGRectMake(0, 66, UIScreen.mainScreen().bounds.size.width, 200);
        superView.addSubview(thirdView!)
    }
    
    // 根据传入的info设置添加subView的事件
    func smk_viewMangerWithHandleOfSubView(subView: UIView, info: String?) {
        if info == "click" {
            subView.configureViewWithCustomObj(dict["model"] as? NSObject)
        }
    }
    
    // 得到传入的模型数据
    func smk_viewMangerWithModel(dictBlock: (() -> [NSObject : AnyObject]?)?) {
        if let _ = dictBlock {
            dict = dictBlock!()!
        }
    }
    

}
