//
//  testAniView.swift
//  JSCallOC
//
//  Created by WangZhaoyun on 2017/6/15.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

struct PrefixIterator : IteratorProtocol {
    let string : String
    var offset : String.Index
    
    init(string : String) {
        self.string = string
        offset = string.startIndex
    }
    
    mutating func next() -> String? {
        guard offset < string.endIndex else {
            return nil
        }
        offset = string.index(after: offset)
        return string[string.startIndex..<offset]
    }
}

struct PrefixSequence : Sequence {
    let string : String
    
    func makeIterator() -> PrefixIterator {
        return PrefixIterator.init(string: string)
    }
}

protocol Queue {
    associatedtype Element
    mutating func enqueue(_ newElement : Element)
    mutating func dequeue() -> Element?
}

class testAniView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initData()
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
    
    var shape1 : CAShapeLayer!
    var shape2 : CAShapeLayer!
    var shape3 : CAShapeLayer!
    
    var teView : UIView!
    
//    func log<View : UIView>(_ view : UIView) {
//        print("\(type(of: view))")
//    }
    
    func log(_ view : UILabel) {
        print("\(type(of: view)),text = \(view.text ?? "1")")
    }
    
    func sum(_ n : UInt64) -> UInt64 {
//
        func innerSum(_ innerN : UInt64,current : UInt64) -> UInt64{
            if innerN == 0 {
                return current
            }else{
                return innerSum(innerN - 1, current: current + innerN)
            }
        }
        return innerSum(n, current: 0)

//        if n == 0 {
//            return 0
//        }
//        return n + sum(n - 1)
    }
    
    func arrMap() {
        
        let arr = ["1","2","3","4"]
        let ocArr = NSMutableArray.init()
        let _ = arr.map { (num) in
            ocArr.add(num)
        }
        
        let newArr = ocArr.map { (num) in
            num as! String + "new"
        }
        
    }
    
    func titititi<T>(_ a : T) {
        print("title = \(a)")
    }
    
    func initData() {
        
        let _ = PrefixSequence.init(string: "Hello").map { (prefix) in
            print(prefix)
        }
    }
    
    func initUI() {
        self.backgroundColor = hexColor(colorCode: 0xffffff)
        
        let cata = CataTestView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        cata.sign = "asdadada"
        
        print("sign = \(cata.sign),make = \(cata.makeSign())")
        let state = (0,1)
        let new = (state.1,state.0 + state.1)
        
        
        let teDic = NSMutableDictionary.init()
//        teDic.setObject("qwee", forKey: "type" as NSCopying)
        print("count = \(teDic.count)")
        if let innerType = teDic.object(forKey: "type") as? String {
            print("exit = \(innerType)")
        }else{
            print("none")
        }

        
        var array = ["one","teo"]
        let idx = array.index(of: "one")
        array.remove(at: idx!)
        
        let weight = "60"
        let weightHa = weight.hashValue
        let length = "9.91"
        let intlength = NSNumber.init(value: Float.init(length)!).intValue
        let shortLeng : String = NSNumber.init(value: intlength).stringValue
        
        let calorieDou : Float = Float.init(weight)! * Float.init(shortLeng)! * 1.036
        
//        let calorieDou : Float = Float.init(weight)! * Float.init(length)! * 1.036
        
        let calorieStr : String = String.init(format: "%d", NSNumber.init(value: calorieDou).intValue)
//        let calorieStr : String = String.init(format: "%.f", Float.init(weight)! * Float.init(length)! * 1.036)
        
        testContinue()
        
        let cirPath : UIBezierPath = UIBezierPath.init(ovalIn: CGRect.init(x: 50, y: 50, width: 200, height: 200))
        
        let circle : CAShapeLayer = CAShapeLayer.init()
        circle.path = cirPath.cgPath
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = hexColor(colorCode: 0x4990e2).cgColor
        circle.lineWidth = 10
        
//        self.layer.addSublayer(circle)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapEvent(sender:)))
        self.addGestureRecognizer(tap)
        
        self.addSubview(btView)
        btView.center = CGPoint.init(x: self.frame.width / 2, y: self.frame.height / 2)
        
        let longPress : UILongPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(longEvent(sender:)))
        longPress.minimumPressDuration = 0
        btView.addGestureRecognizer(longPress)

    }
    
    func testFlat() {
        let suits = ["1","2","3","4"]
        let ranks = ["a","b","c","d"]
        
        
        let result = suits.flatMap { (suit) in
            ranks.map({ (rank) in
                (suit,rank)
            })
        }
        
        print("result = \(result)")
        
    }
    
    func testContinue() {
        let weight = "60"
        let length = "0.47"
        
        let calorieStr : String = String.init(format: "%.f", Float.init(weight)! * Float.init(length)! * 1.036)
        print("weight = \(String(describing: weight)),length = \(String(describing: length)),calo = \(calorieStr)")
        
        teView = UIView.init(frame: CGRect.init(x: 150, y: 150, width: 90, height: 90))
        teView.layer.cornerRadius = 45
        teView.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        self.addSubview(teView)
        
        let path1 = UIBezierPath.init(ovalIn: teView.bounds)
        shape1 = CAShapeLayer.init()
        shape1.path = path1.cgPath
        shape1.fillColor = hexColor(colorCode: 0x4990e2).withAlphaComponent(0.95).cgColor
        shape1.strokeColor = UIColor.clear.cgColor
        shape1.lineWidth = 0
        shape1.bounds = CGRect.init(x: 0, y: 0, width: 90, height: 90)
        teView.layer.addSublayer(shape1)
        
        
        let path2 = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: 81, height: 81))
        shape2 = CAShapeLayer.init()
        shape2.path = path2.cgPath
        shape2.strokeColor = hexColor(colorCode: 0x333333).withAlphaComponent(0.95).cgColor
        shape2.fillColor = UIColor.clear.cgColor
        shape2.lineWidth = 2
        shape2.bounds = CGRect.init(x: 0, y: 0, width: 81, height: 81)
        teView.layer.addSublayer(shape2)
        
        let helloLabel : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 31, height: 16))
        helloLabel.text = "继续"
        helloLabel.font = UIFont.systemFont(ofSize: 15)
        helloLabel.backgroundColor = hexColor(colorCode: 0x333333)
        helloLabel.textColor = hexColor(colorCode: 0xffffff)
        teView.addSubview(helloLabel)
        helloLabel.center = CGPoint.init(x: 0, y: 0)
        
    }
    
    func tapEvent(sender : UITapGestureRecognizer) {
        
//        var trans3d = CATransform3D.init()
//        trans3d = CATransform3DIdentity
        
        biggerAni()
        smallerAni()
    }
    
    func smallerAni() {
        let ani : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        ani.fromValue = NSNumber.init(value: 1.0)
        ani.toValue = NSNumber.init(value: 0.95)
        ani.autoreverses = false
        ani.duration = 0.2
        ani.fillMode = kCAFillModeForwards
        ani.isRemovedOnCompletion = false
        ani.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        
        let ani2 : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        ani2.fromValue = NSNumber.init(value: 0.95)
        ani2.toValue = NSNumber.init(value: 1.0)
        ani2.autoreverses = false
        ani2.beginTime = 0.2
        ani2.duration = 0.1
        ani2.fillMode = kCAFillModeForwards
        ani2.isRemovedOnCompletion = false
        ani2.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        
        let group : CAAnimationGroup = CAAnimationGroup.init()
        group.animations = [ani,ani2]
        group.duration = 0.3
        group.autoreverses = false
        group.fillMode = kCAFillModeForwards
        group.isRemovedOnCompletion = false
        
        shape2.add(group, forKey: nil)
    }
    
    func biggerAni() {
        let ani : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        ani.fromValue = NSNumber.init(value: 1.0)
        ani.toValue = NSNumber.init(value: 1.1)
        ani.autoreverses = false
        ani.duration = 0.2
        ani.fillMode = kCAFillModeForwards
        ani.isRemovedOnCompletion = false
        ani.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseIn)
        
        let ani2 : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        ani2.fromValue = NSNumber.init(value: 1.1)
        ani2.toValue = NSNumber.init(value: 1.0)
        ani2.autoreverses = false
        ani2.beginTime = 0.2
        ani2.duration = 0.1
        ani2.fillMode = kCAFillModeForwards
        ani2.isRemovedOnCompletion = false
        ani2.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        
        let group : CAAnimationGroup = CAAnimationGroup.init()
        group.animations = [ani,ani2]
        group.duration = 0.3
        group.autoreverses = false
        group.fillMode = kCAFillModeForwards
        group.isRemovedOnCompletion = false
        
        shape1.add(group, forKey: nil)
    }
    
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
