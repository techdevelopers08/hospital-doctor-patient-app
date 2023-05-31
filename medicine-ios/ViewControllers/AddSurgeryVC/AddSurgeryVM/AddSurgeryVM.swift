//
//  AddSurgeryVM.swift
//  medicine-ios
//
//  Created by MAC on 26/05/21.
//

import Foundation

import Foundation
import UIKit

class AddSurgeryVM{
    
    var delegate : ResponseProtocol?

    func callapiaddSurgery(param:[String:Any], image: [UIImage]){
        
        APIClient.postMultiPartAuth1(url: .addsurgery, jsonObject: param, files: image, authorizationToken: true, refreshToken: false) { (response) in
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
    func callApiEditsurgery(param:[String:Any], image: [UIImage]){
        
        APIClient.postAuth(url: .editsurgery, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
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
