//
//  DiagnosisVC.swift
//  medicine-ios
//
//  Created by MAC on 06/05/21.
//

import UIKit
import IBAnimatable
class DiagnosisVC: UIViewController {
    @IBOutlet weak var filterView: AnimatableView!
    @IBOutlet weak var diagnosisTV: UITableView!
    @IBOutlet weak var diganosisCountLbl: UILabel!
   
    var model = DiagnosisListVM()
    var diagnosisDataCount: diagnosisModelClass?
    var selectedIndex = 0
    var b: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.isHidden = true
        self.model.delegate = self
        self.model.hitDiagnosisListApi(list_type: 1)
//        self.diganosisCountLbl.text = "\(diagnosisDataCount?.count ?? 0)"
        self.diagnosisTV.reloadData()
        self.diagnosisTV.delegate = self
        self.diagnosisTV.dataSource = self
        self.diagnosisTV.register(UINib.init(nibName:"DiagnosisTVCell" , bundle: nil), forCellReuseIdentifier: "DiagnosisTVCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.model.hitDiagnosisListApi(list_type: 1)
    }
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addDiagonisBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDiagnisVC") as! AddDiagnisVC
                    self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func filterBtn(_ sender: Any) {
        if filterView.isHidden == true{
            filterView.isHidden = false
        }else{
            filterView.isHidden = true
        }
        
    }
    
    @IBAction func allBtn(_ sender: Any) {
        self.model.hitDiagnosisListApi(list_type: 1)
        filterView.isHidden = true
    }
    @IBAction func opdBtn(_ sender: Any) {
        self.model.hitDiagnosisListApi(list_type: 2)
        filterView.isHidden = true
    }
    @IBAction func hosptilizationBtn(_ sender: Any) {
        self.model.hitDiagnosisListApi(list_type: 3)
        filterView.isHidden = true
    }
    @IBAction func newAddedBtn(_ sender: Any) {
        self.model.hitDiagnosisListApi(list_type: 4)
        filterView.isHidden = true
    }
    @IBAction func oldAddedBtn(_ sender: Any) {
        self.model.hitDiagnosisListApi(list_type: 5)
        filterView.isHidden = true
    }
   
}
extension DiagnosisVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diagnosisDataCount??.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiagnosisTVCell", for: indexPath) as! DiagnosisTVCell
        cell.diagnosisName.text = diagnosisDataCount??[indexPath.row].reason_name ?? ""
        cell.diagnosisType.text = diagnosisDataCount??[indexPath.row].diagnosis_type ?? ""
        cell.date.text = diagnosisDataCount??[indexPath.row].from_date ?? ""
        let url = URL(string: imageBaseUrl + (diagnosisDataCount??[indexPath.row].diagnosis_image ?? "" ))
        cell.diganosisImg.sd_setImage(with: url , placeholderImage:#imageLiteral(resourceName: "stethoscope"))
        cell.editBtn.addTarget(self, action: #selector(editBtn(_:)), for: .touchUpInside)
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtn(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DiagnosisDetailVC") as! DiagnosisDetailVC
        vc.index = indexPath.row
        vc.diagnosisid = diagnosisDataCount??[indexPath.row].diagnosis_id ?? 0
        diagnosisTV.reloadData()
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    @objc func editBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDiagnisVC") as! AddDiagnisVC
        vc.isEdit = true
        vc.diganosisModel = diagnosisDataCount!![sender.tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func deleteBtn(_ sender: UIButton){
        self.selectedIndex = sender.tag
        self.model.hitDeleteDiganosis(diagnosisid: diagnosisDataCount??[sender.tag].diagnosis_id ?? 0)
        diagnosisTV.reloadData()
    }
}
extension DiagnosisVC: ResponseProtocol{
    
    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        if msg == "Delete Data"{
            self.diagnosisDataCount??.remove(at: selectedIndex)
            diagnosisTV.reloadData()
        }else{
        let body = response["body"]
    if  msg == "DiagnosisList Data"{
            do {
                let jsondata = try JSONSerialization.data(withJSONObject: body ?? [], options: .prettyPrinted)
                let encodedJson = try JSONDecoder().decode(diagnosisModelClass.self, from: jsondata)
                self.diagnosisDataCount = encodedJson
                self.diganosisCountLbl.text = "\(diagnosisDataCount??.count ?? 0)"
                self.diagnosisTV.reloadData()

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



