//
//  ImagePickWidgetSwift.swift
//  JSCallOC
//
//  Created by 11111 on 2017/6/6.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

public func hexColor(colorCode : Int) -> UIColor {
    let red   = ((colorCode & 0xFF0000) >> 16)
    let green = ((colorCode & 0xFF00) >> 8)
    let blue  = (colorCode & 0xFF)
    
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(1))
}

extension NSObject{
    
    func printWithTime(_ content : Any) {
        
        let nowDate = Date.init()
        let timeFor = DateFormatter.init()
        timeFor.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let nowDateInStr : String = timeFor.string(from: nowDate)
        
        print("\(nowDateInStr) \(content)")
    }
}

class ImagePickWidgetSwift: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    lazy var showView : ImagePickView = {
        let teView : ImagePickView = ImagePickView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64))
        return teView
    }()
    
    func initData() {
        let tool : PhotoTool = PhotoTool.shareInstance
        let teStr = #keyPath(showView.frame)
        print(teStr)
        
        tool.getPhotoAlbumList { [unowned self](ModelArray) in
            print("modelArrCount = \(ModelArray?.count ?? -1)")
            
            let _ = ModelArray?.map({ (model) -> Void in
                print("modelName = \(model.PAMAlbumName),modelCount = \(model.PAMCount)")
                
            })
            let firstAlbumModel : PhotoAlbumModel = (ModelArray?.first)!
            
            self.showView.albumAssets = tool.getAllAssetIn(specifiedAlbum: firstAlbumModel.PAMAssetCollection, byAscending: false)
            
        }
    }
    
    func initUI()  {
        self.view.backgroundColor = hexColor(colorCode: 0xffffff)
        self.navigationItem.title = "inWidget"
        self.view.addSubview(showView)
        
    }

}
