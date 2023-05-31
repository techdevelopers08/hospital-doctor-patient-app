//
//  QrDetailVM.swift
//  medicine-ios
//
//  Created by MAC on 16/06/21.
//

import Foundation

class QrDetailVM{
    
var delegate : ResponseProtocol?

func hitApiscannerinfo(userid : Int){
    var param = [String:Any]()
    param["user_id"] = userid
   
    
    APIClient.postAuth(url: .scannerinfo, parameters: param , method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
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
