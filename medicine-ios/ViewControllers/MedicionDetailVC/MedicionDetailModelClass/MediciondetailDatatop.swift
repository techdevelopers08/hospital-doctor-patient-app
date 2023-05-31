//
//  MediciondetailDatatop.swift
//  medicine-ios
//
//  Created by MAC on 05/06/21.
//

import Foundation
struct MediciondetailDatatop: Codable {

    var wht_med_would_u_like_to_add : String?
    var med_id,medications_id : Int?
  
}
typealias mediciondetailDatatop = [MediciondetailDatatop]?
