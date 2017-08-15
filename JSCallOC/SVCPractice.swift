//
//  SVCPractice.swift
//  JSCallOC
//
//  Created by 11111 on 2017/8/15.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

let dummy = [
    "Buy the milk",
    "Take my dog",
    "Rent a car"
]


struct ToDoStore {
    
    static let share = ToDoStore()
    func getToDoItems(completionHandler : (([String]) -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            completionHandler?(dummy)
        }
    }
}

struct CellKeys {
    static let share = CellKeys()
    
    let todoCellKey = "todoCellKey"
    let inputCellKey = "inputCellKey"
    
}

class SVCPracticeTable: UITableViewController {
    
    var todos : [String] = []
    enum Section : Int {
        case input = 0,todos,max
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellKeys.share.todoCellKey)
        self.tableView.register(TableViewInputCell.self, forCellReuseIdentifier: CellKeys.share.inputCellKey)
        self.tableView.separatorStyle = .none
        
        ToDoStore.share.getToDoItems { (data) in
            self.todos += data
            self.title = "TODO - \(self.todos.count)"
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView!) -> Int {
        return Section.max.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let innerSection = Section.init(rawValue: section) else {
            fatalError()
        }
        
        switch innerSection {
        case .input: return 1
        case .todos: return todos.count
        case .max: fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let innerSection = Section.init(rawValue: indexPath.section) else {
            fatalError()
        }
        
        switch innerSection {
        case .input:
            let cell : TableViewInputCell = tableView.dequeueReusableCell(withIdentifier: CellKeys.share.inputCellKey) as! TableViewInputCell
            return cell
            
        case .todos:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellKeys.share.todoCellKey)
            cell?.textLabel?.text = todos[indexPath.row]
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
            return cell!
            
        default:
            fatalError()
        }
    }
}

class TableViewInputCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var input: UITextField = {
        let inner = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 45))
        return inner
    }()
    
    func initUI() {
        
    }
    
}

class SVCPractice: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
