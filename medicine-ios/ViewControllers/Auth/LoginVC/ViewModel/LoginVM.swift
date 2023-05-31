//
//  LoginViewModel.swift
//  JumpOn
//
//  Created by MAC on 23/04/21.
//

import UIKit

class LoginVM{
    
    var delegate : ResponseProtocol?
    
    func callApiLogin(param:[String:Any]){
        
        APIClient.postAuth(url: .login, parameters: param, method: .post, contentType: .applicationJson) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: CustomeAlertMsg.Done, response: response)
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
