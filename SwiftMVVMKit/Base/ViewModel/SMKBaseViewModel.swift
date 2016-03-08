//
//  SMKBaseViewModel.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit

class SMKBaseViewModel: NSObject, SMKViewModelProtocolDelegate {
    
    /// UIViewController
    weak var smk_viewController: UIViewController?
    
    /// 懒加载存放请求到的数据数组
    lazy var smk_dataArrayList: NSMutableArray = {
        return NSMutableArray()
    }()
    

    /**
     用来判断是否加载成功,方便外部根据不同需求处理 (外部使用)
     
     - parameter successHandler: successHandler description
     */
    func smk_viewModelWithGetDataSuccessHandler(successHandler: (( ) -> ( ))?) {
        
    }
    
    func smk_viewModelWithNumberOfRowsInSection(section: Int) -> Int {
        return 0
    }
    
    func smk_viewModelWithNumberOfItemsInSection(section: Int) -> Int {
        return 0
    }
}
