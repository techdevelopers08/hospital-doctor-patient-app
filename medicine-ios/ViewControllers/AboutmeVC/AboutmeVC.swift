//
//  AboutmeVC.swift
//  medicine-ios
//
//  Created by MAC on 10/05/21.
//

import UIKit
import DropDown
import IBAnimatable
import SDWebImage
class AboutmeVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var imageBtn: UIPhotosButton!
    let todaysDate = Date()
    let datePicker = UIDatePicker()
    let genderarry = ["Male", "Female", "Other"]
    let dropDown = DropDown()
    var model = AboutmeVM()
    var homeModelData: homeModelClass?
    var modelnew = HomeVM()
    var image = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        imageBtn.closureDidFinishPickingAnUIImage = { (image) in
                       if let uploadImage = image {
                        self.profileImage.image = uploadImage
                        
                        self.model.callImageUploadApi(image: uploadImage)
                       }
        }
        self.model.delegate = self
        showDatePicker()
        self.modelnew.delegate = self
        modelnew.hitApimedata()
        setdata()
//        datePicker.minimumDate = todaysDate
        
        dropDown.anchorView = dropdownView
        dropDown.dataSource = genderarry
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.gender.text = genderarry[index]
            
    
    }
    }
    
    func setdata(){
        self.gender.text =  Cookies.userInfo()?.gender ?? ""
        self.nameTF.text = Cookies.userInfo()?.name ?? ""
        self.date.text = Cookies.userInfo()?.date ?? ""
        let url = URL(string: imageBaseUrl + (Cookies.userInfo()?.profileimage ?? ""))
        self.profileImage.sd_setImage(with: url , placeholderImage:#imageLiteral(resourceName: "color line"))
    }
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    @IBAction func selectgender(_ sender: Any) {
        
        dropDown.show()
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        AboutmeData()
    }
    func AboutmeData(){
        if nameTF?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.name)
        }else if gender?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.gender)
        }else if date?.isEmptyy() == true {
                showToast(message: CustomeAlertMsg.date)
        }else{
            LoaderClass.shared.loadAnimation()
            var aboutmeParams = [String:Any]()
            aboutmeParams[Param.name] = self.nameTF?.text ?? ""
            aboutmeParams[Param.gender] = self.gender?.text ?? ""
            aboutmeParams[Param.dob] =  self.date?.text ?? 0
            aboutmeParams[Param.profile_image] = image
//            aboutmeParams[Param.profile_image] = Cookies.userInfo()?.profileimage ?? ""
           
            self.model.callapiupdateprofile(param: aboutmeParams)     }
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
          
         date.inputAccessoryView = toolbar
         date.inputView = datePicker

        }
        @objc func donedatePicker(){

          let formatter = DateFormatter()
          formatter.dateFormat = "MM/yyyy"
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
//            datePicker.minimumDate = todaysDate
          date.text = formatter.string(from: datePicker.date)
          self.view.endEditing(true)
        }

        @objc func cancelDatePicker(){
           self.view.endEditing(true)
         }
}

extension AboutmeVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        if msg == CustomeAlertMsg.Done{
            
            
        }else if msg == CustomeAlertMsg.meData{
            let userDict = MeData(dict: response)
            Cookies.userInfoSave(dict: userDict.body?.first?.serverData)
            print(Cookies.userInfo()?.id ?? 0)
          
//            showToast(message: "Updated Successfully")
            self.setdata()
            
        }else if msg == CustomeAlertMsg.UpdateDone{
//            self.modelnew.hitApimedata()
//            aboutmeParams[Param.profile_image] = response["image"]
        self.navigationController?.popViewController(animated: true)
        }else if msg == "Image Updated"{
            var aboutmeParams = [String:Any]()
            aboutmeParams[Param.name] = self.nameTF?.text ?? ""
            aboutmeParams[Param.gender] = self.gender?.text ?? ""
            aboutmeParams[Param.dob] =  self.date?.text ?? 0
            aboutmeParams[Param.profile_image] = response["image"]
            image = response["image"] as! String
//            aboutmeParams[Param.profile_image] = Cookies.userInfo()?.profileimage ?? ""
           
//            self.model.callapiupdateprofile(param: aboutmeParams)
        }
    }
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
        showToast(message: msg)
    }
}
