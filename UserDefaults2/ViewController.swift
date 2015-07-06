//
//  ViewController.swift
//  UserDefaults2
//
//  Created by MAEDAHAJIME on 2015/07/05.
//  Copyright (c) 2015年 MAEDA HAJIME. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var teString: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 保存
    @IBAction func save() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // 鈴木太郎、京子オブジェクト(住所が同じ夫婦という設定)
        let address1 = Address(zipCode: "104-0061",
            state: "東京都", city: "中央区", other: "銀座1丁目")
        let taroYamada = Person(name: "鈴木太郎", address: address1)
        let hanakoYamada = Person(name: "鈴木京子", address: address1)
        
        // 田中一郎オブジェクト
        let address2 = Address(zipCode: "540-0001",
            state: "大阪府", city: "大阪市", other: "北区")
        let jiroTanaka = Person(name: "田中一郎", address: address2)
        let archivedTaroYamada = NSKeyedArchiver.archivedDataWithRootObject(taroYamada)
        let archivedHanakoYamada = NSKeyedArchiver.archivedDataWithRootObject(hanakoYamada)
        let archivedIhirouTanaka = NSKeyedArchiver.archivedDataWithRootObject(jiroTanaka)
        
        // 保存するデータを配列にまとめる
        let array = [archivedTaroYamada, archivedHanakoYamada, archivedIhirouTanaka]
        defaults.setObject(array, forKey: "address-list")
        
        // synchronize すぐに値を反映
        let successful = defaults.synchronize()
        if successful {
            println("データの保存に成功しました。")
            teString.text = "データの保存に成功しました。" + "\n"
        }
    }
    
    // 読込
    @IBAction func read() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let addressList = defaults.arrayForKey("address-list") as! [NSData]
        
        teString.text  = nil
        
        for data in addressList {
            
            let person = NSKeyedUnarchiver.unarchiveObjectWithData(data as NSData) as! Person
            println(person.name)
            println(person.address.zipCode)
            println(person.address.state)
            println(person.address.city)
            println(person.address.other)
            
            teString.text = teString.text +  (person.name as String) + "\n"
            teString.text = teString.text +  (person.address.zipCode as String) + "\n"
            teString.text = teString.text +  (person.address.state as String) + "\n"
            teString.text = teString.text +  (person.address.city as String) + "\n"
            teString.text = teString.text +  (person.address.other as String) + "\n"
        }
    }
}

