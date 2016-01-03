//
//  BQViewController2.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit

let MyCellIdentifier2 = "BQCollectionCell" // `cellIdentifier` AND `NibName` HAS TO BE SAME !

class BQViewController2: UIViewController {
    var collectionHander: XTCollectionDataDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()

        // Do any additional setup after loading the view.
    }
    /**
    *  collectionView的一些初始化工作
    */
    func setupCollectionView()
    {
    
        // 设置点击collectionView的每个item做的一些工作
        let selectedBlock: DidSelectCollectionCellBlock  = {(indexPath, item) -> Void in
            print("click row : \((indexPath.row))")
           self.dismissViewControllerAnimated(true, completion: nil)
        } ;
        // 配置collectionView的每个item的size
        let cellItemSizeBlock: CellItemSize  = {
            return CGSizeMake(110, 120)
        };
        // 配置collectionView的每个item的margin
        let cellItemMarginBlock: CellItemMargin  = {
            return UIEdgeInsetsMake(0, 20, 0, 20)
        };
        // 将上述block设置给collectionHander
        self.collectionHander = XTCollectionDataDelegate.init(viewModel: BQViewModel2(),
                                                                                    cellIdentifier: MyCellIdentifier2,
                                                                                    collectionViewLayout:UICollectionViewFlowLayout(), // 可用自定义UICollectionViewLayout
                                                                                    cellItemSizeBlock: cellItemSizeBlock,
                                                                                    cellItemMarginBlock: cellItemMarginBlock,
                                                                                    didSelectBlock: selectedBlock)
        // 设置UICollectionView的delegate和dataSourse为collectionHander
        self.collectionHander?.handleCollectionViewDatasourceAndDelegate(self.collectionView)
    
    }

}
