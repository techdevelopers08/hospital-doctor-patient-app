//
//  CifiximeweekVC.swift
//  medicine-ios
//
//  Created by MAC on 17/05/21.
//

import UIKit

class CifiximeweekVC: UIViewController {
    @IBOutlet weak var cifiximeweekTV: UITableView!
    var week  = ["Sunday","Monday","Tuesday","Wenesday","Thursday","Friday","Saturday"]
    var selectedIndex = [Int]()
    var serverValue = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.cifiximeweekTV.delegate = self
        self.cifiximeweekTV.dataSource = self
        cifiximeweekTV.register(UINib(nibName: "CifiximeweekTVCell", bundle: nil), forCellReuseIdentifier: "CifiximeweekTVCell")
    }
    @IBAction func backbtn(_ sender: Any) {
         
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtn(_ sender: Any) {

        if serverValue.count == 0{
            Alert.showSimple("Select weekday")
        }else{
        let vc = storyboard?.instantiateViewController(withIdentifier: "CifiximetimeVC") as! CifiximetimeVC
        medData["on_which_days_do_u_take_this_med"] = self.serverValue.joined(separator:",")
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    }
}
extension CifiximeweekVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return week.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cifiximeweekTV.dequeueReusableCell(withIdentifier: "CifiximeweekTVCell", for: indexPath) as! CifiximeweekTVCell
        cell.weekLbl.text = week[indexPath.row]
        if self.selectedIndex.contains(indexPath.row){
            cell.checkBoxBtn.isSelected = true
        }else{
            cell.checkBoxBtn.isSelected = false
        }
        if cell.checkBoxBtn.imageView?.image == UIImage(named: "uncheck"){
            showToast(message: CustomeAlertMsg.checkBox)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height
        return height / CGFloat(week.count)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if self.selectedIndex.contains(indexPath.row){
            if let index = self.selectedIndex.firstIndex(of: indexPath.row) {
                self.selectedIndex.remove(at: index)
            }
        }else{
            self.selectedIndex.append(indexPath.row)
        }
        
        if self.serverValue.contains("\(indexPath.row + 1)"){
            if let index = self.serverValue.firstIndex(of: "\(indexPath.row + 1)") {
                self.serverValue.remove(at: index)
            }
        }else{
            self.serverValue.append("\(indexPath.row + 1)")
        }
       
        self.cifiximeweekTV.reloadData()
    }
      
}
