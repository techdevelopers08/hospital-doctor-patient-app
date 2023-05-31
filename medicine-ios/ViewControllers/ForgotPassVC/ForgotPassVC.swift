//
//  ForgotPassVC.swift
//  medicine-ios
//
//  Created by MAC on 14/06/21.
//

import UIKit

class ForgotPassVC: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    var model = ForgetPassVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
      
    }
    

    @IBAction func submitBTN(_ sender: Any) {
        forgetpass()
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        if touch?.view == self.mainView { self.dismiss(animated: true, completion: nil) }
      }
    func forgetpass(){
        if emailTF?.isEmptyy() == true {
                showToast(message: CustomeAlertMsg.email)
        }else if emailTF?.isValidEmailAddress() == false{
                showToast(message: CustomeAlertMsg.validEmail)
        }else{
            LoaderClass.shared.loadAnimation()
            var changepassParam = [String:Any]()
            changepassParam[Param.email] = self.emailTF?.text ?? ""
            self.model.callApiForgetPass(param: changepassParam)
        }
    }

}
extension ForgotPassVC:ResponseProtocol{
   
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        
        self.dismiss(animated: true, completion: nil)
        print(response)
        print(msg)
        }
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
        showToast(message: msg)
    }

}
