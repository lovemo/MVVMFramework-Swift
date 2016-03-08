//
//  SEKView+Frame.swift
//  SwiftExtensionKitDemo
//
//  Created by yuantao on 16/3/3.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

public extension UIView{
    public var x : CGFloat {
        set(value){
            var frame = self.frame
            frame.origin.x = value
            self.frame = frame
        }
        get{
            return self.frame.origin.x
        }
    }
    
    public var right : CGFloat{
        set(value){
            var frame = self.frame
            frame.origin.x = value - frame.size.width
            self.frame = frame
        }
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    public var y :CGFloat{
        set(value){
            var frame = self.frame
            frame.origin.y = value
            self.frame = frame
        }
        get{
            return self.frame.origin.y
        }
    }
    
    public var bottom : CGFloat{
        set(value){
            var frame = self.frame
            frame.origin.y = value - frame.size.height
            self.frame = frame
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    public var centerX : CGFloat{
        set(value){
            self.center = CGPointMake(value, self.center.y)
        }
        get{
            return self.center.x
        }
    }
    
    public var centerY : CGFloat{
        set(value){
            self.center = CGPointMake(self.center.x, value)
        }
        get{
            return self.center.y
        }
    }
    
    public var width : CGFloat{
        set(value){
            var frame = self.frame
            frame.size.width = value
            self.frame = frame
        }
        get{
            return self.frame.size.width
        }
    }
    
    public var height : CGFloat{
        set(value){
            var frame = self.frame
            frame.size.height = value
            self.frame = frame
        }
        get{
            return self.frame.size.height
        }
    }
    
    public var size : CGSize {
        set(value){
            var frame = self.frame
            frame.size = value
            self.frame = frame
        }
        get{
            return self.frame.size
        }
    }
    
    public var origin : CGPoint {
        set(value){
            var frame = self.frame
            frame.origin = value
            self.frame = frame
        }
        get{
            return self.frame.origin
        }
    }
}
