//
//  BQViewModel2.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit

class BQViewModel2: BQBaseViewModel {
    
    override func numberOfItemsInSection(section: Int) -> Int {
        return self.dataArrayList.count
    }
    
    override func getDataList(url: String!, params: [NSObject : AnyObject]!, success: (([AnyObject]!) -> Void)!, failure: ((NSError) -> Void)!) {
        
        /**
        *  在这里进行首页控制器的网络请求加载和利用(MJExtension)转换模型
        */
        
        SVProgressHUD.show()
        // 模拟网络请求加载，设置延迟
        let time: NSTimeInterval = 1.0
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            for index in 0..<10 {
                let obj = BQTestModel()
                obj.name = "my name is ::\(index)"
                obj.height = Double(index)
                self.dataArrayList.addObject(obj)
            }
            if (success != nil) {
                SVProgressHUD.dismiss()
                success(self.dataArrayList as [AnyObject])
            }
            if ((failure) != nil) {
                SVProgressHUD.dismiss()
                //        failure(error!);
            }
            
        }
        
    }
    override func getDataListSuccess(success: Void -> Void, failure: Void -> Void) {
        // 实际开发中，将url 和 params 换为自己的值，demo测试时为nil即可
        self.getDataList(nil, params: nil, success: { (_: [AnyObject]!) -> Void in
            success();
            }) { (NSError) -> Void in
                failure();
        }
    }
    
}

