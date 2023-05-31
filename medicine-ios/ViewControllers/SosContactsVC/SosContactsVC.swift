//
//  SosContactsVC.swift
//  medicine-ios
//
//  Created by MAC on 07/05/21.
//

import UIKit

class SosContactsVC: UIViewController {
    @IBOutlet weak var soscontactTV: UITableView!
    @IBOutlet weak var soscontactCountLbl: UILabel!
    
    var sosModelClassData: sosModelClass?
    var model = SosContactVM()
    var contactid = 0
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.hitApicontactList()
        self.model.delegate = self
        self.soscontactTV.delegate = self
        self.soscontactTV.dataSource = self
        self.soscontactTV.register(UINib.init(nibName:"DiagnosisTVCell" , bundle: nil), forCellReuseIdentifier: "DiagnosisTVCell")
        self.soscontactTV.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.model.hitApicontactList()
    }
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addDiagonisBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddsosContactsVC") as! AddsosContactsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension SosContactsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sosModelClassData??.count ?? 0
//           return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiagnosisTVCell", for: indexPath) as! DiagnosisTVCell
        cell.clanderimg.isHidden = true
        cell.calenderWidth.constant = 0
        cell.diganosisImg.image = #imageLiteral(resourceName: "call")
        cell.imagetop.constant = 50
        cell.imageweidth.constant = 50
        
        cell.diagnosisName.text = sosModelClassData??[indexPath.row].sc_name ?? ""
        cell.diagnosisType.text = sosModelClassData??[indexPath.row].sc_relation ?? ""
        cell.date.text = "+91" + (sosModelClassData??[indexPath.row].sc_number ?? "")
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(editBtn(_:)), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtn(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    @objc func editBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddsosContactsVC") as! AddsosContactsVC
        vc.isEdit = true
        vc.sosModel = sosModelClassData!![sender.tag]
//        soscontactTV.reloadData()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func deleteBtn(_ sender: UIButton){
        self.selectedIndex = sender.tag
        self.model.hitDeleteSosContact(contactid: sosModelClassData??[sender.tag].contact_id ?? 0)
        soscontactTV.reloadData()
    }
}
extension SosContactsVC: ResponseProtocol{
func onSucsses(msg: String, response: [String : Any]) {
    LoaderClass.shared.stopAnimation()
    print(response)
    if msg == "Delete Data"{
        self.sosModelClassData??.remove(at: selectedIndex)
        soscontactTV.reloadData()
    }else{
    let body = response["body"]
//    if msg == "contactlist"{
        do {
            let jsondata = try JSONSerialization.data(withJSONObject: body ?? [] , options: .prettyPrinted)
            let encodedJson = try JSONDecoder().decode(sosModelClass.self, from: jsondata)
            self.sosModelClassData = encodedJson
            self.soscontactCountLbl.text = "\(sosModelClassData??.count ?? 0)"
            self.soscontactTV.reloadData()
        }catch {
            
        }
    }
}
//    }
func onFailure(msg: String) {
    LoaderClass.shared.stopAnimation()
    print(msg)
    showToast(message: msg)
}
}
