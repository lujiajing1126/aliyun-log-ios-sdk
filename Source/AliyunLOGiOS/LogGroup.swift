//
//  LOGLogGroup.swift
//  AliyunLOGiOS
//
//  Created by 王佳玮 on 16/7/30.
//  Copyright © 2016年 wangjwchn. All rights reserved.
//

import Foundation


open class LogGroup:NSObject{
    fileprivate var mTopic:String = ""
    fileprivate var mSource:String = ""
    fileprivate var mContent = [[String:AnyObject]]()
    public init(topic:String,source:String){
        mTopic = topic
        mSource = source
    }

    open func PutTopic(_ topic:String){
        mTopic = topic
    }
    open func PutSource(_ source:String){
        mSource = source
    }
    open func PutLog(_ log:Log){
        mContent.append(log.GetContent())
    }
    
    open func GetJsonPackage() -> String{
        do {
            var package:[String:AnyObject] = [:]
            package["__topic__"] = mTopic as AnyObject?
            package["__source__"] = mSource as AnyObject?
            package["__logs__"] = mContent as AnyObject?
            let JsonPackage = String(data:try JSONSerialization.data(withJSONObject: package, options:JSONSerialization.WritingOptions.prettyPrinted), encoding: String.Encoding.utf8)!
            return JsonPackage
            
        }catch _ as NSError {
            fatalError("Fail to serialize data.")
        }
        return ""
    }
    
}
