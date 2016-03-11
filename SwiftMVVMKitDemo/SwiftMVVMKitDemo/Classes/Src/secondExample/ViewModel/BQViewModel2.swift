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

class BQViewModel2: NSObject, SMKViewModelProtocolDelegate {

    func smk_viewModelWithGetDataSuccessHandler(successHandler: ((array: [AnyObject]) -> ())?) {
        let url = "http://news-at.zhihu.com/api/4/news/latest"
        SMKHttp.get(url, params: nil, success: { (json: AnyObject!) -> Void in
            
            let array = json["stories"]
            BQTestModel.mj_setupReplacedKeyFromPropertyName({ () -> [NSObject : AnyObject]! in
                return ["ID": "id"]
            })
            let models = BQTestModel.mj_objectArrayWithKeyValuesArray(array)
            if let _ = successHandler {
                successHandler!(array: models as [AnyObject])
            }

            }) { (_) -> Void in
                
        }
    
    }
    
}

