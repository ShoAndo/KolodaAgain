//
//  Realm.swift
//  KolodaAgain
//
//  Created by 安藤奨 on 2019/08/01.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import RealmSwift

class Photo : Object{
    @objc dynamic var id:Int = 0
    
    @objc dynamic var gazou:UIImage? 
    
    @objc dynamic var date: Date = Date()
    
}
