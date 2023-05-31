//
//  MedDetailVM.swift
//  medicine-ios
//
//  Created by MAC on 03/06/21.
//

import Foundation

class MedDetailVM{
    
var delegate : ResponseProtocol?

func callApimediciondetail(medicationsid : Int){
    var param = [String:Any]()
    param["medications_id"] = medicationsid
//    LoaderClass.shared.loadAnimation()
    
    APIClient.postAuth(url: .mediciondetail, parameters: param , method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
        print(response)
        if isSuccess(json: response){
            self.delegate?.onSucsses(msg: "Medicion detail", response: response)
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
