//
//  AddsosVM.swift
//  medicine-ios
//
//  Created by MAC on 10/06/21.
//

import Foundation

class AddsosVM{
    
    var delegate : ResponseProtocol?

    func callapiaddSos(param:[String:Any]){
        
        APIClient.postAuth(url: .addsosDetail, parameters: param , method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: CustomeAlertMsg.Done, response: response)
            }else{
                self.delegate?.onFailure(msg: response["imageUploadDone"]  as? String ?? "")
            }
        } failureHandler: { (response) in
            print(response)
            if let msg = response["message"] as? String{
            self.delegate?.onFailure(msg: msg)
            }
        }
    }
    func hiteditSosContact(param:[String:Any]){
      
        
        APIClient.postAuth(url: .editsoscontact, parameters: param , method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: CustomeAlertMsg.Done, response: response)
            }else{
                self.delegate?.onFailure(msg: response["imageUploadDone"]  as? String ?? "")
            }
        } failureHandler: { (response) in
            print(response)
            if let msg = response["message"] as? String{
            self.delegate?.onFailure(msg: msg)
            }
        }
    }
}
