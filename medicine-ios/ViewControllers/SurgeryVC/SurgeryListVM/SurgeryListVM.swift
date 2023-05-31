//
//  SurgeryListVM.swift
//  medicine-ios
//
//  Created by MAC on 03/06/21.
//

import Foundation

class SurgeryListVM {
    
    var delegate : ResponseProtocol?
    func hitSurgeryListApi(listtype: Int){
        var param = [String:Any]()
        param["list_type"] = listtype
        APIClient.postAuth(url: .surgeryList, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: "SurgeryList Data", response: response)
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
    func hitDeleteSurgery(surgeryid : Int){
        var param = [String:Any]()
        param["surgery_id"] = surgeryid
        APIClient.postAuth(url: .deletesurgery, parameters: param, method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
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
