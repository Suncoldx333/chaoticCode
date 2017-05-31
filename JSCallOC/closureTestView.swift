//
//  closureTestView.swift
//  JSCallOC
//
//  Created by 11111 on 2017/4/26.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

public class closureTestView: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
        initUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let testLabel : UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 200, width: 100, height: 100))
        return label
        
    }()
    
    
    func initUI() {
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
//        let showLabel = UILabel.init(frame: CGRect.init(x: 0, y: 200, width: 100, height: 100))
//        showLabel.textColor = UIColor.white
//        showLabel.text = "lala"
//        self.addSubview(showLabel)
        
        testLabel.textColor = UIColor.white
        testLabel.text = "lala"
        self.addSubview(testLabel)
        
        let teSub = closureTestSubView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        teSub.teSubClosure = {
            (teX) in
            self.testLabel.text = "show" + NSNumber.init(value: teX).stringValue
            teSub.teClosureInFunc(countShow: self.testLabel.text!, closureInFunc: { (teStr) -> String in
                let changedStr = "---" + teStr + "---"
                return changedStr
            })
        }
        self.addSubview(teSub)
    }
}

class closureTestSubView: UIView {
    override init(frame: CGRect){
        super.init(frame: frame)
        initUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    typealias subViewClosure = (Double) -> Void
    typealias subViewClosureWithRe = (String) -> String
    var teSubClosure : subViewClosure!
    var countDouble : Double!
    
    func initUI() {
        countDouble = 0
        self.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        
        let subTapEvent = UITapGestureRecognizer.init(target: self, action: #selector(subViewTap))
        self.addGestureRecognizer(subTapEvent)
        
    }
    
    func subViewTap() {
        countDouble = countDouble + 1
        self.teSubClosure(countDouble)
    }
    
    func teClosureInFunc(countShow : String, closureInFunc : subViewClosureWithRe) {
        print(countShow)
        let mayStr = closureInFunc(countShow)
        print(mayStr)
    }
}
