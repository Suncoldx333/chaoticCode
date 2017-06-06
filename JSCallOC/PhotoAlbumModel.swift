//
//  PhotoAlbumModel.swift
//  JSCallOC
//
//  Created by 11111 on 2017/6/6.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit
import Photos

class PhotoAlbumModel: NSObject {
    
    var PAMAlbumName : String!
    var PAMCount : String!
    var PAMHeadImage : PHAsset!
    var PAMAssetCollection : PHAssetCollection!
    
    init(infoDic : Dictionary<String,AnyObject>) {
        
        super.init()
        
        PAMAlbumName = infoDic["ablumName"] as! String
        PAMCount = infoDic["count"] as! String
        PAMHeadImage = infoDic["headImageAsset"] as! PHAsset
        PAMAssetCollection = infoDic["assetCollection"] as! PHAssetCollection
        
    }
}
