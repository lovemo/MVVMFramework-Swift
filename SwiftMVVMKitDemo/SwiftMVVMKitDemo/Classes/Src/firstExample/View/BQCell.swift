//
//  BQCell.swift
//  SwiftMVVMKitDemo
//
//  Created by yuantao on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

class BQCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbHeight: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    
    override func configure(cell: UITableViewCell, customObj obj: AnyObject, indexPath: NSIndexPath) {
        let model = obj as! FirstModel
        self.lbTitle.text = model.title
        
        let lengthStr = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and apps run lightning-fast. Swift is ready for your next project — or addition into your current app — because Swift code works side-by-side with Objective-C."
        
        let shortStr = "Swift. A modern programming language that is safe, fast, and interactive."
        
        self.lbHeight.text = ((indexPath.row) % 2 == 0) ? lengthStr : shortStr
        self.contentImage.image = ((indexPath.row) % 2 == 0) ? UIImage(named: "phil") : UIImage(named: "dogebread")
    }

}
