
import Foundation


class AddMedVM{
    
    var delegate : ResponseProtocol?

    func callApimediciontype(){
        
        APIClient.postAuth(url: .mediciontype, parameters: [:], method: .get, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
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
    
func callApimedicinestrength(){
    
    APIClient.postAuth(url: .medicinestrength, parameters: [:], method: .get, contentType: .applicationJson, authorizationToken: true, refreshToken: false) { (response) in
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
