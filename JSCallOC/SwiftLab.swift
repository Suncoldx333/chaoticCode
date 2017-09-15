//
//  SwiftLab.swift
//  JSCallOC
//
//  Created by 11111 on 2017/9/13.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit
import Messages

import RxSwift
import RxCocoa

class SwiftLab: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        self.view.backgroundColor = ColorMethodho(hexValue: 0xffffff)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(changeModel))
        self.view.addGestureRecognizer(tap)
        
        self.view.addSubview(textLabel)
    }
    
    var outterName : Variable<String>!
    var model : infoModel!
    var dis : Disposable?
    let disbage = DisposeBag.init()
    var tapCount : NSInteger! = 0
    
    lazy var textLabel: UILabel = {
        let inner = UILabel.init(frame: CGRect.init(x: 0, y: 100, width: ScreenWidth, height: 50))
        return inner
    }()
    func initData() {
        
        let draw : ImageDrawing = ImageSVG()
        draw.addEllipse(rect: CGRect.zero, fill: ColorMethodho(hexValue: 0xffffff))
        draw.showExtension()
        
        outterName = Variable.init("lilei")
        model = infoModel.init(name: Variable("yo"))
        
        dis = outterName.asObservable()
            .debug()
            .map {
            $0 + "after"
        }.bind(to: model.name)
    }
    
    func changeModel() {
        tapCount = tapCount + 1
        outterName.value = "hanmeimei" + "~~" + String.init(format: "%d", tapCount)

        print("model = \(model.name.value)")
        
        if tapCount > 10 {
            dis?.dispose()
        }
        
    }

}

//MARK: - 
struct infoModel{
    var name : Variable<String>!
    
}

//MARK: - 
protocol ImageDrawing {
    func addEllipse(rect : CGRect,fill : UIColor)
}

extension ImageDrawing{
    func showExtension() {
        print("hello Drawing")
    }
}

//MARK: -
extension CGContext : ImageDrawing{
    func addEllipse(rect: CGRect, fill: UIColor) {
        setFillColor(fill.cgColor)
        fillEllipse(in: rect)
    }
}

struct ImageSVG {
    func showExtension() {
        print("hello SVG")
    }
}

extension ImageSVG : ImageDrawing{
    func addEllipse(rect: CGRect, fill: UIColor) {
        print("hello SVG")
    }
}



//MARK: - 
class IntIterator{
    var nextImpl : () -> Int?
    
    init<I : IteratorProtocol>(_ iterator : I) where I.Element == Int {
        var iteratorCopy = iterator
        self.nextImpl = {
            iteratorCopy.next()
        }
        
    }
}

//MARK: - 
enum FileError : Error{
    case fileDoesNotExit
    case noPermission
}

enum Result<A>{
    case failure(Error)
    case success(A)
}
