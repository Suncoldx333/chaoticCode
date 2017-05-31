//
//  testModel.swift
//  JSCallOC
//
//  Created by 11111 on 2017/3/16.
//  Copyright © 2017年 wangdan. All rights reserved.
//

import UIKit

class testModel: baseModel {
    init(dic : [String : Any]) {
        super.init(changingDic: dic)
        
        let hah : Double = 1.23
        
        hah.halo()
        
        let arr = [1,2,3]
        let double = arr.map{
            $0 * 2
        }

    }
}
