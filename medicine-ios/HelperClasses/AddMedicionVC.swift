//
//  AddMedicionVC.swift
//  medicine-ios
//
//  Created by MAC on 09/05/21.
//

import UIKit

class AddMedicionVC: UIViewController {
    @IBOutlet weak var dateLbl: UITextField!
    @IBOutlet weak var lblSelectHere: UILabel!
    @IBOutlet weak var doctorAdviceLbl: UITextField!
    @IBOutlet weak var txtaddmedcount: UILabel!
    let todaysDate = Date()
    let datePicker = UIDatePicker()
    var model = AddMedicionVM()
   // var del : GetDiagnosis?
   // var diagnosis_id = 0

    var diagnosisData : DiagnosisModelClass?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        showDatePicker()
        datePicker.minimumDate = todaysDate
        self.txtaddmedcount.text = "\(medDataArray.count)"
    }
//    func seletedDiagnosis(diagnosis_id : Int){
//        self.diagnosis_id = diagnosis_id
//    }
    @IBAction func backbtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MedicionVC") as! MedicionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func addMedBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddMedVC") as! AddMedVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func createnewBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDiagnisVC") as! AddDiagnisVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        AddMedData()
        medDataArray.removeAll()
    }
    @IBAction func selectdiganosisBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectDiganosisVC") as! SelectDiganosisVC
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
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
          
        dateLbl.inputAccessoryView = toolbar
        dateLbl.inputView = datePicker

        }
    @objc func donedatePicker(){

      let formatter = DateFormatter()
      formatter.dateFormat = "MM/yyyy"
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        datePicker.minimumDate = todaysDate
        dateLbl.text = formatter.string(from: datePicker.date)
      self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }
    
    func AddMedData(){
        if dateLbl?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.date)
        }else if doctorAdviceLbl?.isEmptyy() == true {
            showToast(message: CustomeAlertMsg.doctoradvice)
        }else{
            LoaderClass.shared.loadAnimation()
            var addMedParams = [String:Any]()
            addMedParams[Param.meddate] = self.dateLbl?.text ?? ""
            addMedParams[Param.meddoctoradvice] = self.doctorAdviceLbl?.text ?? ""
            addMedParams[Param.diagnosisid] =  self.diagnosisData?.diagnosis_id ?? 0
            addMedParams[Param.medicinejsondata] = medDataArray
            
            self.model.callApiaddmedicion(param: addMedParams)
        }
    }
    
}
extension AddMedicionVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        let vc = storyboard?.instantiateViewController(withIdentifier: "MedicionVC") as! MedicionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
        showToast(message: msg)
    }
}

extension AddMedicionVC:GetDiagnosis{
    func seletedDiagnosis(diagnosisData: DiagnosisModelClass) {
        self.diagnosisData = diagnosisData
        self.lblSelectHere.text = self.diagnosisData?.reason_name ?? ""
      
    }
}
