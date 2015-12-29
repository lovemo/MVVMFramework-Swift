//
//  BQBaseViewModel.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit

class BQBaseViewModel: NSObject {
    weak var viewController: UIViewController?
    /**
     *  懒加载存放请求到的数据数组
     */
    lazy var dataArrayList:NSMutableArray = {
        return NSMutableArray()
    }()
    required override init() {
        
    }
    
    /**
     *  返回指定indexPath的item
     */
    func modelAtIndexPath(indexPath: NSIndexPath) -> AnyObject? {
        return nil
    }
    /**
     *  显示多少组 (当tableView为Group类型时设置可用)
     */
    func numberOfSections() -> Int {
        return 1
    }
    /**
     *  每组中显示多少行 (用于tableView)
     */
    func numberOfRowsInSection(section: Int) -> Int {
        return 0
    }
    /**
     *  每组中显示多少个 (用于collectionView)
     */
    func numberOfItemsInSection(section: Int) -> Int {
        return 0
    }
    /**
     *  分离加载首页控制器内容 (内部使用)
     */
    func getDataList(url: String!, params: [NSObject : AnyObject]!, success: (([AnyObject]!) -> Void)!, failure: ((NSError!) -> Void)!) {
        
    }
    /**
     *  用来判断是否加载成功,方便外部根据不同需求处理 (外部使用)
     */
    func getDataListSuccess(success: Void -> Void, failure: Void -> Void) {
        
    }
}
extension BQBaseViewModel {
    class func modelWithViewController(viewController: UIViewController) -> Self? {
        let model = self.init()
        model.viewController = viewController
        return model
    }
}
