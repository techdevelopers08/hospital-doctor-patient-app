//
//  DiagnosisModelClass.swift
//  medicine-ios
//
//  Created by Apple on 21/05/21.
//

import Foundation
struct DiagnosisModelClass: Codable {

    var created_at,diagnosis_image,diagnosis_type,doctor_advice,from_date,reason_name,to_date: String?
    var diagnosis_id,status,total_diagnosis,user_id: Int?
}
typealias diagnosisModelClass = [DiagnosisModelClass]?
