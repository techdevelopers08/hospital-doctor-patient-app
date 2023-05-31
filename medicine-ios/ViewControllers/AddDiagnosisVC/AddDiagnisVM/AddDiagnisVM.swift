//
//  AddDiagnisVM.swift
//  medicine-ios
//
//  Created by MAC on 10/05/21.
//

import Foundation
import UIKit

class AddDiagnisVM{
    
    var delegate : ResponseProtocol?

    func callapiaddDiagnosis(param:[String:Any], image: [UIImage]){
        
        APIClient.postMultiPartAuth1(url: .adddiagnosis, jsonObject: param, files: image, authorizationToken: true, refreshToken: false) { (response) in
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
    
    func hitApidiganosistype(){
        
        APIClient.postAuth(url: .diagnosistype, parameters: [:], method: .get, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: CustomeAlertMsg.Diganosislist, response: response)
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
    func callApiEditdiganosis(param:[String:Any]){
        
        APIClient.postAuth(url: .editdiagnosis, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: "message", response: response)
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
