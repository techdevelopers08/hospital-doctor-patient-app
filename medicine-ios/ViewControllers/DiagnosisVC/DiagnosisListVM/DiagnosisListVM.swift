//
//  DiagnosisListVM.swift
//  medicine-ios
//
//  Created by Apple on 21/05/21.
//

import Foundation
class DiagnosisListVM {
    
    var delegate : ResponseProtocol?
    func hitDiagnosisListApi(list_type: Int){
        var param = [String:Any]()
        param["list_type"] = list_type
        APIClient.postAuth(url: .diagnosisList, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: "DiagnosisList Data", response: response)
            }else{
                self.delegate?.onFailure(msg: response["message"]  as? String ?? "")
            }
        } failureHandler: { (response) in
            print(response)
            if let msg = response["message"] as? String{
            self.delegate?.onFailure(msg: msg)
        }

        
    }
    
}
    func hitDeleteDiganosis(diagnosisid : Int){
        var param = [String:Any]()
        param["diagnosis_id"] = diagnosisid
        APIClient.postAuth(url: .deletediagnosis, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: "Delete Data", response: response)
            }else{
                self.delegate?.onFailure(msg: response["message"]  as? String ?? "")
            }
        } failureHandler: { (response) in
            print(response)
            if let msg = response["message"] as? String{
            self.delegate?.onFailure(msg: msg)
        }

        
    }
        
}
}
