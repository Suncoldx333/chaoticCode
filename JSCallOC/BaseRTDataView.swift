//
//  BaseRTDataView.swift
//  JSCallOC
//
//  Created by 11111 on 2017/6/12.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

class BaseRTDataView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var switchToPathBlock : swiftNoPatameterBlock!
    lazy var mapSwitchIcon: UIImageView = {
        let innerImageView = UIImageView.init(frame: CGRect.init(x: ViewWidh(v: self) - 20 - 40, y: 40, width: 40, height: 40))
        innerImageView.image = #imageLiteral(resourceName: "switchToData")
        innerImageView.isUserInteractionEnabled = true
        
        let switchTap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(mapSwitchEvent))
        innerImageView.addGestureRecognizer(switchTap)
        return innerImageView
    }()
    func initUI() {
        self.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "countDownBg"))
        self.addSubview(mapSwitchIcon)
        
        //        let switchTap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(mapSwitchEvent))
        //        self.addGestureRecognizer(switchTap)
    }
    
    func mapSwitchEvent() {
        self.switchToPathBlock()
    }
    
}
