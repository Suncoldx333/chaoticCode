//
//  BaseRTPathView.swift
//  JSCallOC
//
//  Created by 11111 on 2017/6/12.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

typealias swiftNoPatameterBlock = () -> Void

class BaseRTPathView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var switchToDataBlock : swiftNoPatameterBlock!
    
    lazy var viewSwitchIcon: UIImageView = {
        let innerImageView : UIImageView = UIImageView.init(frame: CGRect.init(x: ViewWidh(v: self) - 15 - 40, y: ViewHeight(v: self) - 25 - 100.5 - 10 - 40, width: 40, height: 40))
        innerImageView.layer.cornerRadius = 20
        innerImageView.backgroundColor = ColorMethodho(hexValue: 0x333333).withAlphaComponent(0.8)
        innerImageView.image = #imageLiteral(resourceName: "switchToRunning")
        innerImageView.isUserInteractionEnabled = true
        innerImageView.contentMode = UIViewContentMode.center
        let switchTap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(runningSwitchEvent))
        innerImageView.addGestureRecognizer(switchTap)
        return innerImageView
    }()
    
    func initUI() {
        self.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "countDownBg"))
        
        self.addSubview(viewSwitchIcon)
    }
    
    func runningSwitchEvent() {
        self.switchToDataBlock()
    }
}
