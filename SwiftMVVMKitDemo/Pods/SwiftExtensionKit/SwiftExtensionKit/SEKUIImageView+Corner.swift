//
//  SEKUIImageView+Corner.swift
//  SwiftExtensionKitDemo
//
//  Created by yuantao on 16/3/3.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

extension UIImageView {
    
    override public func addCorner(radius radius: CGFloat) {
        self.image = self.image?.roundCornerImage(radius: radius, self.bounds.size)
    }
}