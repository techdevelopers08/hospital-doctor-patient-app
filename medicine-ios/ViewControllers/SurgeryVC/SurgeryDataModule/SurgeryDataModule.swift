//
//  SurgeryDataModule.swift
//  medicine-ios
//
//  Created by MAC on 03/06/21.
//

import Foundation
struct SurgeryDataModule: Codable {

    var created_at,reason_of_surgery,surgery_date,type_of_surgery,hospital_name,hopital_address,doctor_advice: String?
    var surgery_id,created_surgery,user_id: Int?
}
typealias surgerydataModule = [SurgeryDataModule?]
