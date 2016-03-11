//
//  BQViewModel.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit
import SUIMVVMNetwork

class BQViewModel: NSObject, SMKViewModelProtocolDelegate {

    func smk_viewModelWithGetDataSuccessHandler(successHandler: ((array: [AnyObject]) -> ())?) {
        let url = "http://news-at.zhihu.com/api/4/news/latest"
        SMKHttp.get(url, params: nil, success: { (json: AnyObject!) -> Void in
            let array = json["stories"]
            let models = FirstModel.mj_objectArrayWithKeyValuesArray(array)
            if let _ = successHandler {
                successHandler!(array: models as [AnyObject])
            }
            }) { (error: NSError!) -> Void in
                
        }
    }
    
}
