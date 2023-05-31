//
//  MedicionModelClass.swift
//  medicine-ios
//
//  Created by MAC on 03/06/21.
//

import Foundation
struct MedicionModelClass: Codable {

    var created_at,diagnosis_image,med_date,med_doctor_advice,reason_name,to_date: String?
    var medications_id,status,total_med,user_id: Int?
}
typealias medicionModelClass = [MedicionModelClass?]

