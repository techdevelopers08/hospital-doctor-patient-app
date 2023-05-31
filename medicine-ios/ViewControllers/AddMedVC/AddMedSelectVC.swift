//
//  AddMedSelectVC.swift
//  medicine-ios
//
//  Created by MAC on 18/05/21.
//

import UIKit

class AddMedSelectVC: UIViewController {

    @IBOutlet weak var showdataTF: UITextField!
    @IBOutlet weak var selectdataTV: UITableView!
    @IBOutlet weak var NorecentView: UIView!
    var data = ["Pill","Solution","Injection","Powder","Drops","Inhler","Other"]
    var addmedDataCount: addmedData?
    var model = AddMedVM()
    var model1 = AddMedicionVM()
    var medId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.model1.delegate = self
        self.model.callApimediciontype()
        self.selectdataTV.reloadData()
        selectdataTV.isHidden = true
        selectdataTV.delegate = self
        selectdataTV.dataSource = self
        selectdataTV.register(UINib(nibName: "SelectdataTVCell", bundle: nil), forCellReuseIdentifier: "SelectdataTVCell")
    }
    
    @IBAction func backbtn(_ sender: Any) {
      
        self.navigationController?.popViewController(animated: true)
      
        }
    @IBAction func dropDownBtn(_ sender: Any) {
        self.selectdataTV.reloadData()
        if  selectdataTV.isHidden == true{
        selectdataTV.isHidden = false
        }else{
            selectdataTV.isHidden = true
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        if self.showdataTF.text?.trimmingCharacters(in: .whitespaces).isEmpty == true{
            Alert.showSimple("Please Enter Med Type")
        }else{
        let vc = storyboard?.instantiateViewController(withIdentifier: "CifixmeStrengthVC") as! CifixmeStrengthVC
            medData["medicine_type_id"] = "\(medId)"
            medname = self.showdataTF.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
extension AddMedSelectVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addmedDataCount??.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectdataTV.dequeueReusableCell(withIdentifier: "SelectdataTVCell", for: indexPath) as! SelectdataTVCell
//        cell.mainLbl.text = data[indexPath.row]
        cell.mainLbl.text = addmedDataCount??[indexPath.row].med_type_name ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height
        return height / CGFloat(addmedDataCount??.count ?? 0)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let selectionData = addmedDataCount??[indexPath.row].med_type_name ?? ""
        showdataTF.text = selectionData
        self.medId = addmedDataCount??[indexPath.row].med_type_id ?? 0
        self.selectdataTV.isHidden = true
    }
}
extension AddMedSelectVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        let body = response["body"]
        if  msg == "Done"{
        do {
            let jsondata = try JSONSerialization.data(withJSONObject: body ?? [] , options: .prettyPrinted)
            let encodedJson = try JSONDecoder().decode(addmedData.self, from: jsondata)
            self.addmedDataCount = encodedJson
//            self.model.callApimediciontype()
            self.selectdataTV.reloadData()
            
        }catch {
            
        }
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "CifixmeStrengthVC") as! CifixmeStrengthVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
//        showToast(message: msg)
    }
}
