//
//  FourthViewManger2.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

class FourthViewManger2: NSObject, SMKViewMangerProtocolDelegate {

    lazy var fourthView2 = FourthView2.loadInstanceFromNib()
    lazy var fourthView = UIView()
    
    func smk_viewMangerWithSuperView(superView: UIView) {
        superView.addSubview(fourthView2)
    }

    // 根据自身需要得到外界的视图view
    func smk_viewMangerWithOtherSubViews(viewInfos: [NSObject : AnyObject]?) {
        
        let view1 = viewInfos!["view1"] as! UIView
        fourthView = view1
        
        fourthView2.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(250, 250));
            make.top.equalTo(view1.snp_bottom).offset(20);
            make.left.equalTo(view1);
        }

    }
    
    // 根据外界view或model的变化重新布局自己所管理的字视图的位置
    func smk_viewMangerWithUpdateLayoutSubViews() {
        let  offset = CGFloat(arc4random_uniform(70) + 10)
        let  wh = CGFloat(arc4random_uniform(200) + 50)
        let  size = CGSizeMake(wh, wh)
        
        fourthView2.snp_updateConstraints { (make) -> Void in
            make.top.equalTo(self.fourthView.snp_bottom).offset(offset);
            make.size.equalTo(size);
        }
        
        fourthView2.setNeedsLayout()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.fourthView2.layoutIfNeeded()
        }
    }

}
