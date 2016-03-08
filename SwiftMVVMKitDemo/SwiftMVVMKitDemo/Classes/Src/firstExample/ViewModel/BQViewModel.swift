//
//  BQViewModel.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit
import SUIMVVMNetwork

class BQViewModel: SMKBaseViewModel {

    override func smk_viewModelWithNumberOfRowsInSection(section: Int) -> Int {
        return smk_dataArrayList.count
    }
    override func smk_viewModelWithGetDataSuccessHandler(successHandler: (() -> ())?) {
        let url = "http://news-at.zhihu.com/api/4/news/latest"
        SMKHttp.get(url, params: nil, success: { (json: AnyObject!) -> Void in
            let array = json["stories"]
            self.smk_dataArrayList = FirstModel.mj_objectArrayWithKeyValuesArray(array)
            if let _ = successHandler {
                successHandler!()
            }
            }) { (error: NSError!) -> Void in
                
        }
    }
    
}
