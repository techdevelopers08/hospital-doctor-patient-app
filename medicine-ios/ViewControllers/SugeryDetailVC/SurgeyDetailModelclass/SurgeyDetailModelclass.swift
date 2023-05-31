//
//  SurgeyDetailModelclass.swift
//  medicine-ios
//
//  Created by MAC on 04/06/21.
//

import Foundation

struct SurgeyDetailModelclass: Codable {

    var reason_name,hopital_address,hospital_name,reason_of_surgery,surgery_date,type_of_surgery,doctor_advice : String?
    var surgery_id,user_id : Int?
    var report_img: [diganosisimagenew]?
}
struct diganosisimagenew: Codable {
    var id,report_id,report_img_type: Int?
    var created_at,image : String?
    }

typealias surgeyDetailModelclass = SurgeyDetailModelclass?
