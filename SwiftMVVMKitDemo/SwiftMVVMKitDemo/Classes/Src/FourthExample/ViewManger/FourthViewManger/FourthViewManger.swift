//
//  FourthViewManger.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit
import SnapKit

class FourthViewManger: NSObject, SMKViewMangerProtocolDelegate {

    lazy var fourthView = FourthView.loadInstanceFromNib()
    
    // 得到自己所管理subView的父视图，并添加到父视图上
    func smk_viewMangerWithSuperView(superView: UIView) {
        superView.addSubview(fourthView)

        fourthView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(100, 100))
            make.centerY.equalTo(superView).offset(-100)
            make.left.equalTo(60)
        }

    }

    // 返回自己所管理的View，降低耦合性
    func smk_viewMangerOfSubView() -> UIView {
        return fourthView
    }
    
    // 根据model的变化重新布局自己所管理的字视图的位置，并用block回调给控制器
    func smk_viewMangerWithLayoutSubViews(updateBlock: (() -> ())?) {
        let leftLength = CGFloat(arc4random_uniform(100) + 20)
        let heightLength = CGFloat(arc4random_uniform(150) + 20)
        
        fourthView.snp_updateConstraints { (make) -> Void in
            make.left.equalTo(leftLength)
            make.height.equalTo(heightLength)
        }
        
        fourthView.setNeedsLayout()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.fourthView.layoutIfNeeded()
        }
        if let _ = updateBlock {
            updateBlock!()
        }
    }
    
}
