//
//  Protocol.swift
//  Log_bookly
//
//  Created by tech on 30/01/21.
//  Copyright © 2021 tecH. All rights reserved.
//

import Foundation
protocol ResponseProtocol {
    func onSucsses(msg:String,response:[String:Any])
    func onFailure(msg :String)
}

    
