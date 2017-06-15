//
//  CustomNavController.swift
//  JSCallOC
//
//  Created by 11111 on 2017/6/7.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

class CustomNavController: UINavigationController,UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initData() {
        self.delegate = self
    }
    
    func initUI() {
        self.view.backgroundColor = hexColor(colorCode: 0xe6e6e6)
        
        self.navigationBar.barTintColor = hexColor(colorCode: 0x404040)
        
        let faLayer = CALayer.init()
        faLayer.backgroundColor = hexColor(colorCode: 0xfafafa).cgColor
        faLayer.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: self.navigationBar.frame.height)
        
        
        self.navigationBar.layer .addSublayer(faLayer)
        self.navigationBar.barStyle = UIBarStyle.blackTranslucent
        
        self.navigationBar.titleTextAttributes = createCenterTitle()
        
        
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        
    }

}

extension CustomNavController{
    
    func createCenterTitle() -> [String : Any]? {
        return {[NSForegroundColorAttributeName : hexColor(colorCode: 0x333333),NSFontAttributeName : UIFont.systemFont(ofSize: 13)]}()
    }
}
