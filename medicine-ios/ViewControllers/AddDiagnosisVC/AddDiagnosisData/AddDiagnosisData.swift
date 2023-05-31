//
//  AddDiagnosisData.swift
//  medicine-ios
//
//  Created by MAC on 10/05/21.
//

import Foundation
struct AddDiagnosisData: Codable {

   var diagnosis_type_name,diagnosis_image,created_at : String?
    var diagnosis_type_id,status : Int?
    
}

typealias adddiagnosisData = [AddDiagnosisData]?
