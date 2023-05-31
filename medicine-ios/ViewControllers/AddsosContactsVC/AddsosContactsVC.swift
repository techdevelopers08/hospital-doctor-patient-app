//
//  AddsosContactsVC.swift
//  medicine-ios
//
//  Created by MAC on 10/05/21.
//

import UIKit
import DropDown


class AddsosContactsVC: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var relationTF: UITextField!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var mobilenoTF: UITextField!
    let genderarry = ["Father", "Mother","wife", "Husband","Brother","Sister","Other"]
    let dropDown = DropDown()
    var model = AddsosVM()
    var sosModel = SosModelClass()
    var index = 0
    var contactid = 0
    var isEdit = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        showSosContactData()
        dropDown.anchorView = dropdownView
        dropDown.dataSource = genderarry
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.relationTF.text = genderarry[index]
      
    }
       
    }
    
    
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func selectrelation(_ sender: Any) {
        
        dropDown.show()
    }
    @IBAction func submitBtn(_ sender: Any) {
        AddSosData()
    }
    func showSosContactData(){
        
        self.nameTF.text = self.sosModel.sc_name ?? ""
        self.relationTF.text = self.sosModel.sc_relation ?? ""
        self.mobilenoTF.text = self.sosModel.sc_number ?? ""
    }
    func AddSosData(){
        if nameTF?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.name)
        }else if relationTF?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.relation)
        }else if mobilenoTF?.isEmptyy() == true {
                showToast(message: CustomeAlertMsg.mobileno)
        }else{
            LoaderClass.shared.loadAnimation()
            var addSosParams = [String:Any]()
            
            addSosParams[Param.scname] = self.nameTF?.text ?? ""
            addSosParams[Param.screlation] = self.relationTF?.text ?? ""
            addSosParams[Param.scnumber] =  self.mobilenoTF?.text ?? 0
            if isEdit == true{
                addSosParams[Param.contactid] = self.sosModel.contact_id ?? 0
                self.model.hiteditSosContact(param: addSosParams)
            }else{
            self.model.callapiaddSos(param: addSosParams)
            }
            }
    }
}
extension AddsosContactsVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        self.navigationController?.popViewController(animated: true)
    }
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
        showToast(message: msg)
    }
}
