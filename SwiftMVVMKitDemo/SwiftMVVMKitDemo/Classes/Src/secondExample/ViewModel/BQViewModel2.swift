//
//  BQViewModel2.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit
import SUIMVVMNetwork
import MJExtension

class BQViewModel2: SMKBaseViewModel {

    override func smk_viewModelWithNumberOfItemsInSection(section: Int) -> Int {
        return smk_dataArrayList.count
    }
    
    override func smk_viewModelWithGetDataSuccessHandler(successHandler: (() -> ())?) {
        let url = "http://news-at.zhihu.com/api/4/news/latest"
        SMKHttp.get(url, params: nil, success: { (json: AnyObject!) -> Void in
            let array = json["stories"]
            BQTestModel.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject : AnyObject]! in
                return ["ID": "id"]
            })
            self.smk_dataArrayList = BQTestModel.mj_objectArrayWithKeyValuesArray(array)
            if let _ = successHandler {
                successHandler!()
            }
            }) { (error: NSError!) -> Void in
                
        }

    }
    
}

