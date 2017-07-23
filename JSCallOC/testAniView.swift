//
//  testAniView.swift
//  JSCallOC
//
//  Created by WangZhaoyun on 2017/6/15.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

class testAniView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var btView: UIView = {
        let inner : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        inner.backgroundColor = hexColor(colorCode: 0x333333).withAlphaComponent(0.8)
        inner.layer.cornerRadius = 50
        return inner
    }()
    
    lazy var customAnimation: CABasicAnimation = {
        let inner : CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        inner.duration = 3
        inner.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        inner.fillMode = kCAFillModeForwards
        inner.isRemovedOnCompletion = false
        inner.fromValue = NSNumber.init(value: 0)
        inner.toValue = NSNumber.init(value: 1)
        return inner
    }()
    
    lazy var aniLayer: CAShapeLayer = {
        let inner : CAShapeLayer = CAShapeLayer.init()
        let path : UIBezierPath = UIBezierPath.init()
        path.move(to: CGPoint.init(x: 50, y: 2.5))
        path.addArc(withCenter: CGPoint.init(x: 50, y: 50), radius: 47.5, startAngle: -0.5 * CGFloat.pi, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        inner.path = path.cgPath
        inner.fillColor = UIColor.clear.cgColor
        inner.strokeColor = hexColor(colorCode: 0xff4438).cgColor
        inner.lineWidth = 5

        return inner
    }()
    var aniTimer : Timer?
    var durationTime : Double! = 0.000
    var firstTap : Bool! = true
    
    func initUI() {
        self.backgroundColor = hexColor(colorCode: 0xffffff)
        
        let cata = CataTestView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        cata.sign = "asdadada"
        
        print("sign = \(cata.sign),make = \(cata.makeSign())")
        
        self.addSubview(btView)
        btView.center = CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2)
        
//        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(sender:)))
//        btView.addGestureRecognizer(tap)
        
        let longPress : UILongPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(longEvent(sender:)))
        longPress.minimumPressDuration = 0
        btView.addGestureRecognizer(longPress)

    }
    
//    func tapEvent(sender : UITapGestureRecognizer) {
//        aniBegin()
//        btView.layer.addSublayer(aniLayer)
//        aniLayer.add(customAnimation, forKey: "strokeEndAnimation")
//    }
    
    func longEvent(sender : UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            aniBegin()
            
            break
            
        case .ended:
            print("ani done")
            aniCancel()
            break
            
        default:
            break
        }
    }
    
    func aniBegin() {
        
        if firstTap {
            firstTap = false
            btView.layer.addSublayer(aniLayer)
        }
        aniLayer.removeAnimation(forKey: "strokeEndAnimation")
        
        let process : Float = Float.init(durationTime! / 3.000)
        print("curTime = \(durationTime),process = \(process)")
        
        let inner : CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        inner.duration = CFTimeInterval(3 * (1 - process))
        inner.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        inner.fillMode = kCAFillModeForwards
        inner.isRemovedOnCompletion = false
        inner.fromValue = NSNumber.init(value: process)
        inner.toValue = NSNumber.init(value: 1)
        aniLayer.add(inner, forKey: "strokeEndAnimation")
        
        if aniTimer != nil {
            aniTimer?.invalidate()
            aniTimer = nil
        }
        aniTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timeCount), userInfo: nil, repeats: true)
    }
    
    func timeCount() {
        durationTime = durationTime! + 0.001
        if durationTime! > 3.000 {
            aniTimer?.invalidate()
            aniTimer = nil
            durationTime = 3.000
        }
    }
    
    func aniCancel() {
        if durationTime! < 3.000 && durationTime! > 0.000 {
            aniTimer?.invalidate()
            aniTimer = nil
            aniLayer.removeAnimation(forKey: "strokeEndAnimation")
            
            let process : Float = Float.init(durationTime! / 3.000)
            let inner : CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
            inner.duration = CFTimeInterval(3 * process)
            inner.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
            inner.fillMode = kCAFillModeForwards
            inner.isRemovedOnCompletion = false
            inner.fromValue = NSNumber.init(value: process)
            inner.toValue = NSNumber.init(value: 0)
            
            aniReturn()
            aniLayer.add(inner, forKey: "strokeEndAnimation")
        }
    }
    
    func aniReturn() {
        if aniTimer != nil {
            aniTimer?.invalidate()
            aniTimer = nil
        }
        aniTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timeReturn), userInfo: nil, repeats: true)
    }
    
    func timeReturn() {
        if durationTime! > 0 {
            durationTime = durationTime! - 0.001
        }else{
            aniTimer?.invalidate()
            aniTimer = nil
            durationTime = 0
        }
        print("duration = \(durationTime ?? 0.000)")
    }

}
