//
//  SwiftyDiffVC.swift
//  JSCallOC
//
//  Emoji表情在Swift中的异常
//
//  Created by 11111 on 2017/8/6.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

class SwiftyDiffVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addEmojiToLabel()
    }
    
    lazy var emojiLabel: UILabel = {
        let inner = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 45))
        inner.font = UIFont.systemFont(ofSize: 15)
        inner.backgroundColor = ColorMethodho(hexValue: 0xffffff)
        return inner
    }()
    
    lazy var emojiAttrLable: UILabel = {
        let inner = UILabel.init(frame: CGRect.init(x: 0, y: 100, width: ScreenWidth, height: 45))
        inner.numberOfLines = 0
        inner.backgroundColor = ColorMethodho(hexValue: 0xffffff)
        return inner
    }()
    
    lazy var testCopyBtView: UIView = {
        let inner = UIView.init(frame: CGRect.init(x: 0, y: 200, width: 100, height: 100))
        inner.backgroundColor = ColorMethodho(hexValue: 0x00c18b).withAlphaComponent(0.2)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(copyOnWriteEvent))
        inner.addGestureRecognizer(tap)
        return inner
    }()
    
    fileprivate func initUI() {
        self.view.backgroundColor = ColorMethodho(hexValue: 0xe6e6e6)
        self.view.addSubview(testCopyBtView)
        self.view.addSubview(emojiLabel)
        self.view.addSubview(emojiAttrLable)
    }
    
    fileprivate func addEmojiToLabel() {
        
        let emojis = GlobalTool.createEmojis()
        let fetch = emojis?[0..<7]
        var emojiStr = ""
        
        let _ = fetch?.map({ (emoji) in
            emojiStr = emojiStr + emoji
        })
        emojiLabel.text = "normal : " + emojiStr
        emojiAttrLable.text = "attr : " + emojiStr
    }
    
    func createAttr(_ emojis : String) -> NSMutableAttributedString{
        let title = emojis
        let attr = NSMutableAttributedString.init(string: title)
        
        attr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 15)], range: NSRange.init(location: 0, length: title.characters.count))

        attr.addAttributes([NSForegroundColorAttributeName : ColorMethodho(hexValue: 0xffffff)], range: NSRange.init(location: 0, length: title.characters.count))
        let para = NSMutableParagraphStyle.init()
        para.paragraphSpacing = 4
        let paraDic = [NSParagraphStyleAttributeName : para];
        attr.addAttributes(paraDic, range: NSRange.init(location: 0, length: title.characters.count))
        
        return attr
    }
    
    func copyOnWriteEvent() {
        
        let d = "lllop"
        var a = [1,2,3]
        var b = a
        let c = b
        
        print("d = \(d)")
    }
}


