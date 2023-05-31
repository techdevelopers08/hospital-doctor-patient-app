//
//  MedicionVM.swift
//  medicine-ios
//
//  Created by MAC on 03/06/21.
//

import Foundation
class MedicionVM {
    
    var delegate : ResponseProtocol?
    func hitApimedicionlist(){
        
        
        APIClient.postAuth(url: .medicinelist, parameters: [:], method: .get, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
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
    func hitDeleteMedicion(medicionid : Int){
        var param = [String:Any]()
        param["medication_id"] = medicionid
        APIClient.postAuth(url: .deletemedicion, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
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
