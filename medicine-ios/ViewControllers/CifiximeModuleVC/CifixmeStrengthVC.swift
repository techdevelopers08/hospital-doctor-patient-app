//
//  CifixmeStrengthVC.swift
//  medicine-ios
//
//  Created by MAC on 18/05/21.
//

import UIKit

class CifixmeStrengthVC: UIViewController {
    @IBOutlet weak var showdataTF: UITextField!
    @IBOutlet weak var txtMedStregth: UITextField!
    @IBOutlet weak var dropdownTV: UITableView!
    var data = ["Pill","Solution","Injection","Powder","Drops","Inhler","Other"]
    var addmedDataCount: addmedData?
    var model = AddMedVM()
    var medId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.callApimedicinestrength()
//        let mother = self.addmedDataCount ?? []
//        let motherData = mother.map({$0. ?? ""})
        self.dropdownTV.reloadData()
        self.model.delegate = self
        dropdownTV.isHidden = true
        dropdownTV.delegate = self
        dropdownTV.dataSource = self
        dropdownTV.register(UINib(nibName: "SelectdataTVCell", bundle: nil), forCellReuseIdentifier: "SelectdataTVCell")
    }
    
    @IBAction func dropDown(_ sender: Any) {
        if  dropdownTV.isHidden == true{
       
            dropdownTV.isHidden = false
        }else{
          
            dropdownTV.isHidden = true
        }
    }
    @IBAction func backbtn(_ sender: Any) {
      
        self.navigationController?.popViewController(animated: true)
      
        }
    
    @IBAction func nextBtn(_ sender: Any) {
        if self.txtMedStregth.text?.trimmingCharacters(in: .whitespaces).isEmpty == true || self.showdataTF.text?.trimmingCharacters(in: .whitespaces).isEmpty == true {
            Alert.showSimple("Please Enter Requried Data")
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CifixmeselectmedVC") as! CifixmeselectmedVC
            medData["what_strength_is_the_med"] = self.txtMedStregth.text ?? ""
            medData["medicine_strength_id"] = "\(medId)"
           
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
   
}
extension CifixmeStrengthVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addmedDataCount??.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropdownTV.dequeueReusableCell(withIdentifier: "SelectdataTVCell", for: indexPath) as! SelectdataTVCell
//        cell.mainLbl.text = data[indexPath.row]
        cell.mainLbl.text = addmedDataCount??[indexPath.row].med_strength_name ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = dropdownTV.frame.height
        return height / CGFloat(addmedDataCount??.count ?? 0)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectionData = addmedDataCount??[indexPath.row].med_strength_name ?? ""
        showdataTF.text = selectionData
        self.medId = addmedDataCount??[indexPath.row].med_strength_id ?? 0
        self.dropdownTV.isHidden = true
       
    }
}
extension CifixmeStrengthVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        do {
            
            let jsondata = try JSONSerialization.data(withJSONObject: response["body"] ?? [] , options: .prettyPrinted)
            let encodedJson = try JSONDecoder().decode(addmedData.self, from: jsondata)
            self.addmedDataCount = encodedJson
//            self.model.callApimedicinestrength()
            self.dropdownTV.reloadData()
            
        }catch {
            
        }
    }
    
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
//        showToast(message: msg)
    }
}
