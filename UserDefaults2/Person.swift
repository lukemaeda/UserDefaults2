//
//  Person.swift
//
//  Created by MAEDAHAJIME on 2015/07/05.
//  Copyright (c) 2015年 MAEDA HAJIME. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    
    // 名前
    let name: String
    // 住所
    let address: Address
    
    // コンストラクタ
    init(name: String, address: Address) {
        self.name = name
        self.address = address
    }
    
    // 復元用コンストラクタ
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.address = aDecoder.decodeObjectForKey("address") as! Address
    }
    
    // エンコード
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey:"name")
        aCoder.encodeObject(self.address, forKey:"address")
    }
}
