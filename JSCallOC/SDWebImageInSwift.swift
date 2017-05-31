//
//  SDWebImageInSwift.swift
//  JSCallOC
//
//  sdWebImage的简化版
//
//  Created by wangzhaoyun on 2017/5/22.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

typealias webImageCompletionWithFinishedBlock = (UIImage?,Error?,Bool?) ->Void
typealias webImageQueryCompletionBlock = (UIImage?) ->Void
typealias webImageCallBackBlock = () ->Void

struct webImageKey {
    static var imageUrlKey : String = "imageUrlKey"
    
}

extension UIImageView{
    
    /// 给UIImageView设置图片
    ///
    /// - Parameters:
    ///   - imageUrl: 网络图片URL
    ///   - placeholderImage: 本地置位图片
    func setImageWith(imageUrl : URL!,placeholderImage : UIImage?) {
        self.cancelImageLoadOperationWith(key: "UIImageViewImageLoad")
        
        objc_setAssociatedObject(self, &webImageKey.imageUrlKey, imageUrl, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        if placeholderImage != nil {
            //GCD用法在Swift中略有变化
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.image = placeholderImage
                }
            }
        }
        
        SDWebImageInSwift.shareInstance.downloadImageWith(url: imageUrl) { [unowned self](downLoadImage, error, finished) in
            
            if downLoadImage != nil {
                self.image = downLoadImage
//                self.setNeedsLayout()

            }
            
        }
        
        self.setImageLoad(operation: "1", key: "UIImageViewImageLoad")
    }
    
    
    /// 取消之前的图片下载线程
    ///
    /// - Parameter key: 下载线程关键词
    private func cancelImageLoadOperationWith(key : String) {
        
    }
    
    
    /// 存储下载线程
    ///
    /// - Parameters:
    ///   - operation: 下载线程
    ///   - key: 关键词
    private func setImageLoad(operation : Any,key : String) {
        
    }
}


/// 图片管理类
class SDWebImageInSwift: NSObject {
    static let shareInstance = SDWebImageInSwift()
    private override init() {
        
    }
    
    var failedURLs : Set = Set<URL>.init()  //下载失败的URL集合
    var runningoperatins : Array = Array<Any>.init()  //正在执行的线程的集合
    var imageCache : imageCacheInSwift = imageCacheInSwift.shareInstance  //图片缓存对象
    var imageLoder : imageLoadInSwift = imageLoadInSwift.shareInstance  //图片下载对象
    
    func downloadImageWith(url : URL,complete : webImageCompletionWithFinishedBlock) {
        //源码处有对url类型的判断，此处由于之前写成了URL!,因此不再额外做判断
        
        var operation : webImageCombineOperation = webImageCombineOperation.init()
        
        //1.该URL是否是之前下载失败的，源码OC版本可以使用@synchronized来实现互斥以保证线程安全，Swift则需要自己定义互斥方法
        var isFailedUrl : Bool = false
        customSynchronized(lock: failedURLs as AnyObject) {
            isFailedUrl = failedURLs.contains(url)
        }
        
        //2.url无效或者之前下载失败过的
        if url.absoluteString.characters.count == 0 || isFailedUrl {
            
        }
        
        //3.存放线程
        customSynchronized(lock: runningoperatins as AnyObject) { 
            runningoperatins.append(operation)
        }
        
        //4.
        let key : String = url.absoluteString
        operation.cacheOperation = imageCache.queryDiskCacheFor(key: key, done: { [unowned self](cachedImage) in
            self.imageLoder.downLoadImageWith(url: url, complete: { (image, error, finished) in
                
            })
        })
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

struct webImageCombineOperation {
    
    var cacheOperation : Operation!
    
    
}


/// 图片缓存类
class imageCacheInSwift : NSObject{
    static let shareInstance = imageCacheInSwift()
    
    var memCache : autoPurgeCache!
    
    private override init() {
        memCache = autoPurgeCache.init()
        memCache.name = "helloWebImage"
    }
    
    func queryDiskCacheFor(key : String?,done : webImageQueryCompletionBlock) -> Operation? {
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
        
        let operation : Operation = BlockOperation.init()
        
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

    func downLoadImageWith(url : URL,complete : webImageCompletionWithFinishedBlock) -> webImageDownLoaderOperation {
        var operation : webImageDownLoaderOperation!
        
        addProgressCallBack(complete: complete, url: url) { 
            [unowned self]() in
            var request : URLRequest = URLRequest.init(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 15.0)
            request.httpShouldUsePipelining = true
            request.allHTTPHeaderFields = self.header
            
            operation = webImageDownLoaderOperation.init(request: request, completed: { (downloadImage, error, finished) in
                
            })
            self.operationQueue.addOperation(operation)
            
        }
        
        return operation
    }
    
    func addProgressCallBack(complete : webImageCompletionWithFinishedBlock,url : URL,callBack : webImageCallBackBlock) {
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
