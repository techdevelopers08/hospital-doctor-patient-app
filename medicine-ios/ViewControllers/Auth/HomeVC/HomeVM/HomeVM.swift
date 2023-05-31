//
//  HomeVM.swift
//  medicine-ios
//
//  Created by MAC on 06/07/21.
//

import Foundation

class HomeVM{
    
    var delegate : ResponseProtocol?

    func hitApimedata(){
        
        APIClient.postAuth(url: .medata, parameters: [:], method: .get, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: CustomeAlertMsg.meData, response: response)
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
