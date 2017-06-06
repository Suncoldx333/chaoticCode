
//
//  PhotoTool.swift
//  JSCallOC
//
//  Created by 11111 on 2017/6/6.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit
import Photos

typealias PhotoToolQueryResultBlock = (Array<PhotoAlbumModel>?) ->Void
typealias PHAssetChangeResultBlock = (Data) ->Void

struct PhotoToolKeyInUse {
    static var assetInSpecifiedAlubum : String = "assetInSpecifiedAlubum"
    static var photoAlbumListKey : String = "photoAlbumListKey"
}

class PhotoTool: NSObject {
    static let shareInstance = PhotoTool()
    var assetCache : autoPurgeAssetArrCache!
    
    override init() {
        assetCache = autoPurgeAssetArrCache.init()
        assetCache.name = "helloAsset"
        
    }
    
    func getPhotoAlbumList(completion : @escaping PhotoToolQueryResultBlock) {
        var photoAlbumList : Array<PhotoAlbumModel> = [PhotoAlbumModel]()
        
        printWithTime(content: "now begin" as AnyObject)
        
        //结果
        let resultOperation : Operation = BlockOperation.init {
            self.printWithTime(content: "now complete" as AnyObject)
            
            completion(photoAlbumList)
        }
        
        let photoAlbumListInCache : Array<PhotoAlbumModel>? = assetCache.object(forKey: PhotoToolKeyInUse.photoAlbumListKey as AnyObject) as? Array<PhotoAlbumModel>
        if photoAlbumListInCache != nil {
            
            photoAlbumList = photoAlbumListInCache!
            OperationQueue.main.addOperation(resultOperation)
            
        }else{
//            let createBySystemOperation : Operation = getAlbumModelIn(createrType: AlbumCreaterType.System) { (modelArr) in
//                let _ = modelArr?.map({ (model) -> Void in
//                    photoAlbumList.append(model)
//                })
//            }
//            let createByUserOperation : Operation = getAlbumModelIn(createrType: AlbumCreaterType.User) { (modelArr) in
//                let _ = modelArr?.map({ (model) -> Void in
//                    photoAlbumList.append(model)
//                })
//            }
//            createByUserOperation.addDependency(createBySystemOperation)
            //查询
            let queryOperation : BlockOperation = BlockOperation.init {
                
                self.getAlbumModelIn(createrType: AlbumCreaterType.System, completion: { (modelArr) in
                    let _ = modelArr?.map({ (model) -> Void in
                        photoAlbumList.append(model)
                    })
                })
            }
            
            queryOperation.addExecutionBlock {
                self.getAlbumModelIn(createrType: AlbumCreaterType.User, completion: { (modelArr) in
                    let _ = modelArr?.map({ (model) -> Void in
                        photoAlbumList.append(model)
                    })
                })
            }
            
            //缓存
            let cacheOperation : Operation = BlockOperation.init(block: {
                self.assetCache.setObject(photoAlbumList as AnyObject, forKey: PhotoToolKeyInUse.photoAlbumListKey as AnyObject)
            })
            
            cacheOperation.addDependency(queryOperation)
            resultOperation.addDependency(cacheOperation)
            
            OperationQueue.main.addOperations([queryOperation,cacheOperation,resultOperation], waitUntilFinished: false)
        }
        
    }
    
    private func getAlbumModelIn(createrType : AlbumCreaterType,completion : PhotoToolQueryResultBlock) {
        
        var albumResult : PHFetchResult<PHAssetCollection>!
        
        switch createrType {
        case AlbumCreaterType.System:
            albumResult = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.albumRegular, options: nil)
            break
            
        case AlbumCreaterType.User:
            albumResult = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.smartAlbumUserLibrary, options: nil)
            break
            
        default:
            assert(1 == 2, "error creater type")
        }
        
        var queryArr : Array<PhotoAlbumModel> = [PhotoAlbumModel]()
        albumResult.enumerateObjects({ (collection, idx, stop) in
            
            print("subtype = \(collection.assetCollectionSubtype.rawValue),name = \(collection.localizedTitle ?? "defaultName")")
            if collection.assetCollectionSubtype.rawValue != 202 && collection.assetCollectionSubtype.rawValue < 212 {
                
                let model : PhotoAlbumModel? = self.createAlbumModel(usePHCollection: collection)
                if model != nil {
                    queryArr.append(model!)
                }
            }
            
        })
        
        completion(queryArr)
        
    }
    
    private func createAlbumModel(usePHCollection collection : PHAssetCollection) -> PhotoAlbumModel? {
        let assets : Array<PHAsset> = getAllAssetIn(specifiedAlbum: collection, byAscending: false)
        
        if assets.count > 0 {
            var infoDic : Dictionary<String,AnyObject> = [String:AnyObject]()
            infoDic.updateValue(collection.localizedTitle as AnyObject, forKey: "ablumName")
            infoDic.updateValue(NSNumber.init(value: assets.count).stringValue as AnyObject, forKey: "count")
            infoDic.updateValue(assets.first!, forKey: "headImageAsset")
            infoDic.updateValue(collection, forKey: "assetCollection")
            
            let album : PhotoAlbumModel = PhotoAlbumModel.init(infoDic: infoDic)
            return album
        }
        
        return nil
    }
    
    func getAllAssetIn(specifiedAlbum : PHAssetCollection ,byAscending ascending : Bool) -> Array<PHAsset> {
        var assetArr : Array<PHAsset> = [PHAsset]()
        
        let assetArrInCache : Array<PHAsset>? = assetCache.object(forKey: specifiedAlbum.localizedTitle as AnyObject) as? Array<PHAsset>
        if assetArrInCache != nil {
            print("hit cache")
            assetArr = assetArrInCache!
            return assetArr
        }
        
        let option : PHFetchOptions = PHFetchOptions.init()
        option.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: ascending)]
        
        let result : PHFetchResult = PHAsset.fetchAssets(in: specifiedAlbum, options: option)
        print("result count = \(result.count)")
        result.enumerateObjects({ (asset, idx, stop) in
            if asset.mediaType == PHAssetMediaType.image {
                assetArr.append(asset)
            }
        })
        assetCache.setObject(assetArr as AnyObject, forKey: specifiedAlbum.localizedTitle as AnyObject)
        
        return assetArr
    }
    
    func createImageBy(asset : PHAsset,and completion : PHAssetChangeResultBlock!) {
        
        let option : PHImageRequestOptions = PHImageRequestOptions.init()
        option.resizeMode = PHImageRequestOptionsResizeMode.fast
        option.isSynchronous = true
        
        PHCachingImageManager.default().requestImageData(for: asset, options: option) { (data, dataUTI, orientation, info) in
            completion(data!)
        }
    }
}

extension PhotoTool{
    enum AlbumCreaterType : NSInteger {
        case System = 1, //系统创建
        User,            //用户创建
        ErrorCode        //错误
    }
}

/// 接到内存警告会清除所有缓存的一个缓存类
class autoPurgeAssetArrCache : NSCache<AnyObject, AnyObject> {
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(removeAllObjects), name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
}
