//
//  SMKBaseCollectionViewManger.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

/// 选中UICollectionViewCell的Block
typealias didSelectCollectionCellBlock = (NSIndexPath, AnyObject) -> Void

/// 设置UICollectionViewCell大小的Block
typealias cellItemSize = ( ) -> CGSize

///  获取UICollectionViewCell间隔Margin的Block
typealias cellItemMargin = ( ) -> UIEdgeInsets


// - - - - - -- - - - - - - - -- - - - 创建类 - -- - - - - -- -- - - - - -- - - -//
class SMKBaseCollectionViewManger: NSObject, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    lazy var smk_dataArrayList = []
    var myCellIdentifiers = [String]()
    var collectionViewLayout: UICollectionViewLayout
    var didSelectCellBlock: didSelectCollectionCellBlock
    var itemSize: cellItemSize
    var itemMargin: cellItemMargin
    
    /**
     初始化方法
     
     - parameter cellIdentifiers:      cellIdentifiers description
     - parameter collectionViewLayout: collectionViewLayout description
     - parameter itemSize:             itemSize description
     - parameter itemMargin:           itemMargin description
     - parameter didselectBlock:       didselectBlock description
     
     - returns: return value description
     */
    init(cellIdentifiers: [String], collectionViewLayout: UICollectionViewLayout, cellItemSizeBlock itemSize: cellItemSize, cellItemMarginBlock itemMargin: cellItemMargin, didSelectBlock didselectBlock: didSelectCollectionCellBlock) {
        
        self.myCellIdentifiers = cellIdentifiers
        self.collectionViewLayout = collectionViewLayout
        self.itemSize = itemSize
        self.itemMargin = itemMargin
        self.didSelectCellBlock = didselectBlock
    }
    
    /**
     设置UICollectionViewCell大小
     
     - parameter itemSize: itemSize description
     */
    func ItemSize(itemSize: cellItemSize) {
        self.itemSize = itemSize
    }
    
    /**
     设置UICollectionViewCell间隔Margin
     
     - parameter itemMargin: itemMargin description
     */
    func itemInset(itemMargin: cellItemMargin) {
        self.itemMargin = itemMargin
    }
    
    /**
     获取CollectionView中Item所在的indexPath
     
     - parameter indexPath: indexPath description
     
     - returns: return value description
     */
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return smk_dataArrayList[indexPath.item]
    }
    
    /**
     设置CollectionView的Datasource和Delegate为self
     
     - parameter collection: collection description
     */
    func handleCollectionViewDatasourceAndDelegate(collection: UICollectionView) {
        collection.collectionViewLayout = self.collectionViewLayout
        collection.dataSource = self
        collection.delegate     = self
    }
    
    /**
     获取模型数组
     
     - parameter modelArrayBlock: 返回模型数组Block
     - parameter completion:      获取数据完成时
     */
    func getItemsWithModelArray(modelArrayBlock:( () -> [AnyObject] )?, completion: (() -> ())?) -> Void {
        if let _ = modelArrayBlock {
            smk_dataArrayList = modelArrayBlock!()
            if let _ = completion {
                completion!()
            }
        }
        
    }
    
    // MARK: -  UICollectionViewDelegateFlowLayout
    
    // 定义每个Item 的大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.itemSize()
    }
    
    // 定义每个UICollectionView 的 margin
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return self.itemMargin()
    }
    
    // 定义每个UICollectionView 纵向的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: -  UICollectionViewDelegate && UICollectionViewDataSourse
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smk_dataArrayList.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item: AnyObject? = self.itemAtIndexPath(indexPath)
        UICollectionViewCell.registerTable(collectionView, nibIdentifier: self.myCellIdentifiers.first!)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.myCellIdentifiers.first!, forIndexPath: indexPath)
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
