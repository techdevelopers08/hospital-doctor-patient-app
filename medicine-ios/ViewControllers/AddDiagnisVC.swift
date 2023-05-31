//
//  AddDiagnisVC.swift
//  medicine-ios
//
//  Created by MAC on 10/05/21.
//

import UIKit
import DropDown
import SDWebImage

class AddDiagnisVC: UIViewController {
    @IBOutlet weak var fromdateLbl: UILabel!
    @IBOutlet weak var todateView: UIView!
    @IBOutlet weak var impressionLbl: UILabel!
    @IBOutlet weak var reasonofdiganosis: UITextField!
    @IBOutlet weak var typeofdiganosis: UITextField!
    @IBOutlet weak var todate: UITextField!
    @IBOutlet weak var fromdate: UITextField!
    @IBOutlet weak var impression: UITextField!
    @IBOutlet weak var addDiagnosisCV: UICollectionView!
    @IBOutlet weak var dropdownTV: UITableView!
    let todaysDate = Date()
    let datePicker = UIDatePicker()
   
    let data = ["OPD","Hospitalization","new added","old added"]
    var addimage = [UIImage]()
    var adddiagnosisDatacount: adddiagnosisData?
    var model = AddDiagnisVM()
    var imagePicker: ImagePicker!
    var count = 1
    var diganosisModel = DiagnosisModelClass()
    var index = 0
    var contactid = 0
    var isEdit = Bool()
    var showdata = "OPD"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.model.hitApidiganosistype()
        self.model.delegate = self
        submitFinalData()
        showSosContactData()
        showDatePicker()
        showDatePickernew()
        impressionLbl.text = "impression"
        todateView.isHidden = true
        fromdateLbl.text = "Date"
        datePicker.minimumDate = todaysDate
        self.addDiagnosisCV.delegate = self
        self.addDiagnosisCV.dataSource = self
        let nib = UINib.init(nibName: "AddSurgeryCell", bundle: nil)
        self.addDiagnosisCV.register(nib, forCellWithReuseIdentifier: "AddSurgeryCell")
        dropdownTV.isHidden = true
        dropdownTV.delegate = self
        dropdownTV.dataSource = self
        dropdownTV.register(UINib(nibName: "SelectdataTVCell", bundle: nil), forCellReuseIdentifier: "SelectdataTVCell")
//        self.uploadImagesCell.addSubview(addDiagnosisCV)
       //            addimage.append(UIImage.init(named: "c")!)
    }
    
  
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func selectdiagnosis(_ sender: Any) {
        
        if  dropdownTV.isHidden == true{
       
            dropdownTV.isHidden = false
        }else{
          
            dropdownTV.isHidden = true
        }
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        submitFinalData()
    }
    func showSosContactData(){
        if typeofdiganosis.text == "OPD"{
            impressionLbl.text = "impression"
            todateView.isHidden = true
            fromdateLbl.text = "Date"
            
        }else{
            impressionLbl.text = "Doctor Advice"
            todateView.isHidden = false
            fromdateLbl.text = "From date"
        }
        self.reasonofdiganosis.text = self.diganosisModel.reason_name ?? ""
        self.typeofdiganosis.text = self.diganosisModel.diagnosis_type ?? ""
        self.fromdate.text = self.diganosisModel.from_date ?? ""
        self.todate.text = self.diganosisModel.to_date ?? ""
        self.impression.text = self.diganosisModel.doctor_advice ?? ""
//        self.fromdate.text = self.sosModel.sc_number ?? ""
    }
    func todatesubmit(){
      
    }
    func submitFinalData(){
        if reasonofdiganosis?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.reasonname)
        }else if typeofdiganosis?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.type)
        }else if impression?.isEmptyy() == true{
            showToast(message: CustomeAlertMsg.impression)
            
        }else{
            if showdata == "Hospitalization"{
                if fromdate?.isEmptyy() == true {
                    showToast(message: CustomeAlertMsg.date)
                }else if todate?.isEmptyy() == true {
                    showToast(message: CustomeAlertMsg.date)
                }else{
                    LoaderClass.shared.loadAnimation()
                    var adddiagonis = [String:Any]()
                    adddiagonis[Param.reasontype] = self.reasonofdiganosis?.text ?? ""
                    adddiagonis[Param.diganosistype] = self.typeofdiganosis?.text ?? ""
                    adddiagonis[Param.todate] = self.todate?.text ?? ""
                    adddiagonis[Param.fromdate] = self.fromdate?.text ?? ""
                    adddiagonis[Param.doctoradvice] = self.impression?.text ?? ""
                    if isEdit == true{
                        adddiagonis[Param.diagnosisid] = self.diganosisModel.diagnosis_id ?? 0
                        self.model.callApiEditdiganosis(param: adddiagonis)
                    }else{
                        self.model.callapiaddDiagnosis(param: adddiagonis, image: addimage)
                    }
                  
                }
            }else if showdata == "OPD"{
            if fromdate?.isEmptyy() == true {
                showToast(message: CustomeAlertMsg.date)
            }else{
                LoaderClass.shared.loadAnimation()
                var adddiagonis = [String:Any]()
                adddiagonis[Param.reasontype] = self.reasonofdiganosis?.text ?? ""
                adddiagonis[Param.diganosistype] = self.typeofdiganosis?.text ?? ""
//                adddiagonis[Param.todate] = self.todate?.text ?? ""
                adddiagonis[Param.fromdate] = self.fromdate?.text ?? ""
                adddiagonis[Param.doctoradvice] = self.impression?.text ?? ""
                if isEdit == true{
                    adddiagonis[Param.diagnosisid] = self.diganosisModel.diagnosis_id ?? 0
                    self.model.callApiEditdiganosis(param: adddiagonis)
                }else{
                self.model.callapiaddDiagnosis(param: adddiagonis, image: addimage)
                }
            }
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
          
         todate.inputAccessoryView = toolbar
        todate.inputView = datePicker

        }
    func showDatePickernew(){
        datePicker.datePickerMode = .date
     if #available(iOS 13.4, *) {
         datePicker.preferredDatePickerStyle = .wheels
     } else {
        
     }
        
       
        let toolbarnew = UIToolbar();
        toolbarnew.sizeToFit()
        
        

        let doneButtonnew = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donedatePickernew))
        
      let spaceButtonnew = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
     
        
       let cancelButtonnew = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbarnew.setItems([doneButtonnew,spaceButtonnew,cancelButtonnew], animated: false)
       
        fromdate.inputAccessoryView = toolbarnew
        fromdate.inputView = datePicker
      
        datePicker.datePickerMode = .date

     }
    @objc func donedatePickernew(){

     let formatter = DateFormatter()
      formatter.dateStyle = .medium
      formatter.timeStyle = .none
      datePicker.minimumDate = todaysDate
      fromdate.text = formatter.string(from: datePicker.date)
     self.view.endEditing(true)
   }
        @objc func donedatePicker(){

          let formatter = DateFormatter()
          formatter.dateFormat = "MM/yyyy"
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            datePicker.minimumDate = todaysDate
            todate.text = formatter.string(from: datePicker.date)
          self.view.endEditing(true)
        }

        @objc func cancelDatePicker(){
           self.view.endEditing(true)
         }
    
    
    
    
}

extension AddDiagnisVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImagePickerDelegate{
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
            let cell = addDiagnosisCV.dequeueReusableCell(withReuseIdentifier: "AddSurgeryCell", for: indexPath) as! AddSurgeryCell
            cell.adddataview.isHidden = false
            cell.showdataView.isHidden = true
            cell.imagecount.text = "\(addimage.count + 1)"
            cell.callBackUploadImage = {index in
                cell.addImage.closureDidFinishPickingAnUIImage = { (image) in
                               if let uploadImage = image {
                                   self.addimage.append(image!)
                                self.addDiagnosisCV.reloadData()
                               }
                           }
            }
            return cell
        }else {
            let cell = addDiagnosisCV.dequeueReusableCell(withReuseIdentifier: "AddSurgeryCell", for: indexPath) as! AddSurgeryCell
            if indexPath.row == 0{
                cell.adddataview.isHidden = false
                cell.showdataView.isHidden = true
                
                cell.callBackUploadImage = {index in
                    cell.addImage.closureDidFinishPickingAnUIImage = { (image) in
                                   if let uploadImage = image {
                                       self.addimage.append(image!)
                                    self.addDiagnosisCV.reloadData()
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
            let width = (self.addDiagnosisCV.frame.size.width) / 2
            
            return CGSize(width: width , height: 180)
        }else{
            let width = (self.addDiagnosisCV.frame.size.width) / 2
            
            return CGSize(width: width , height: 180)
        }
        let width = (self.addDiagnosisCV.frame.size.width) / 2
        
        return CGSize(width: width , height: 180)
       
     }
    @objc func updateImage(_ sender: UIButton){
        self.imagePicker.present(from: sender as UIView)
    }
}
extension AddDiagnisVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return adddiagnosisDatacount??.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1{
        }else if todate?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.date)
        }
        let cell = dropdownTV.dequeueReusableCell(withIdentifier: "SelectdataTVCell", for: indexPath) as! SelectdataTVCell
        cell.mainLbl.text = adddiagnosisDatacount??[indexPath.row].diagnosis_type_name ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        let height = dropdownTV.frame.height
        return height / CGFloat(adddiagnosisDatacount??.count ?? 0)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
        let selectionData = adddiagnosisDatacount??[indexPath.row].diagnosis_type_name ?? ""
        typeofdiganosis.text = selectionData
        self.dropdownTV.isHidden = true
        
        if indexPath.row == 0{
            impressionLbl.text = "impression"
            todateView.isHidden = true
            fromdateLbl.text = "Date"
            showdata = "OPD"
            todatesubmit()
            
        }else{
            impressionLbl.text = "Doctor Advice"
            todateView.isHidden = false
            fromdateLbl.text = "From date"
            showdata = "Hospitalization"
            if todate?.isEmptyy() == true {
                showToast(message: CustomeAlertMsg.date)
            }
            
        }
      
    }
}

extension AddDiagnisVC: ResponseProtocol{
func onSucsses(msg: String, response: [String : Any]) {
    LoaderClass.shared.stopAnimation()
    print(response)
    if  msg == "Diganosislist"{
        do {
            let jsondata = try JSONSerialization.data(withJSONObject: response["body"] ?? [] , options: .prettyPrinted)
            let encodedJson = try JSONDecoder().decode(adddiagnosisData.self, from: jsondata)
            self.adddiagnosisDatacount = encodedJson
            self.dropdownTV.reloadData()
            
        }catch {
            
        }
    }else{
        self.navigationController?.popViewController(animated: true)
    }
}

func onFailure(msg: String) {
    LoaderClass.shared.stopAnimation()
    print(msg)
    showToast(message: msg)
}
}
