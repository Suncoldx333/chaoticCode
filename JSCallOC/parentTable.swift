//
//  parentTable.swift
//  JSCallOC
//
//  Created by 11111 on 2017/5/9.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

class parentTable: UITableView {

    override init(frame: CGRect, style: UITableViewStyle){
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var numberOfSections: Int{
        return 3
    }
    
    override func numberOfRows(inSection section: Int) -> Int {
        return 2
    }

    
    
}

class tesWebImageView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var helloImage : UIImageView!
    
    
    func initUI() {
        self.backgroundColor = UIColor.white
        
        helloImage = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        helloImage.center = self.center
        self.addSubview(helloImage)
        
        helloImage.setImageWith(imageUrl: URL.init(string: "http://gxapp-images.oss-cn-hangzhou.aliyuncs.com/news-images/20170510/5387f9a7c2af45eda6a70ceea78d8bac.jpg"), placeholderImage: #imageLiteral(resourceName: "Image"))
        
        let bt : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        bt.backgroundColor = UIColor.black
        self.addSubview(bt)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(btTap))
        bt.addGestureRecognizer(tap)
        
    }
    
    func btTap() {
//        helloImage.testCancel()
    }
}
