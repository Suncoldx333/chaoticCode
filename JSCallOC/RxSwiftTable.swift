//
//  RxSwiftTable.swift
//  JSCallOC
//
//  Created by 11111 on 2017/8/15.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

struct User {
    var name : String
    var speech : String
}

struct UserSectionModel {
    var items : [Item]
    
}

extension UserSectionModel : SectionModelType{
    typealias Item = User
    
    init(original: UserSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

class RxSwiftTable: UIViewController {
    
    let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight / 2), style: .grouped)
    let willLabel = UILabel.init(frame: CGRect.init(x: 0, y: ScreenHeight / 2, width: 100, height: 100))
    let cancelBt = UIButton.init(frame: CGRect.init(x: ScreenWidth - 100, y: ScreenHeight / 2, width: 100, height: 100))
    
    let Data = RxTableViewSectionedReloadDataSource<UserSectionModel>.init()
    var sections : [UserSectionModel]!
    var dataSource : Variable<[UserSectionModel]>!
    
    var obSecrions : Variable<Any>!
    let disposeBag = DisposeBag()
    var willChangeStr : String!
    var obWill : Variable<String>!
    var subsciption : Disposable?
    
    var willArr : [copyTest]!
    var anotherWillArr : [copyTest]!
    
    var sWillArr : [copyStruct]!
    var sAnotherWillArr : [copyStruct]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initData()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.value = sections
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() {
        willArr = [copyTest]()
        let copyOne = copyTest.init()
        copyOne.willVar = "hello"
        willArr.append(copyOne)
        anotherWillArr = willArr
        
        sWillArr = [copyStruct]()
        let sCopyOne = copyStruct.init(structWillVar: "sHello")
        sWillArr.append(sCopyOne)
        sAnotherWillArr = sWillArr
        
        sections = [
            UserSectionModel.init(items: [
                User.init(name: "钱钟书", speech: "围城"),
                User.init(name: "老舍", speech: "茶馆")
                ]),
            UserSectionModel.init(items: [
                User.init(name: "余华", speech: "许三观卖血记"),
                User.init(name: "王小波", speech: "沉默的大多数")
                ])
        ]
        
        
        willChangeStr = "1"
        
        obWill = Variable.init(willChangeStr)
        
//        subsciption = obWill.asObservable().subscribe(onNext: { [weak self](str) in
//            self?.willLabel.text = str
//        }, onError: { (error) in
//            
//        }, onCompleted: { 
//            
//        }, onDisposed: { 
//            
//        })
        
        obWill.asDriver().debug()
            .map { (str) in
            str + "done"
        }.drive(willLabel.rx.text)
        .addDisposableTo(disposeBag)
        
//        obWill.asObservable()
//            .distinctUntilChanged({ (old, new) -> Bool in
//            print("old = \(old),new = \(new)")
//            return Int.init(old)! > Int.init(new)!
//        })
//            .bind(to: willLabel.rx.text)
//            .addDisposableTo(disposeBag)
        
    }
    
    func initUI() {
        
        self.view.backgroundColor = ColorMethodho(hexValue: 0xe6e6e6)
        
        self.view.addSubview(tableView)
        configureTableView()
        
        self.view.addSubview(willLabel)
        self.view.addSubview(cancelBt)
        cancelBt.backgroundColor = ColorMethodho(hexValue: 0x00c18b).withAlphaComponent(0.2)
        cancelBt.addTarget(self, action: #selector(cancelEvent), for: .touchUpInside)
        
    }
    
    fileprivate func configureTableView() {
        tableView.backgroundColor = ColorMethodho(hexValue: 0x00c18b).withAlphaComponent(0.2)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let innerData = RxTableViewSectionedReloadDataSource<UserSectionModel>()
        innerData.configureCell = {
            (curDataSource, curTableView, curIndex, curItem) in
            let cell = curTableView.dequeueReusableCell(withIdentifier: "cell", for: curIndex)
            cell.textLabel?.text = curItem.name + curItem.speech
            return cell
        }
        
        dataSource = Variable.init([])
        dataSource.asObservable()
            .bind(to: tableView.rx.items(dataSource: innerData))
            .addDisposableTo(disposeBag)
        
        tableView.rx.setDelegate(self)
            .addDisposableTo(disposeBag)
    }
    
    func cancelEvent() {
        print("cancel")
        guard let first = willArr.first,let anotherFirst = anotherWillArr.first else {
            return
        }
        print("ori = \(first.willVar),another = \(anotherFirst.willVar)")
        first.willVar = "oppos!"
        print("ori = \(first.willVar),another = \(anotherFirst.willVar)")
        
        guard var sfirst = sWillArr.first,let sanotherFirst = sAnotherWillArr.first else {
            return
        }
        print("ori = \(sfirst.structWillVar),another = \(sanotherFirst.structWillVar)")
        sfirst.structWillVar = "oppos!"
        print("ori = \(sfirst.structWillVar),another = \(sanotherFirst.structWillVar)")
        
        let user3 = User.init(name: "大刘", speech: "三体")
        let index = 1
        var model = sections[index]
        
        model.items.append(user3)
        sections[index] = model
        dataSource.value = sections
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let randomNum = arc4random() % 10
        
        willChangeStr = NSNumber.init(value: randomNum).stringValue
        obWill.value = willChangeStr
        print("curStr = \(willChangeStr)")
    }

}

class copyTest: NSObject {
    
    var willVar : String!
    
    override init() {
        
    }
}

struct copyStruct {
    var structWillVar : String!
    
}
