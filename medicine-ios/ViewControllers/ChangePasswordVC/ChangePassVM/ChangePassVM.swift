//
//  ChangePassVM.swift
//  medicine-ios
//
//  Created by MAC on 10/06/21.
//

import Foundation
import UIKit

class ChangePassVM{
    
    var delegate : ResponseProtocol?
    
    func callApiChangePassword(param:[String:Any]){
        
        APIClient.postAuth(url: .changePass, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: "Password Changed Successfully", response: response)
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
