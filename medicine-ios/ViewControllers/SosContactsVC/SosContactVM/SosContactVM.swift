//
//  SosContactVM.swift
//  medicine-ios
//
//  Created by MAC on 10/06/21.
//

import Foundation

class SosContactVM{
    
    var delegate : ResponseProtocol?
func hitApicontactList(){
    
    APIClient.postAuth(url: .contactList, parameters: [:], method: .get, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
        print(response)
        if isSuccess(json: response){
            self.delegate?.onSucsses(msg: CustomeAlertMsg.contactlist, response: response)
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
    func hitDeleteSosContact(contactid : Int){
        var param = [String:Any]()
        param["contact_id"] = contactid
        APIClient.postAuth(url: .deletesoscontact, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: "Delete Data", response: response)
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
