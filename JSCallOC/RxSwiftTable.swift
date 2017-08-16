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
    let Data = RxTableViewSectionedReloadDataSource<UserSectionModel>.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = ColorMethodho(hexValue: 0x00c18b).withAlphaComponent(0.2)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        let dataSource = Data
        let disposeBag = DisposeBag()
        
        dataSource.configureCell = {
            (_, tv, ip, item) in
            let cell = tv.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = item.name + item.speech
            return cell!
        }
        
        let sections = [
            UserSectionModel.init(items: [
                User.init(name: "钱钟书", speech: "围城"),
                User.init(name: "老舍", speech: "茶馆")
                ])
        ]
        Observable.just(sections)
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .addDisposableTo(disposeBag)
        
        tableView.rx.setDelegate(self)
        .addDisposableTo(disposeBag)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

}
