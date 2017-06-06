//
//  ImagePickView.swift
//  JSCallOC
//
//  Created by 11111 on 2017/6/6.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit
import Photos

class ImagePickView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var chosenImageBGView: UIView = {
        
        let bgView : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth))
        bgView.clipsToBounds = true
        bgView.backgroundColor = hexColor(colorCode: 0xfcfcfc)
        return bgView
    }()
    
    lazy var chosenImage: UIImageView = {
        
        let chosen : UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth))
        chosen.contentMode = UIViewContentMode.scaleAspectFill
        chosen.clipsToBounds = true
        chosen.isUserInteractionEnabled = true
        
        return chosen
    }()
    
    let tool = PhotoTool.shareInstance
    
    private var albumAssetsInner : Array<PHAsset>!
    var albumAssets : Array<PHAsset>{
        set(assets){
            modifyUI(assets: assets)
        }
        get{
            return albumAssetsInner
        }
    }
    
    
    func initUI() {

        self.backgroundColor = hexColor(colorCode: 0xe6e6e6)
        self.addSubview(chosenImageBGView)
        chosenImageBGView.addSubview(chosenImage)
    }
    
    func modifyUI(assets : Array<PHAsset>) {
        albumAssetsInner = assets
        
        let firstAsset : PHAsset = albumAssetsInner.first!
        
        let teOpeQueue : OperationQueue = OperationQueue.init()
        
        
        let changeOperation : Operation = BlockOperation.init {
            [unowned self]() in
            self.tool.createImageBy(asset: firstAsset, and: { (data) in
                
                OperationQueue.main.addOperation({ 
                    self.chosenImage.image = UIImage.init(data: data)
                })
            })
        }

        teOpeQueue.addOperation(changeOperation)

    }

}

extension ImagePickView{
    
}
