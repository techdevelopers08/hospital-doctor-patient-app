//
//  DiganosisdetailData.swift
//  medicine-ios
//
//  Created by MAC on 21/05/21.
//

import Foundation
struct DiganosisdetailData: Codable {

    var reason_name,diagnosis_type,from_date,to_date,doctor_advice,diagnosis_image : String?
    var diagnosis_id : Int?
    var diagnosis_report_img: [diganosisimage]?
}
struct diganosisimage: Codable {
    var id,report_id,report_img_type: Int?
    var created_at,image : String?
    }

typealias diganosisdetailData = DiganosisdetailData?
