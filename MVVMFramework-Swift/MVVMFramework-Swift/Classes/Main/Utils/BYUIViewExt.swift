//
//  UIViewUtils.swift
//  brandyond
//
//  Created by ysq on 14/12/4.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

import UIKit

//thank demon1105 oc code support < Github : https://github.com/demon1105/UIView-Utils >

public extension UIView{
    public var vleft : CGFloat {
        set(value){
            var frame = self.frame
            frame.origin.x = value
            self.frame = frame
        }
        get{
            return self.frame.origin.x
        }
    }
    
    public var vright : CGFloat{
        set(value){
            var frame = self.frame
            frame.origin.x = value - frame.size.width
            self.frame = frame
        }
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
    public var vtop :CGFloat{
        set(value){
            var frame = self.frame
            frame.origin.y = value
            self.frame = frame
        }
        get{
            return self.frame.origin.y
        }
    }

    public var vbottom : CGFloat{
        set(value){
            var frame = self.frame
            frame.origin.y = value - frame.size.height
            self.frame = frame
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    public var vcenterX : CGFloat{
        set(value){
            self.center = CGPointMake(value, self.center.y)
        }
        get{
            return self.center.x
        }
    }
    
    public var vcenterY : CGFloat{
        set(value){
            self.center = CGPointMake(self.center.x, value)
        }
        get{
            return self.center.y
        }
    }
    
    public var vwidth : CGFloat{
        set(value){
            var frame = self.frame
            frame.size.width = value
            self.frame = frame
        }
        get{
            return self.frame.size.width
        }
    }
    
    public var vheight : CGFloat{
        set(value){
            var frame = self.frame
            frame.size.height = value
            self.frame = frame
        }
        get{
            return self.frame.size.height
        }
    }
    
    public var vsize : CGSize {
        set(value){
            var frame = self.frame
            frame.size = value
            self.frame = frame
        }
        get{
            return self.frame.size
        }
    }
    
    public func removeAllSubviews(){
        while(self.subviews.count > 0){
            let child: AnyObject? = self.subviews.last
            child?.removeFromSuperview()
        }
    }
    
}