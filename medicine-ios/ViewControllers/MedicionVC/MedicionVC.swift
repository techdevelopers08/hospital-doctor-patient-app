//
//  MedicionVC.swift
//  medicine-ios
//
//  Created by MAC on 07/05/21.
//

import UIKit
import IBAnimatable
class MedicionVC: UIViewController {
    @IBOutlet weak var medicionTV: UITableView!
    @IBOutlet weak var medicionCountLbl: UILabel!
//    @IBOutlet weak var filterView: AnimatableView!
    var medicionDataCount: medicionModelClass?
    var model = MedicionVM()
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.model.hitApimedicionlist()
        medicionTV.reloadData()
//        filterView.isHidden = true
       
        self.medicionTV.delegate = self
        self.medicionTV.dataSource = self
        self.medicionTV.register(UINib.init(nibName:"DiagnosisTVCell" , bundle: nil), forCellReuseIdentifier: "DiagnosisTVCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.model.hitApimedicionlist()
    }
    
    @IBAction func backbtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addMedicionBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddMedicionVC") as! AddMedicionVC
                    self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func filterBtn(_ sender: Any) {
//        if filterView.isHidden == true{
//            filterView.isHidden = false
//        }else{
//            filterView.isHidden = true
//        }
        
    }
    
}
extension MedicionVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicionDataCount?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiagnosisTVCell", for: indexPath) as! DiagnosisTVCell
        cell.diagnosisName.text = medicionDataCount?[indexPath.row]?.reason_name ?? ""
        cell.diagnosisType.text = "\(medicionDataCount?[indexPath.row]?.total_med ?? 0)Medicion"
        cell.date.text = medicionDataCount?[indexPath.row]?.med_date ?? ""
        let url = URL(string: imageBaseUrl + (medicionDataCount?[indexPath.row]?.diagnosis_image ?? "" ))
        cell.diganosisImg.sd_setImage(with: url , placeholderImage:#imageLiteral(resourceName: "stethoscope"))
        cell.editView.isHidden = true
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "MedicionDetailVC") as! MedicionDetailVC
        vc.index = indexPath.row
        vc.medicationsid = medicionDataCount?[indexPath.row]?.medications_id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func editBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddsosContactsVC") as! AddsosContactsVC
//        vc.isEdit = true
//        vc.sosModel = medicionDataCount!![sender.tag]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func deleteBtn(_ sender: UIButton){
        self.selectedIndex = sender.tag
        self.model.hitDeleteMedicion(medicionid: medicionDataCount?[sender.tag]?.medications_id ?? 0)
        self.medicionTV.reloadData()
}
}
extension MedicionVC: ResponseProtocol{

    func onSucsses(msg: String, response: [String : Any]) {
        LoaderClass.shared.stopAnimation()
        print(response)
        if msg == "Delete Data"{
            self.medicionDataCount?.remove(at: selectedIndex)
            medicionTV.reloadData()
        }else{
        do {
            let jsondata = try JSONSerialization.data(withJSONObject: response["body"] ?? [] , options: .prettyPrinted)
            let encodedJson = try JSONDecoder().decode(medicionModelClass.self, from: jsondata)
            self.medicionDataCount = encodedJson
            self.medicionCountLbl.text = "\(medicionDataCount?.count ?? 0)"

            self.medicionTV.reloadData()

        }catch {

        }
    }
    }

    func onFailure(msg: String) {
        LoaderClass.shared.stopAnimation()
        print(msg)
        showToast(message: msg)
    }
}
