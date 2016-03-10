//
//  ThirdView.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

class ThirdView: UIView {

    @IBOutlet weak var testLabel: UILabel!
    
    // 按钮事件 <自定义方法>
    @IBAction func testBtnClick(sender: UIButton) {
//        // 传递事件
//        if let _ = delegate {
//            if delegate!.respondsToSelector(Selector("smk_view:events:")) {
//                delegate?.smk_view?(self, events: ["click": "btn"])
//            }
//        }
        // 传递事件
        if let _ = viewEventsBlock {
            viewEventsBlock!(events: "clicked","me")
        }
    }

    // 按钮事件 <遵循协议代理方法>
    @IBAction func jumpOtherVC(sender: UIButton) {
        // 传递事件
        if let _ = delegate {
            if delegate!.respondsToSelector(Selector("smk_view:events:")) {
                delegate?.smk_view?(self, events: ["jump": "vc"])
            }
        }
        
    }

    // 根据模型数据配置View

    override func configureViewWithCustomObj(obj: NSObject?) {
            if let  _  = obj {
                let thirdModel = obj as? ThirdModel
                testLabel.text = thirdModel!.title;
            }
    }

}
