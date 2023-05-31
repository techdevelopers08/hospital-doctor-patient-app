//
//  QrDetailModelClass.swift
//  medicine-ios
//
//  Created by MAC on 16/06/21.
//

import Foundation

struct QrDetailModelClass: Codable {

    var dob,email,gender,created_at,name,pass,profile_image : String?
    var id : Int?
    var diagnosis: [DiganosisDetail]?
    var sos_contact: [SosContactDetail]?
    var medications: [MedicionDetail]?
    var surgery: [SurgeryDetail]?
}
struct DiganosisDetail: Codable {
    var diagnosis_id,status,total_diagnosis,user_id : Int?
    var created_at,diagnosis_image,diagnosis_type,doctor_advice,from_date,reason_name,to_date : String?
    }
struct MedicionDetail: Codable {
    var diagnosis_id,medications_id,total_med,user_id : Int?
    var created_at,diagnosis_image,med_date,med_doctor_advice,reason_name : String?
    }
struct SosContactDetail: Codable {
    var  user_id,total_sos_contact,contact_id : Int?
     var created_at,sc_relation,sc_name,sc_number : String?
}
struct SurgeryDetail: Codable {
    var  created_surgery,surgery_id : Int?
    var surgery_date,reason_of_surgery,type_of_surgery : String?
    }
typealias qrdetailModelClass = QrDetailModelClass?
