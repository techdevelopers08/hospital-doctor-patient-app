//
//  ForgotPassVM.swift
//  medicine-ios
//
//  Created by MAC on 14/06/21.
//
import Foundation

class ForgetPassVM{
    
    var delegate : ResponseProtocol?
    
    func callApiForgetPass(param:[String:Any]){
        
        APIClient.postAuth(url: .forgotpass, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: "email send successfully.", response: response)
            }else{
                self.delegate?.onFailure(msg: response["email send successfully."]  as? String ?? "")
            }
        } failureHandler: { (response) in
            print(response)
            if let msg = response["message"] as? String{
            self.delegate?.onFailure(msg: msg)
            }
        }

        
    }
    
}
