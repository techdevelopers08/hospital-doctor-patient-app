//
//  Singletone.swift
//  TakeChargeNxt
//
//  Created by IOS on 14/01/20.
//  Copyright © 2020 tecHangouts. All rights reserved.
//

import Foundation

class Singleton: NSObject {
   
    static let shared = Singleton()
    var isSetting : Bool?
    private override init() {
        super.init()
    }
    
    // MARK:- Variables
 
    
}
