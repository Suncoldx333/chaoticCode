//
//  SwiftyDiffVC.swift
//  JSCallOC
//
//  Emoji表情在Swift中的异常,以及其他验证想法的代码
//
//  Created by 11111 on 2017/8/6.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

class SwiftyDiffVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addEmojiToLabel()
    }
    
    var testDid : String!{
        didSet{
            print("old = \(oldValue),new = \(testDid)")
        }
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
    
    var structModel : modelStruct!
    var classModel : modelClass!
    
    //MARK: -
    fileprivate func initData() {
//        testDid = "shit"
        _ = #imageLiteral(resourceName: "switchToRunning")
        
        let suits = ["1","2","3","4"]
        let ranks = ["a","b","c","d"]
        
        let combine = [suits,ranks]
        
        let result = combine.flatMap {
            $0.map({
                $0 + "yooo"
            })
        }
        print("result = \(result)")
        
        let users = [["name" : "jack","age" : "10"],["name" : "lilei","age" : "19"],["name" : "lili","age" : "89"]]
        let _ = users.flatMap {
            $0.flatMap({
                print("\($0)")
            })
        }
        
        let testDic = ["name" : "jack","age" : "10"]
        let result1 = testDic.flatMap {
            $0.key + $0.value
        }
        print("result = \(result1)")

        let sample = SVG.init()
        sample.addCircle()
        
        let another : Drawing = SVG.init()
        another.addCircle()
        
        let assSample = AssSVG.init()
        print("next = \(assSample.next() ?? 0)")
        
        print("f = \(f_show(5)),g = \(g_show(5))")
        
        stringCompare()
        addressCompare()
        
        let escap = escapingTest.init()
        let escap2 = escapingTest.init()
        
        escap.method1()
        escap.method2()
        escap.method3()
        
        print("+ result = \(escap + escap2)")
    }
    
    
    
    fileprivate func initUI() {
        self.view.backgroundColor = ColorMethodho(hexValue: 0xe6e6e6)
        self.view.addSubview(testCopyBtView)
        self.view.addSubview(emojiLabel)
        self.view.addSubview(emojiAttrLable)
        
        structModel = modelStruct.init(name: "路飞")
        classModel = modelClass.init()
        classModel.name = "乔司"
        
        
    }
    
    //MARK: -
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
        
        testDid = "hello"
        
        let structModel1 = structModel
        structModel.name = "路飞1"
        print("ori = \(structModel.name),another = \(structModel1?.name ?? "ori")")
        
        let classModel1 = classModel
        classModel.name = "乔司1"
        print("ori = \(classModel.name),another = \(classModel1?.name ?? "ori")")
        
        let airports : [String : String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        for (code ,name) in airports {
            print("\(code) : \(name)")
        }
        
    }
}

struct UserInfo {
    var name : String!
    var age : String!
    
}

extension SwiftyDiffVC{
    
    func stringCompare() {
        
        let single = "Pok\u{00E9}mon"
        let double = "Pok\u{0065}\u{0301}mon"
        
        print("\((single,double))")
        print("singleCount = \(single.utf16.count),doubleCount = \(double.utf16.count)")
    }
    
    func f_show<L : CustomStringConvertible>(_ x : L) -> Int {
        return MemoryLayout.size(ofValue: x)
    }
    
    func g_show(_ x : CustomStringConvertible) -> Int {
        return MemoryLayout.size(ofValue: x)
    }
    
    func addressCompare() {
        
        var first = addressTest.init()
        withUnsafePointer(to: &first) {
            print("address = \($0)")
        }
        
        first.hello = "first"
        withUnsafePointer(to: &first) {
            print("address = \($0)")
        }
        
        first.hello = "second"
        withUnsafePointer(to: &first) {
            print("address = \($0)")
        }
        
        var second = first
        withUnsafePointer(to: &second) {
            print("address = \($0)")
        }
        
        var firstArr = NSArray.init()
        withUnsafePointer(to: &firstArr) {
            print("arr address = \($0)")
        }
        
        var secondArr = firstArr
        withUnsafePointer(to: &secondArr) {
            print("arr address = \($0)")
        }
    }
    
    func addArr( arr : inout Array<String>) {
        arr.append("2")
    }
    
}

struct modelStruct {
    var name : String!
    
}

class modelClass: NSObject {
    var name : String!
    
}

//MARK: - 
struct addressTest{
    var hello : String!
    
}

//MARK: -
protocol associatedPro {
    associatedtype care = NSInteger
    func next() -> Self.care?
}

struct AssSVG {
    
}

extension AssSVG : associatedPro{
    func next() -> Int? {
        return 1
    }
}

//MARK: -
protocol Drawing {
    func addEllipse(rect : CGRect,fill : UIColor)
    func addRectangle(rect : CGRect,fill : UIColor)
}

extension Drawing{
    func addCircle() {
        print("addCircle")
    }
}

struct SVG {
    
}

extension SVG{
    func addCircle() {
        print("svg addCircle")
    }
}

extension SVG : Drawing{
    func addEllipse(rect: CGRect, fill: UIColor) {
        print("addEllipse")
    }
    
    func addRectangle(rect: CGRect, fill: UIColor) {
        print("addRectangle")
    }
}

//MARK: -
class escapingTest {
    var foo = "foo"
    
    static func +(lhs : escapingTest,rhs : escapingTest) -> String {
        return lhs.foo + rhs.foo
    }
    
    func method1() {
        doWork {
            print(foo)
        }
        foo = "bar"
    }
    
    func method2() {
        doWorkAsync {
            print(self.foo)
        }
        foo = "bar"
    }
    
    func method3() {
        doWorkAsync {
            [weak self] _ in
            print(self?.foo ?? "now nil")
        }
        foo = "bar"
    }
    
    fileprivate func doWork(block : () -> ()){
        block()
    }
    
    fileprivate func doWorkAsync(block : @escaping () -> ()){
        DispatchQueue.main.async {
            block()
        }
    }
}

