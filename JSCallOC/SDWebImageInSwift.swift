//
//  SDWebImageInSwift.swift
//  JSCallOC
//
//  SDWebImage的简化版
//
//  Created by wangzhaoyun on 2017/5/22.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

typealias webImageCompletionWithFinishedBlock = (UIImage?,Error?,Bool?) ->Void
typealias webImageQueryCompletionBlock = (UIImage?) ->Void
typealias webImageNoParamsBlock = () ->Void

struct webImageKey {
    static var imageUrlKey : String = "imageUrlKey"
    static var loadOperationKey : String = "loadOperationKey"

}

extension UIImageView{
    
    var operationDic : Dictionary<String,Array<webImageGainOperation>>! {
        get{
            var opDic : Dictionary<String,Array<webImageGainOperation>>? = objc_getAssociatedObject(self, &webImageKey.loadOperationKey) as? Dictionary<String,Array<webImageGainOperation>>
            if opDic == nil {
                opDic = [String : Array<webImageGainOperation>]()
                objc_setAssociatedObject(self, &webImageKey.loadOperationKey, opDic, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return opDic
            }
            return opDic!
        }
        set(dic){
            objc_setAssociatedObject(self, &webImageKey.loadOperationKey, dic, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    /// 给UIImageView设置图片
    ///
    /// - Parameters:
    ///   - imageUrl: 网络图片URL
    ///   - placeholderImage: 本地置位图片
    func setImageWith(imageUrl : URL!,placeholderImage : UIImage?) {
        self.cancelImageGainOperationWith(key: "UIImageViewImageLoad")
        
        objc_setAssociatedObject(self, &webImageKey.imageUrlKey, imageUrl, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        if placeholderImage != nil {
            //GCD用法在Swift中略有变化，Operation更便于使用
            //1.GCD方式
//            DispatchQueue.global().async {
//                DispatchQueue.main.async {
//                    self.image = placeholderImage
//                }
//            }
            //2.Operation方式
            OperationQueue.main.addOperation({
                () in
                self.image = placeholderImage
            })
        }
        
        let operation : webImageGainOperation = SDWebImageInSwift.shareInstance.gainImageWith(url: imageUrl) { [unowned self](downLoadImage, error, finished) in
            
            OperationQueue.main.addOperation({ 
                () in
                self.image = downLoadImage
            })
        }
        
        self.setGainImage(operation: operation, key: "UIImageViewImageLoad")
    }
    
    
    /// 取消之前的图片下载任务
    ///
    /// - Parameter key: 下载任务关键词
    private func cancelImageGainOperationWith(key : String) {
        var operationDicInner : Dictionary<String,Array<webImageGainOperation>> = self.operationDic
        let operationArr = operationDicInner[key]
        if operationArr != nil {
            
//            for gainOperation : webImageGainOperation in operationArr! {
//                gainOperation.cancel()
//            }
            
            let hahArr : Array<webImageGainOperation?> = [webImageGainOperation?]()
            
//            _ = operationArr?.map({ (Operation) -> Void in
//                Operation.cancel()
//            })
            operationDicInner.removeValue(forKey: key)
            
        }
    }
    
    
    /// 存储下载任务
    ///
    /// - Parameters:
    ///   - operation: 下载线程
    ///   - key: 关键词
    private func setGainImage(operation : webImageGainOperation,key : String) {
        //源码此处存在一个cancel操作，简化版没有这个需求就去掉了
        
        var operationDicInner : Dictionary<String,Array<webImageGainOperation>> = self.operationDic
        var operationArr = operationDicInner[key]
        if operationArr == nil {
            operationArr = [webImageGainOperation]()
        }
        operationArr?.append(operation)
    }
}


/// 图片管理类
class SDWebImageInSwift: NSObject {
    static let shareInstance = SDWebImageInSwift()
    private override init() {
        
    }
    
    var failedURLs : Set = Set<URL>.init()  //下载失败的URL集合
    var runningoperatins : Array = Array<Any>.init()  //正在执行的任务的集合
    var imageCache : imageCacheInSwift = imageCacheInSwift.shareInstance  //图片缓存对象
    var imageLoder : imageLoadInSwift = imageLoadInSwift.shareInstance  //图片下载对象
    
    func gainImageWith(url : URL,complete : @escaping webImageCompletionWithFinishedBlock) -> webImageGainOperation {
        //源码处有对url类型的判断，此处由于之前写成了URL!,因此不再额外做判断
        
        var operation : webImageGainOperation = webImageGainOperation.init()
        
        //1.该URL是否是之前下载失败的，源码OC版本可以使用@synchronized来实现互斥以保证线程安全，Swift则需要自己定义互斥方法
        var isFailedUrl : Bool = false
        customSynchronized(lock: failedURLs as AnyObject) {
            isFailedUrl = failedURLs.contains(url)
        }
        
        //2.url无效或者之前下载失败过的
        if url.absoluteString.characters.count == 0 || isFailedUrl {
            
        }
        
        //3.存放正在/即将执行的任务
        customSynchronized(lock: runningoperatins as AnyObject) { 
            runningoperatins.append(operation)
        }
        
        //4.
        let key : String = url.absoluteString
        operation = imageCache.queryDiskCacheFor(key: key, done: { [unowned self](cachedImage) in
            
            if cachedImage != nil {
                complete(cachedImage,nil,true)
            }
            
            
            
//            self.imageLoder.downLoadImageWith(url: url, complete: { (image, error, finished) in
//                complete(image,error,finished)
//            })
        })!
        
        return operation
    }
    
    
    /// 互斥锁方法
    ///
    /// - Parameters:
    ///   - lock: 互斥锁的对象
    ///   - f: 需要执行的方法
    private func customSynchronized(lock : AnyObject,f:() ->()) {
        objc_sync_enter(lock)
        f()
        objc_sync_exit(lock)
    }
}


/// 图片缓存类
class imageCacheInSwift : NSObject{
    static let shareInstance = imageCacheInSwift()
    
    var memCache : autoPurgeCache!
    
    private override init() {
        memCache = autoPurgeCache.init()
        memCache.name = "helloWebImage"
    }
    
    func queryDiskCacheFor(key : String?,done : webImageQueryCompletionBlock) -> webImageGainOperation? {
        if key == nil {
            done(nil)
            return nil
        }
        
        //查找存放在cache中的图片
        let cachedImage : UIImage? = memCache.object(forKey: key as AnyObject) as? UIImage
        if cachedImage != nil {
            done(cachedImage)
            return nil
        }
        
        let operation : webImageGainOperation = webImageGainOperation.init()
        
        //查找存放在sandbox中的图片
        let diskImage : UIImage? = diskImageFor(key: key!)
        if diskImage != nil {
            let cost : CGFloat = (diskImage?.size.width)! * (diskImage?.size.height)! * (diskImage?.scale)! * (diskImage?.scale)!
            memCache.setObject(diskImage!, forKey: key as AnyObject, cost: Int.init(cost))
        }
        done(diskImage)
        
        return operation
    }
    
    func diskImageFor(key : String) -> UIImage? {
        return nil
    }
    
}


/// 图片下载类
class imageLoadInSwift: NSObject {
    static let shareInstance = imageLoadInSwift()
    private override init() {
        
    }
    
    let header = ["Accept" : "image/*;q=0.8"];
    let operationQueue : OperationQueue = OperationQueue.init()

    func downLoadImageWith(url : URL,complete : @escaping webImageCompletionWithFinishedBlock) -> webImageDownLoaderOperation {
        var operation : webImageDownLoaderOperation!
        
        addProgressCallBack(complete: complete, url: url) { 
            [unowned self]() in
            var request : URLRequest = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 15.0)
            request.httpShouldUsePipelining = true
            request.allHTTPHeaderFields = self.header
            
            operation = webImageDownLoaderOperation.init(request: request, completed: { (downloadImage, error, finished) in
                complete(downloadImage,error,finished)
            })
            self.operationQueue.addOperation(operation)
            
        }
        
        return operation
    }
    
    func addProgressCallBack(complete : webImageCompletionWithFinishedBlock,url : URL,callBack : webImageNoParamsBlock) {
        callBack()
    }
}

class webImageDownLoaderOperation: Operation {
    
    var requestCopyed : URLRequest!
    var completeBlock : webImageCompletionWithFinishedBlock!
    var session : URLSession!
    
    init(request : URLRequest,
         completed : @escaping webImageCompletionWithFinishedBlock) {
        
        self.requestCopyed = request
        self.completeBlock = completed
    }
    
    override func start() {
        customSynchronized(lock: self) { 
            () in
            
//            let configuration : URLSessionConfiguration = URLSessionConfiguration.default
            self.session = URLSession.shared
            let dataTask : URLSessionDataTask = self.session.dataTask(with: self.requestCopyed.url!, completionHandler: { (data, response, error) in
                
                let newImage : UIImage = UIImage.init(data: data!)!
                
                let newRes : HTTPURLResponse = response as! HTTPURLResponse
                print(newRes.statusCode)
                
                self.completeBlock(newImage,error,true)
            })
            dataTask.resume()
            
        }
    }
    
    
    
    /// 互斥锁方法
    ///
    /// - Parameters:
    ///   - lock: 互斥锁的对象
    ///   - f: 需要执行的方法
    private func customSynchronized(lock : AnyObject,f:() ->()) {
        objc_sync_enter(lock)
        f()
        objc_sync_exit(lock)
    }
}

extension webImageDownLoaderOperation : URLSessionDataDelegate{
    
}

/// 接到内存警告会清除所有缓存的一个缓存类
class autoPurgeCache : NSCache<AnyObject, AnyObject> {
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(removeAllObjects), name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
}

/// 图片获取任务
/// 设计出来是用以实现取消获取任务，从而取消图片下载的任务
/// 图片下载的任务存在于图片获取任务内
struct webImageGainOperation {
    var isCancelled : Bool = false
    var cancelBlock : webImageNoParamsBlock?
    var cacheOperation : Operation?
    
    mutating func cancel() {
        self.isCancelled = true
        
        if self.cacheOperation != nil {
            self.cacheOperation?.cancel()
            self.cacheOperation = nil
        }
        
        if self.cancelBlock != nil {
            self.cancelBlock!()
            self.cancelBlock = nil
        }
        
        
    }
}
