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

let ScreenWidth : CGFloat = UIScreen .main .bounds .size .width
let ScreenHeight : CGFloat = UIScreen .main .bounds .size .height
let ScreenHeightUnit :CGFloat = UIScreen .main .bounds .size .height * 1.000 / 667.000
let ScreenWidthUnit :CGFloat = UIScreen .main .bounds .size .width * 1.000 / 375.000

typealias swiftNoPatameterBlock = () -> Void

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

struct allKeys {
    static let cellHeightCacheKey = UnsafeRawPointer.init(bitPattern: "cellHeightCache".hashValue)
    static let userDefaultTestKey = "userDefaultTest"

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
            objc_setAssociatedObject(self, allKeys.cellHeightCacheKey, heightCache, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, allKeys.cellHeightCacheKey) as? cellHeightCache
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

//extension UIViewController{
//    open override static func initialize() {
//        struct Static{
//            static var token = NSUUID().uuidString
//        }
//        
//        if self != UIViewController.self {
//            return
//        }
//        
//        DispatchQueue.once(token : Static.token){
//            let oriSelector = #selector(UIViewController.viewWillAppear(_:))
//            let swiSelector = #selector(UIViewController.xl_viewWillAppewar(_:))
//            
//            let oriMethod = class_getInstanceMethod(self, oriSelector)
//            let swiMethod = class_getInstanceMethod(self, swiSelector)
//            
//            let didAddMethod : Bool = class_addMethod(self,
//                                                      oriSelector,
//                                                      method_getImplementation(swiMethod),
//                                                      method_getTypeEncoding(swiMethod))
//            
//            if didAddMethod {
//                class_replaceMethod(self,
//                                    swiSelector,
//                                    method_getImplementation(oriMethod),
//                                    method_getTypeEncoding(oriMethod))
//            }else{
//                method_exchangeImplementations(oriMethod,
//                                               swiMethod)
//            }
//            
//        }
//    }
//    
//    func xl_viewWillAppewar(_ animated : Bool) {
//        self.xl_viewWillAppewar(animated)
//        print("swizzle will appear")
//    }
//}

extension NSObject{
    
    /// 互斥锁方法,swift内没有类似@Synchronized的直接调用的方法
    /// 由于是对NSObject的扩展，使用时可能要注意命名重复
    ///
    /// - Parameters:
    ///   - lock: 互斥锁的对象
    ///   - f: 需要执行的方法
    func customSynchronized(_ lock : Any,f:() ->()) {
        objc_sync_enter(lock)
        f()
        objc_sync_exit(lock)
    }
    
}

extension DispatchQueue{
    private static var onceTracker = [String]()
    
    open class func once(token : String,block:() -> Void){
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if onceTracker.contains(token) {
            return
        }
        onceTracker.append(token)
        block()
    }
}

class globalDefine: NSObject {
    
    func increeh(myin : Int) {
        
    }
    
}

//extension UserDefaults{
//    func saveNonPropertyModel(_ model : Any, _ key : String) -> Data {
//        
//        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
//        let path : String! = paths.first?.appending(key)
//        
//        let fileManage = FileManager.init()
//        if !fileManage.fileExists(atPath: path) {
//            do{
//                try fileManage.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
//            }catch{
//                print("oppos!")
//            }
//        }
//    }
//}

class cellHeightCache: NSObject {
    
}
