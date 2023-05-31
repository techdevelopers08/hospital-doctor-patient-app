//
//  HomeModelClass.swift
//  medicine-ios
//
//  Created by MAC on 06/07/21.
//

import Foundation

struct HomeModelClass: Codable {

   var created_at,dob,email,gender,name,pass,profile_image : String?
    var id : Int?
    
}

typealias homeModelClass = [HomeModelClass]
