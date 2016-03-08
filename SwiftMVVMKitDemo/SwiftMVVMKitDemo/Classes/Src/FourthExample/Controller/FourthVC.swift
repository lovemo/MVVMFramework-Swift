//
//  FourthVC.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

class FourthVC: UIViewController {

    lazy var fourthViewManger1 = FourthViewManger()
    lazy var fourthViewManger2 = FourthViewManger2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 得到父视图
        fourthViewManger1.smk_viewMangerWithSuperView(self.view)
        fourthViewManger2.smk_viewMangerWithSuperView(self.view)
        
        // 传入其他Views
        fourthViewManger2.smk_viewMangerWithOtherSubViews(["view1": fourthViewManger1.smk_viewMangerOfSubView()])
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 更新视图block
        fourthViewManger1.smk_viewMangerWithLayoutSubViews { () -> () in
            self.fourthViewManger2.smk_viewMangerWithUpdateLayoutSubViews()
        }
    }

}
