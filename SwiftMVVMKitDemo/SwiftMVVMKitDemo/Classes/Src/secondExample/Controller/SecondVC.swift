//
//  SecondVC.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

let MyCellIdentifier2 = "BQCollectionCell" // `cellIdentifier` AND `NibName` HAS TO BE SAME !

class SecondVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var viewModel = BQViewModel2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        
    }

    /**
     collectionView的一些初始化工作
     */
    func setupCollectionView()
    {
        
        collectionView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0)
        
        // 设置点击collectionView的每个item做的一些工作
        let selectedBlock: didSelectCollectionCellBlock  = {(indexPath, item) -> Void in
            print("click row : \((indexPath.row))")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        // 配置collectionView的每个item的size
        let cellItemSizeBlock: cellItemSize  = {
            return CGSizeMake(110, 160)
        }
        // 配置collectionView的每个item的margin
        let cellItemMarginBlock: cellItemMargin  = {
            return UIEdgeInsetsMake(0, 20, 0, 20)
        }
        
        // 将上述block设置给collectionHander  // 可用自定义UICollectionViewLayout
        self.collectionView.collectionHander = SMKBaseCollectionViewManger(cellIdentifiers: [MyCellIdentifier2], collectionViewLayout: UICollectionViewFlowLayout(), cellItemSizeBlock: cellItemSizeBlock, cellItemMarginBlock: cellItemMarginBlock, didSelectBlock: selectedBlock)
        
        viewModel.smk_viewModelWithGetDataSuccessHandler { (array) -> () in
            self.collectionView.collectionHander.getItemsWithModelArray({ () -> [AnyObject] in
                    return array
                }, completion: { () -> () in
                    self.collectionView.reloadData()
            })
        }
    }
    
}
