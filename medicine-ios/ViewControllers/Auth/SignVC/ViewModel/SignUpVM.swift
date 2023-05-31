import Foundation
import UIKit

class SignUpVM{
    
    var delegate : ResponseProtocol?
    
    func callApiSignUp(param:[String:Any]){
        
        APIClient.postAuth(url: .signUp, parameters: param, method: .post, contentType: .applicationJson) { (response) in
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
