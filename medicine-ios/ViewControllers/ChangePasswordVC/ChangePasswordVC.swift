//
//  ChangePasswordVC.swift
//  medicine-ios
//
//  Created by MAC on 10/05/21.
//

import UIKit

class ChangePasswordVC: UIViewController {
    @IBOutlet var mainView: UIView!
   
    @IBOutlet weak var currentpasswordTF: UITextField!
    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    
    var model = ChangePassVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
      
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        if touch?.view == self.mainView { self.dismiss(animated: true, completion: nil) }
    }
    @IBAction func updateBtn(_ sender: Any) {
        changepass()
    }
   
    func changepass(){
        if currentpasswordTF?.isEmptyy() == true {
            Alert.showSimple(CustomeAlertMsg.currentpass)
        }else if newpassword?.isEmptyy() == true {
            Alert.showSimple(CustomeAlertMsg.newpass)
        }else if confirmpassword?.isEmptyy() == true {
            Alert.showSimple(CustomeAlertMsg.confirmpass)
        }else if newpassword.text != confirmpassword.text{
            Alert.showSimple(CustomeAlertMsg.passwordNotMatch)
        }
        else{
            LoaderClass.shared.loadAnimation()
            var changepassParam = [String:Any]()
            changepassParam[Param.oldpass] = self.currentpasswordTF?.text ?? ""
            changepassParam[Param.newpass] = self.newpassword?.text ?? ""
//            changepassParam[Param.confirmpass] = self.confirmpassword?.text ?? ""
            

            self.model.callApiChangePassword(param: changepassParam)
        }
    }
}
extension ChangePasswordVC:ResponseProtocol{
   
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        Alert.showSimple(CustomeAlertMsg.updatedSuccessfully)
        if msg == "Updated Successfully" {
        self.dismiss(animated: true, completion: nil)
        }
        }
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
        Alert.showSimple(msg)
    }

}
