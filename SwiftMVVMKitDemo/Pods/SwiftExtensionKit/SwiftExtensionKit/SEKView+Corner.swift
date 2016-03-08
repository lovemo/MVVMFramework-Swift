//
//  SEKView+Corner.swift
//  SwiftExtensionKitDemo
//
//  Created by yuantao on 16/3/3.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

extension UIView {
    
    public func addCorner(radius radius: CGFloat) {
        self.addCorner(radius: radius, borderWidth: 1, backgroundColor: UIColor.redColor(), borderColor: UIColor.blackColor())
    }
    
    private func addCorner(radius radius: CGFloat,
        borderWidth: CGFloat,
        backgroundColor: UIColor,
        borderColor: UIColor) {
            let imageView = UIImageView(image: roundCorner(radius: radius,
                borderWidth: borderWidth,
                backgroundColor: backgroundColor,
                borderColor: borderColor))
            
            self.insertSubview(imageView, atIndex: 0)
    }
    
    private func roundCorner(radius radius: CGFloat,
        borderWidth: CGFloat,
        backgroundColor: UIColor,
        borderColor: UIColor) -> UIImage {
            
            self.backgroundColor = UIColor.clearColor()
            
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.mainScreen().scale)
            let context = UIGraphicsGetCurrentContext()
            
            let width = self.bounds.size.width;
            let height = self.bounds.size.height;
            
            // 移动到初始点
            CGContextMoveToPoint(context, radius, 0);
            
            // 绘制第1条线和第1个1/4圆弧
            CGContextAddLineToPoint(context, width - radius, 0);
            CGContextAddArc(context, width - radius, radius, radius, CGFloat(-0.5 * M_PI), 0.0, 0);
            
            // 绘制第2条线和第2个1/4圆弧
            CGContextAddLineToPoint(context, width, height - radius);
            CGContextAddArc(context, width - radius, height - radius, radius, 0.0, CGFloat(0.5 * M_PI), 0);
            
            // 绘制第3条线和第3个1/4圆弧
            CGContextAddLineToPoint(context, radius, height);
            CGContextAddArc(context, radius, height - radius, radius, CGFloat(0.5 * M_PI), CGFloat(M_PI), 0);
            
            // 绘制第4条线和第4个1/4圆弧
            CGContextAddLineToPoint(context, 0, radius);
            CGContextAddArc(context, radius, radius, radius, CGFloat(M_PI), CGFloat(1.5 * M_PI), 0);
            
            // 闭合路径
            CGContextClosePath(context);
            // 填充半透明黑色
            CGContextSetLineWidth(context, borderWidth)
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor)
            CGContextSetFillColorWithColor(context, backgroundColor.CGColor)
            CGContextDrawPath(context, .Fill)
            
            let output = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return output
    }
}