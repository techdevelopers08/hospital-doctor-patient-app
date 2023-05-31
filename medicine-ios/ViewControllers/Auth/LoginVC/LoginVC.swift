//
//  LoginVC.swift
//  medicine-ios
//
//  Created by MAC on 06/05/21.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    var model = LoginVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF?.text = "bagauliharshit0@gmail.com"
        passwordTF?.text = "123456"
        self.model.delegate = self
       
    }
    

    @IBAction func loginBtn(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//                    self.navigationController?.pushViewController(vc, animated: true)
        loginFinalData()
    }
    @IBAction func eyeBtn(_ sender: Any) {
        
        if passwordTF.isSecureTextEntry == true{
            passwordTF.isSecureTextEntry = false
        }else{
            passwordTF.isSecureTextEntry = true
        }
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignVC") as! SignVC
                    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotPassBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPassVC") as! ForgotPassVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true,completion: nil)
    }
    func loginFinalData(){
        if emailTF?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.email)
        }else if passwordTF?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.password)
        }else{
            LoaderClass.shared.loadAnimation()
            var loginParams = [String:Any]()
       
            loginParams[Param.email] = self.emailTF?.text ?? ""
            loginParams[Param.password] = self.passwordTF?.text ?? ""
            
            self.model.callApiLogin(param: loginParams)

        }
    }
}
extension LoginVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        
        let tok = response["body"] as? [String: Any]
        let token = tok?["token"]
        UserDefaults.standard.setValue(token, forKey: UserDefaultKey.kUserToken)
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
        showToast(message: msg)
    }
}
