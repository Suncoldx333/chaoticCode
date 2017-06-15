//
//  globalDefine.swift
//  JSCallOC
//
//  Created by 11111 on 2017/4/26.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

typealias cellConfigurationBlock = (UITableViewCell) ->Void
typealias testBlock = (Double) ->(String)

//颜色，Eg:ColorMethodho(0x00c18b)
func ColorMethodho(hexValue : Int) -> UIColor {
    let red   = ((hexValue & 0xFF0000) >> 16)
    let green = ((hexValue & 0xFF00) >> 8)
    let blue  = (hexValue & 0xFF)
    
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(1))
}

//获取View的frame相关信息
func ViewX(v : UIView) -> CGFloat{
    let x : CGFloat = v.frame.origin.x
    return x
}

func ViewY(v : UIView) -> CGFloat{
    let y : CGFloat = v.frame.origin.y
    return y
}

func ViewWidh(v : UIView) -> CGFloat{
    let width : CGFloat = v.frame.size.width
    return width
}

func ViewHeight(v : UIView) -> CGFloat{
    let height : CGFloat = v.frame.size.height
    return height
}

struct cellHeightKey {
    static let cellHeightCacheKey = UnsafeRawPointer.init(bitPattern: "cellHeightCache".hashValue)

}

let objcKey : String = "preLayout"

let bbblocktest : testBlock = {
    (a) in
    
    let changedStr : String = "10Str" + NSNumber.init(value: a).stringValue

    return changedStr
}


extension UITableView{
    
    var heightCache : cellHeightCache? {
        set{
            objc_setAssociatedObject(self, cellHeightKey.cellHeightCacheKey, heightCache, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, cellHeightKey.cellHeightCacheKey) as? cellHeightCache
        }
    }
    
    
    func cellHeightCacheWith(identifier : String?,cacheKey : String?,configuration : cellConfigurationBlock) -> CGFloat {
        
        var height : CGFloat = 0
        
        if identifier == nil || cacheKey == nil {
            return height
        }
        
        height = cellHeightWith(identifier: identifier, configuration: configuration)
        
        return height
    }
    
    private func cellHeightWith(identifier : String?,configuration : cellConfigurationBlock) -> CGFloat {
        var height : CGFloat = 0
        
        if identifier == nil {
            return height
        }
        
        let preLayoutCell : UITableViewCell = cellForReuse(identifier: identifier)
        preLayoutCell.prepareForReuse()
        configuration(preLayoutCell)
        
        height = fittingHeightFor(cell: preLayoutCell)
        return height
    }
    
    private func cellForReuse(identifier : String?) -> UITableViewCell{
        var preLayoutCellByIdentifiers : [String : UITableViewCell]? = objc_getAssociatedObject(self, objcKey) as? [String : UITableViewCell]
        if preLayoutCellByIdentifiers == nil {
            preLayoutCellByIdentifiers = [:]
            objc_setAssociatedObject(self, objcKey, preLayoutCellByIdentifiers, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        var preLayoutCell : UITableViewCell? = preLayoutCellByIdentifiers?[identifier!]
        if preLayoutCell == nil {
            preLayoutCell = self.dequeueReusableCell(withIdentifier: identifier!)
            preLayoutCell?.contentView.translatesAutoresizingMaskIntoConstraints = false
            preLayoutCellByIdentifiers?.updateValue(preLayoutCell!, forKey: identifier!)
        }
        
        return preLayoutCell!
    }
    
    private func fittingHeightFor(cell : UITableViewCell) -> CGFloat {
        var height : CGFloat = 0
        
        height = cell.contentView.frame.size.height
        
        return height
    }
}

extension Double{
    
    struct testKeyGroup {
        static let testKey = UnsafeRawPointer.init(bitPattern: "testKey".hashValue)
        
    }
    
    var maySssss : Double? {
        set(haha){
            objc_setAssociatedObject(self, "doubleKey", haha!, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            return objc_getAssociatedObject(self, "doubleKey") as? Double
        }
    }
    
    var dasf : String? {
        
        return self.mayI()
    }
    
    
    func halo() -> String {
        var papaStr = "papa" + NSNumber.init(value: self).stringValue
        papaStr = mayI()
        return papaStr
    }
    
    private func mayI() -> String{
        return "joker"
    }
}

class globalDefine: NSObject {
    
    func increeh(myin : Int) {
        
    }
    
}

class cellHeightCache: NSObject {
    
}
