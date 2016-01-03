//
//  XTCollectionDataDelegate.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit

/**
 *  选中UICollectionViewCell的Block
 */
typealias DidSelectCollectionCellBlock = (NSIndexPath, AnyObject) -> Void
/**
 *  设置UICollectionViewCell大小的Block
 */
typealias CellItemSize = ( ) -> CGSize
/**
 *  获取UICollectionViewCell间隔Margin的Block
 */
typealias CellItemMargin = ( ) -> UIEdgeInsets


 // - - - - - -- - - - - - - - -- - - - 创建类 - -- - - - - -- -- - - - - -- - - -//
class XTCollectionDataDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var cellIdentifier = ""
    var collectionViewLayout: UICollectionViewLayout
    var didSelectCellBlock: DidSelectCollectionCellBlock
    var cellItemSize: CellItemSize
    var cellItemMargin: CellItemMargin
    var viewModel: BQBaseViewModel
    
    /**
     *  初始化方法
     */
    init(viewModel: BQBaseViewModel, cellIdentifier aCellIdentifier: String, collectionViewLayout: UICollectionViewLayout, cellItemSizeBlock cellItemSize: CellItemSize, cellItemMarginBlock cellItemMargin: CellItemMargin, didSelectBlock didselectBlock: DidSelectCollectionCellBlock) {
        
        self.viewModel = viewModel
        self.cellIdentifier = aCellIdentifier
        self.collectionViewLayout = collectionViewLayout
        self.cellItemSize = cellItemSize
        self.cellItemMargin = cellItemMargin
        self.didSelectCellBlock = didselectBlock
    }
    
    /**
    *  设置UICollectionViewCell大小
    */
    func ItemSize(cellItemSize: CellItemSize) {
        self.cellItemSize = cellItemSize
    }
    
    /**
    *  设置UICollectionViewCell间隔Margin
    */
    func itemInset(cellItemMargin: CellItemMargin) {
        self.cellItemMargin = cellItemMargin
    }
    
    /**
     *  获取CollectionView中Item所在的indexPath
     */
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return self.viewModel.dataArrayList[indexPath.item]
    }
    /**
     *  设置CollectionView的Datasource和Delegate为self
     */
    func handleCollectionViewDatasourceAndDelegate(collection: UICollectionView) {
        collection.collectionViewLayout = self.collectionViewLayout
        collection.backgroundColor = UIColor.whiteColor()
        collection.dataSource = self
        collection.delegate     = self

        
        // 第一次刷新数据
        self.viewModel.getDataListSuccess({ [weak collection] (Void) -> Void in
            if let strongCollection = collection {
     
                strongCollection.reloadData()
            }
            }, failure: { (Void) -> Void in
        })
        
        // 下拉刷新
        collection.mj_header = MJRefreshNormalHeader { [weak self] () -> Void in
            if let strongSelf = self {
                // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
                let time: NSTimeInterval = 2.0
                let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                dispatch_after(delay, dispatch_get_main_queue()) {
                    strongSelf.viewModel.getDataListSuccess({ [weak collection] (Void) -> Void in
                        if let strongCollection = collection {
                            strongCollection.reloadData()
                        }
                        }, failure: { (Void) -> Void in
                    })
                    // 结束刷新
                    collection.mj_header.endRefreshing()
                }
            }
        }
    }
    
    // MARK: -  UICollectionViewDelegateFlowLayout
    
    //定义每个Item 的大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.cellItemSize()
    }
    
    //定义每个UICollectionView 的 margin
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
         return self.cellItemMargin()
    }
    
    //定义每个UICollectionView 纵向的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

    // MARK: -  UICollectionViewDelegate && UICollectionViewDataSourse
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsInSection(section)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item: AnyObject? = self.itemAtIndexPath(indexPath)
        UICollectionViewCell.registerTable(collectionView, nibIdentifier: self.cellIdentifier)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath)
        cell.configure(cell, customObj: item!, indexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let item: AnyObject? = self.itemAtIndexPath(indexPath)
        self.didSelectCellBlock(indexPath, item!) ;
    }
    
    func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

}
