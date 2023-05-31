//
//  AboutmeVM.swift
//  medicine-ios
//
//  Created by MAC on 10/06/21.
//

import Foundation
import UIKit

class AboutmeVM{
    
    var delegate : ResponseProtocol?
    var imageProfile = ""
    
    func callImageUploadApi(image: UIImage){
        LoaderClass.shared.loadAnimation()
        APIClient.postMultiPartAuth(url: .imageupload, jsonObject: [:]
                                    , profilePic: (key: "image_path",type: image), authorizationToken: true, refreshToken: false) { (response) in
            
            self.delegate?.onSucsses(msg:"Image Updated", response: response)
            
        } failureHandler: { (error) in
            print(error)
            if let msg = error["message"] as? String {
                self.delegate?.onFailure(msg: msg)
            }
            
        }
    }
    func callapiupdateprofile(param:[String:Any]){
        
        APIClient.postAuth(url: .updateProfile, parameters: param , method: .post, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
            print(response)
            if isSuccess(json: response){
                self.delegate?.onSucsses(msg: CustomeAlertMsg.UpdateDone, response: response)
            }else{
                self.delegate?.onFailure(msg: response["notUploaded"]  as? String ?? "")
            }
        } failureHandler: { (response) in
            print(response)
            if let msg = response["message"] as? String{
            self.delegate?.onFailure(msg: msg)
            }
        }
    }
   
}
