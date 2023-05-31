//
//  SosModelClass.swift
//  medicine-ios
//
//  Created by MAC on 10/06/21.
//


import Foundation
struct SosModelClass: Codable {

   var created_at,sc_name,sc_relation,sc_number : String?
   var contact_id,total_sos_contact,user_id : Int?
    
}

typealias sosModelClass = [SosModelClass]?
