//
//  AddSurgeryVC.swift
//  medicine-ios
//
//  Created by MAC on 07/05/21.
//

import UIKit
var  index = 0
class AddSurgeryVC: UIViewController {
    @IBOutlet weak var addsurgeryCV: UICollectionView!
    @IBOutlet weak var reasonofSurgery: UITextField!
    @IBOutlet weak var typeofsurgery: UITextField!
    @IBOutlet weak var dropdownTV: UITableView!
    @IBOutlet weak var surgerDate: UITextField!
    @IBOutlet weak var hospitalName: UITextField!
    @IBOutlet weak var hospitalAddress: UITextField!
    @IBOutlet weak var doctorAdvice: UITextField!
    let todaysDate = Date()
    let datePicker = UIDatePicker()
    let data = ["General Surgery","Hospitalization"]
    var addimage = [UIImage]()
    var model = AddSurgeryVM()
    var imagePicker: ImagePicker!
    var index = 0
    var surgeryid = 0
    var modelsurgery = SurgeryDataModule()
    var isEdit = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.model.delegate = self
        submitFinalData()
        showDatePicker()
        setData()
//        datePicker.minimumDate = todaysDate
        self.addsurgeryCV.delegate = self
        self.addsurgeryCV.dataSource = self
        let nib = UINib.init(nibName: "AddSurgeryCell", bundle: nil)
        self.addsurgeryCV.register(nib, forCellWithReuseIdentifier: "AddSurgeryCell")
        dropdownTV.isHidden = true
        dropdownTV.delegate = self
        dropdownTV.dataSource = self
        dropdownTV.register(UINib(nibName: "SelectdataTVCell", bundle: nil), forCellReuseIdentifier: "SelectdataTVCell")
    }
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dropdownBtn(_ sender: Any) {
        if  dropdownTV.isHidden == true{
       
            dropdownTV.isHidden = false
        }else{
          
            dropdownTV.isHidden = true
        }
    }
    @IBAction func submitBtn(_ sender: Any) {
        submitFinalData()
    }
    func setData(){
            self.reasonofSurgery.text = self.modelsurgery.reason_of_surgery ?? ""
            self.typeofsurgery.text = self.modelsurgery.type_of_surgery ?? ""
            self.surgerDate.text = self.modelsurgery.surgery_date ?? ""
            self.hospitalName.text = self.modelsurgery.hospital_name ?? ""
            self.hospitalAddress.text = self.modelsurgery.hopital_address ?? ""
            self.doctorAdvice.text = self.modelsurgery.doctor_advice ?? ""
    }
    func submitFinalData(){
        if reasonofSurgery?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.reasonname)
        }else if typeofsurgery?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.type)
        }else if surgerDate?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.date)
        }else if hospitalName?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.hospitalname)
        }else if hospitalAddress?.isEmptyy() == true{
            showToast(message: CustomeAlertMsg.address)
        }else if doctorAdvice?.isEmptyy() == true{
            showToast(message: CustomeAlertMsg.doctoradvice)
        }else{
            LoaderClass.shared.loadAnimation()
            var addsurgery = [String:Any]()
            addsurgery[Param.reasonofsurgery] = self.reasonofSurgery?.text ?? ""
            addsurgery[Param.surgerydate] = self.surgerDate?.text ?? ""
            addsurgery[Param.hospitalname] = self.hospitalName?.text ?? ""
            addsurgery[Param.hopitaladdress] = self.hospitalAddress?.text ?? ""
            addsurgery[Param.doctoradvice] = self.doctorAdvice?.text ?? ""
            addsurgery[Param.typeof_surgery] = self.typeofsurgery?.text ?? ""
            if isEdit == true{
                addsurgery[Param.surgerytypeid] = self.modelsurgery.surgery_id ?? 0
             self.model.callapiaddSurgery(param: addsurgery, image: addimage)
            }else{
            self.model.callapiaddSurgery(param: addsurgery, image: addimage)
        }
    }
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
          
        surgerDate.inputAccessoryView = toolbar
        surgerDate.inputView = datePicker

        }
    @objc func donedatePicker(){

      let formatter = DateFormatter()
      formatter.dateFormat = "MM/yyyy"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
//        datePicker.minimumDate = todaysDate
        surgerDate.text = formatter.string(from: datePicker.date)
      self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }
}
extension AddSurgeryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,ImagePickerDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if addimage.count == 0{
            return 1
        }else{
            return addimage.count + 1
        }
    
    }
    func didSelect(image: UIImage?) {
//     self.addimage.image = image
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if addimage.count == 0{
            let cell = addsurgeryCV.dequeueReusableCell(withReuseIdentifier: "AddSurgeryCell", for: indexPath) as! AddSurgeryCell
            cell.adddataview.isHidden = false
            cell.showdataView.isHidden = true
            
            cell.callBackUploadImage = {index in
                cell.addImage.closureDidFinishPickingAnUIImage = { (image) in
                               if let uploadImage = image {
                                   self.addimage.append(image!)
                                self.addsurgeryCV.reloadData()
                               }
                           }
            }
            return cell
        }else {
            let cell = addsurgeryCV.dequeueReusableCell(withReuseIdentifier: "AddSurgeryCell", for: indexPath) as! AddSurgeryCell
            if indexPath.row == 0{
                cell.adddataview.isHidden = false
                cell.showdataView.isHidden = true
                
                cell.callBackUploadImage = {index in
                    cell.addImage.closureDidFinishPickingAnUIImage = { (image) in
                                   if let uploadImage = image {
                                       self.addimage.append(image!)
                                    self.addsurgeryCV.reloadData()
                                   }
                               }
                }
            }else{
                cell.adddataview.isHidden = true
                cell.showdataView.isHidden = false
                if addimage.count == 0{
                    
                }else{
                    let info = (addimage[indexPath.row - 1])
                    if ((info) != nil) {
        //                cell.mainImage.isHidden = true
                        cell.mainImage.image = info
                        
                    }
                }
            }
        
          
//            let url = "http://api.deploywork.com" +
//            cell.mainImage.sd_setImage(with: addimage[indexPath.row] , placeholderImage:#imageLiteral(resourceName: "profiledemo"))
            return cell
        }
        return UICollectionViewCell()

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == addimage.count + 1{
            let width = (self.addsurgeryCV.frame.size.width) / 2
            
            return CGSize(width: width , height: 180)
        }else{
            let width = (self.addsurgeryCV.frame.size.width) / 2
            
            return CGSize(width: width , height: 180)
        }
        let width = (self.addsurgeryCV.frame.size.width) / 2
        
        return CGSize(width: width , height: 180)
       
     }
    @objc func updateImage(_ sender: UIButton){
        self.imagePicker.present(from: sender as UIView)
    }
}
extension AddSurgeryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return adddiagnosisDatacount??.count ?? 0
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropdownTV.dequeueReusableCell(withIdentifier: "SelectdataTVCell", for: indexPath) as! SelectdataTVCell
//        cell.mainLbl.text = adddiagnosisDatacount??[indexPath.row].diagnosis_type_name ?? ""
        cell.mainLbl.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        let height = dropdownTV.frame.height
//        return height / CGFloat(adddiagnosisDatacount??.count ?? 0)
        return height / CGFloat(data.count)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let selectionData = addSurgeryDataCount??[indexPath.row].diagnosis_type_name ?? ""
        let selectionData = data[indexPath.row]
        typeofsurgery.text = selectionData
        self.dropdownTV.isHidden = true
      
    }
}

extension AddSurgeryVC: ResponseProtocol{
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
