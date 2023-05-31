//
//  DiganosisDetailVM.swift
//  medicine-ios
//
//  Created by MAC on 21/05/21.
//

import Foundation

class DiganosisDetailVM{
    
var delegate : ResponseProtocol?

func callApidiagnosisdetail(diagnosisid : Int){
    var param = [String:Any]()
    param["diagnosis_id"] = diagnosisid
   
    
    APIClient.postAuth(url: .diganosisdetail, parameters: param , method: .post, contentType: .applicationJson, authorizationToken: true) { (response) in
        print(response)
        if isSuccess(json: response){
            self.delegate?.onSucsses(msg: "BookID Done", response: response)
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
