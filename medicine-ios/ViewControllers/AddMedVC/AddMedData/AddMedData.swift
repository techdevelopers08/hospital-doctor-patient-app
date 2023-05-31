//
//  AddMedData.swift
//  medicine-ios
//
//  Created by MAC on 24/05/21.
//

import Foundation

struct AddMedData: Codable {

    var med_type_name,med_strength_name,created_at : String?
    var med_type_id,med_strength_id : Int?
}

typealias addmedData = [AddMedData]?
