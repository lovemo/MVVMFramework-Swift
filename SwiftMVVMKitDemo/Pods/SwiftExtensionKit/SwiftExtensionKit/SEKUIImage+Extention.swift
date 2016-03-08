//
//  SEKUIImage+Extention.swift
//  SwiftExtensionKitDemo
//
//  Created by yuantao on 16/3/3.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit
import CoreImage
import Foundation

extension UIImage {
    
    /**
    圆角图片
    
    - parameter radius: 圆角半径尺寸
    - parameter size:   圆角范围的尺寸
    
    - returns: 
    */
    public  func roundCornerImage(radius radius: CGFloat, _ size: CGSize) -> UIImage {
        
        let rect = CGRect(origin: CGPointZero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners,
            cornerRadii: CGSize(width: radius, height: radius))
        path.addClip()
        self.drawInRect(rect)
        let output = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return output
    }
    
    /**
     图片不让系统渲染
     
     - parameter image: image图片
     
     - returns: 不被系统渲染的图片
     */
    public class func imageOrginal(var image: UIImage) -> UIImage {
    
        //    返回不被系统渲染的图片
        image = image.imageWithRenderingMode(.AlwaysOriginal)
        return image
    }
    
    /**
     裁剪带边框的圆形图片（当图片不是方正的，裁剪出来是椭圆，所以要求显示的imageView是方正的）
     
     - parameter image:       图片
     - parameter borderWidth: 边框尺寸
     - parameter borderColor: 边框颜色
     
     - returns: 裁剪好得图片
     */
    public class func circleImage(image: UIImage, borderWidth: CGFloat, borderColor: UIColor) -> UIImage
    {
    
        let max = CGSizeMake(image.size.width + borderWidth * 2, image.size.height + borderWidth * 2)
        //   创建bitmap图形上下文,相当于空白的画布，NO表示透明，1表示可以缩放
        UIGraphicsBeginImageContextWithOptions(max, false, 0)
        
        //    获取上下文
        let ctx = UIGraphicsGetCurrentContext()
        //    绘图大圆
        CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, max.width, max.height))
        borderColor.set()
        //    渲染
        CGContextFillPath(ctx)
        
        //    绘制小圆
        CGContextAddEllipseInRect(ctx, CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height))
        //    裁剪,仅对之后再画上去的有作用
        CGContextClip(ctx)
        
        //    画图片
        image.drawAtPoint(CGPointMake(borderWidth, borderWidth))
        
        //    取出图片
        let newIcon = UIGraphicsGetImageFromCurrentImageContext()
        //    结束上下文
        UIGraphicsEndImageContext()
        return newIcon
    }
    
    /**
     最大化裁剪成圆图,(当图片不是方正的，裁剪出来是椭圆，所以要求显示的imageView是方正的）
     - parameter image:       图片
     - returns: 裁剪后的图片
     */
    public class func circleImage(image: UIImage) -> UIImage {
    
        //    创建图形上下文
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
        //    获取上下文
        let ctx = UIGraphicsGetCurrentContext()
        //    画圆
        CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, image.size.width, image.size.height))
        //    裁剪
        CGContextClip(ctx)
        //   画图片
        image.drawAtPoint(CGPointZero)
        //    取出新图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //    结束上下文
        UIGraphicsEndImageContext()
        
        return newImage
    
    }
    
     /**
     水印logo,logo默认距离右上角10px
     
     - parameter image:    图片
     - parameter logoName: logo图片名
     - parameter logoSize: 将来logo的尺寸
     
     - returns: 水印后的图片
     */
    public class func image(image: UIImage, logoName:String, logoSize: CGSize) -> UIImage {
    
        //    创建图形上下文，透明，不缩放
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
        //    画图
        image.drawAtPoint(CGPointZero)
        //    设置logo的frame
        let margin: CGFloat = 10.0
        let logoX = image.size.width - logoSize.width - margin
        let logoY = margin
        
        //    获取logo图片
        let logo = UIImage(named: logoName)
        //    画logo
        logo?.drawInRect(CGRectMake(logoX, logoY, logoSize.width, logoSize.height))
        //    取出图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //    结束上下文
        UIGraphicsEndImageContext();
        
        return newImage
    }

     /**
     水印标题，标题默认位置，距离左上角10px
     
     - parameter image:          图片
     - parameter description:    标题文字
     - parameter textColor:      文字颜色
     - parameter backGroudColor: 文字背景色
     - parameter fontSize:       文字大小
     
     - returns: 水印标题后的图片
     */
    public class func image(image:UIImage, description:NSString, textColor:UIColor, backGroudColor:UIColor, fontSize:CGFloat) -> UIImage {
        
        //  获取上下文
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0);
        //    画图
        image.drawAtPoint(CGPointZero)
        //    画文字
        let margin:CGFloat = 10.0
            
        let dic = [NSFontAttributeName: UIFont.systemFontOfSize(fontSize),
                            NSForegroundColorAttributeName:textColor,
                            NSBackgroundColorAttributeName:backGroudColor]
        description.drawAtPoint(CGPointMake(margin, margin), withAttributes: dic)
        //    取出图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //    结束上下文
        UIGraphicsEndImageContext()
        
        return newImage
    
    }
    
     /**
     截屏
     
     - parameter view: 屏幕
     
     - returns: 截取的图片
     */
    public class func subImage(view: UIView) -> UIImage {
    
        //    创建图形上下文
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0);
        //    获取图形上下文
        let ctx = UIGraphicsGetCurrentContext();
        //    将layer画到画板上
        view.layer.renderInContext(ctx!)
        
        //    取出图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //    结束图形上下文
        UIGraphicsEndImageContext()
        return image
    
    }
    
     /**
     不变形拉伸图片
     
     - parameter image: 图片
     
     - returns: 拉伸后的图片
     */
    public class func resizebleImage(image: UIImage) -> UIImage {
    
        //    该方法会自动将下边与右边减一像素，拉伸时用这一像素去填充，保证图片不变形
        return image.stretchableImageWithLeftCapWidth(Int(image.size.width*0.5), topCapHeight: Int(image.size.height*0.5))
    }

}