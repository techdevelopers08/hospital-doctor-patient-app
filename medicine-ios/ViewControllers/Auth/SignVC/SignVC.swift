//
//  SignVC.swift
//  medicine-ios
//
//  Created by MAC on 06/05/21.
//

import UIKit
import DropDown
class SignVC: UIViewController{
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var dropdownview: UIView!
    @IBOutlet weak var conditionLbl: UILabel!
    let todaysDate = Date()
    let datePicker = UIDatePicker()
    let genderarry = ["Male", "Female", "Other"]
    let dropDown = DropDown()
    var myString:NSString = "By Clicking Register Accept our Terms & Condition & Privacy Policies."
    var myMutableString = NSMutableAttributedString()
   
    var model = SignUpVM()
    override func viewDidLoad() {
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 16.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(cgColor: #colorLiteral(red: 0.001709969714, green: 0.829713881, blue: 0.7869009972, alpha: 1)), range: NSRange(location:12,length:8))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSRange(location:0,length:12))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSRange(location:21,length:11))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSRange(location:50,length:1))

        
            // set label Attribute
            conditionLbl.attributedText = myMutableString
        super.viewDidLoad()
        self.model.delegate = self
        showDatePicker()
//        datePicker.minimumDate = todaysDate
        dropDown.anchorView = dropdownview
        dropDown.dataSource = genderarry
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.genderTF.text = genderarry[index]
        }

    }
   
    @IBAction func eyeBtn(_ sender: Any) {
        
        if passwordTF.isSecureTextEntry == true{
            passwordTF.isSecureTextEntry = false
        }else{
            passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func showdropDown(_ sender: Any) {
        
        dropDown.show()
    }
    
    func signUpFinalData(){
        if nameTF?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.name)
        }else if genderTF?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.gender)
        }else if dobTF?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.dob)
        }else if emailTF?.isEmptyy() == true{
                showToast(message: CustomeAlertMsg.email)
        }else if emailTF?.isValidEmailAddress() == false{
            showToast(message: CustomeAlertMsg.validEmail)
        }else if passwordTF?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.password)

        }else{
            LoaderClass.shared.loadAnimation()
            var signUpParams = [String:Any]()
            signUpParams[Param.name] = self.nameTF?.text ?? ""
            signUpParams[Param.password] = self.passwordTF?.text ?? ""
            signUpParams[Param.email] = self.emailTF?.text ?? ""
            signUpParams[Param.gender] = self.genderTF?.text ?? ""
            signUpParams[Param.dob] = self.dobTF?.text ?? ""
            
            self.model.callApiSignUp(param: signUpParams)
        }
    }
    @IBAction func registerBtn(_ sender: Any) {
        signUpFinalData()
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    self.navigationController?.pushViewController(vc, animated: true)
    }
}
    extension SignVC: ResponseProtocol{
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
        print(response)
    }
    
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
        Alert.showSimple(msg)
//        showToast(message: msg)
    }
        
        func showDatePicker(){
               //Formate Date
               datePicker.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            } else {
               
            }

              //ToolBar
              let toolbar = UIToolbar();
              toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donedatePicker))
                let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
             let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

            toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
              
             dobTF.inputAccessoryView = toolbar
             dobTF.inputView = datePicker

            }
            @objc func donedatePicker(){

              let formatter = DateFormatter()
              formatter.dateFormat = "MM/yyyy"
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
//                datePicker.minimumDate = todaysDate
              dobTF.text = formatter.string(from: datePicker.date)
              self.view.endEditing(true)
            }

            @objc func cancelDatePicker(){
               self.view.endEditing(true)
             }
     
}

