//
//  SurgeryDetailVM.swift
//  medicine-ios
//
//  Created by MAC on 04/06/21.
//

import Foundation

class SurgeryDetailVM{
    
var delegate : ResponseProtocol?

func callApisurgerydetail(surgeryid : Int){
    var param = [String:Any]()
    param["surgery_id"] = surgeryid
   
    
    APIClient.postAuth(url: .surgerydetail, parameters: param , method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
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
