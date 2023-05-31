//
//  AddMedicionVM.swift
//  medicine-ios
//
//  Created by MAC on 25/05/21.
//

import Foundation

class AddMedicionVM{
    
var delegate : ResponseProtocol?

    func callApiaddmedicion(param : [String:Any]){
//    var param = [String:Any]()
//    param["diagnosis_id"] = diagnosisid
   
    
    APIClient.postAuth(url: .addmedicine, parameters: param , method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
        print(response)
        if isSuccess(json: response){
            self.delegate?.onSucsses(msg: "Medicion Added", response: response)
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
