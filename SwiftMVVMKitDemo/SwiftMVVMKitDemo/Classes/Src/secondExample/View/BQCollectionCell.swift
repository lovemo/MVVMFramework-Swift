//
//  BQCollectionCell.swift
//  MVVMFramework-Swift
//
//  Created by momo on 15/12/29.
//  Copyright © 2015年 momo. All rights reserved.
//

import UIKit

class BQCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbHeight: UILabel!
    
    override func configure(cell: UICollectionViewCell, customObj obj: AnyObject, indexPath: NSIndexPath) {
        let mycell = cell as! BQCollectionCell
        mycell.lbTitle.text = "CollectionCell"
        mycell.lbHeight.text = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS. "
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.brownColor().CGColor
        self.layer.borderWidth = 2.0;
        self.layer.cornerRadius = 5.0;
    }
}
