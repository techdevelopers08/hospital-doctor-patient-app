//
//  MedicionDetailModelClass.swift
//  medicine-ios
//
//  Created by MAC on 03/06/21.
//

import Foundation
struct MedicionDetailModelClass: Codable {

    var created_at,med_day,med_strength_name,med_type_name,on_which_days_do_u_take_this_med,wht_med_would_u_like_to_add,how_pill_u_take_in_this : String?
    var do_u_nedd_to_take_this_med_every_day,med_id,medications_id,medicine_strength_id,medicine_type_id,user_id,what_strength_is_the_med : Int?
  
}
typealias medicionDetailModelClass = [MedicionDetailModelClass]?
