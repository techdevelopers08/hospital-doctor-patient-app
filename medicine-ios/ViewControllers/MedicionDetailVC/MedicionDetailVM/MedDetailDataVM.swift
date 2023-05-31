//
//  MedDetailDataVM.swift
//  medicine-ios
//
//  Created by MAC on 23/06/21.
//

import Foundation

class MedDetailDataVM{
    
var delegate : ResponseProtocol?


    func callApisinglemeddetail(medid : Int){
        var param = [String:Any]()
        param["med_id"] = medid


        APIClient.postAuth(url: .signlemeddetail, parameters: param , method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: "Done", response: response)
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
