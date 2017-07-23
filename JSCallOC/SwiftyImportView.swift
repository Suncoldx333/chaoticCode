//
//  SwiftyImportView.swift
//  JSCallOC
//
//  Created by 11111 on 2017/7/22.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

class SwiftyImportView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var showEmojiTapBlock : swiftNoPatameterBlock!
    var keyBoardAppearCount : NSInteger = 0
    
    
    lazy var importTextView: UITextView = {
        let inner = UITextView.init(frame: CGRect.init(x: 10, y: 5, width: ScreenWidth - 10 - 110, height: 40));
        inner.delegate = self
        inner.layer.borderColor = ColorMethodho(hexValue: 0xb2b2b2).cgColor
        inner.layer.borderWidth = 1
        inner.backgroundColor = ColorMethodho(hexValue: 0xffffff)
        return inner
    }()
    
    lazy var emojiIcon: UIImageView = {
        let inner = UIImageView.init(frame: CGRect.init(x: ScreenWidth - 40, y: 5, width: 40, height: 40))
        inner.backgroundColor = ColorMethodho(hexValue: 0xb2b2b2)
        return inner
    }()
    
    fileprivate func initUI() {
        self.backgroundColor = ColorMethodho(hexValue: 0xd9d9d9)
        
        self.addSubview(importTextView)
        self.addSubview(emojiIcon)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent))
        emojiIcon.addGestureRecognizer(tap)
    }
    
    func tapEvent() {
        
        if importTextView.isFirstResponder {
            importTextView.resignFirstResponder()
        }else{
            importTextView.becomeFirstResponder()
        }
        
    }
    
}

extension SwiftyImportView : UITextViewDelegate{
    
}
