//
//  SurgeryVC.swift
//  medicine-ios
//
//  Created by MAC on 07/05/21.
//

import UIKit
import IBAnimatable

class SurgeryVC: UIViewController {
    @IBOutlet weak var surgeryTV: UITableView!
    @IBOutlet weak var surgeryCountLbl: UILabel!
    
    @IBOutlet weak var filterView: AnimatableView!
    var model = SurgeryListVM()
    var surgeryDataCount: surgerydataModule?
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.model.hitSurgeryListApi(listtype: 1)
        filterView.isHidden = true
        self.surgeryTV.delegate = self
        self.surgeryTV.dataSource = self
        self.surgeryTV.register(UINib.init(nibName:"SurgeryTVCell" , bundle: nil), forCellReuseIdentifier: "SurgeryTVCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.model.hitSurgeryListApi(listtype: 1)
    }
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addSurgery(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddSurgeryVC") as! AddSurgeryVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func filterBtn(_ sender: Any) {
        if filterView.isHidden == true{
            filterView.isHidden = false
        }else{
            filterView.isHidden = true
        }
        
    }
    @IBAction func newAddedBtn(_ sender: Any) {
        self.model.hitSurgeryListApi(listtype: 1)
        filterView.isHidden = true
       
    }
    @IBAction func oldAddedBtn(_ sender: Any) {
        self.model.hitSurgeryListApi(listtype: 2)
        filterView.isHidden = true
    }
}
extension SurgeryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surgeryDataCount?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SurgeryTVCell", for: indexPath) as! SurgeryTVCell
        cell.surgeryName.text = surgeryDataCount?[indexPath.row]?.reason_of_surgery ?? ""
        cell.surgeryType.text = surgeryDataCount?[indexPath.row]?.type_of_surgery ?? ""
        cell.surgerydate.text = surgeryDataCount?[indexPath.row]?.surgery_date ?? ""
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "SurgeryDetailVC") as! SurgeryDetailVC
        vc.index = indexPath.row
        vc.surgeryid = surgeryDataCount?[indexPath.row]?.surgery_id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func editBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddSurgeryVC") as! AddSurgeryVC
        vc.isEdit = true
        vc.modelsurgery = surgeryDataCount![sender.tag]!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func deleteBtn(_ sender: UIButton){
        self.selectedIndex = sender.tag
        self.model.hitDeleteSurgery(surgeryid: surgeryDataCount?[sender.tag]?.surgery_id ?? 0)
        surgeryTV.reloadData()
    }
}
extension SurgeryVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        if msg == "Delete Data"{
            self.surgeryDataCount?.remove(at: selectedIndex)
            surgeryTV.reloadData()
        }else{
        let body = response["body"]
    if  msg == "SurgeryList Data"{
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: body ?? [], options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(surgerydataModule.self, from: jsondata)
                self.surgeryDataCount = encodedJson
                self.surgeryCountLbl.text = "\(surgeryDataCount?.count ?? 0)"
                self.surgeryTV.reloadData()
                
            }catch {
            }
        }
        }
    }
    
    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)

        showToast(message: msg)
    }
}
