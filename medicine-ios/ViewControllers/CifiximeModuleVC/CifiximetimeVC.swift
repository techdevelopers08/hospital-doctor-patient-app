//
//  CifiximetimeVC.swift
//  medicine-ios
//
//  Created by MAC on 17/05/21.
//

import UIKit

class CifiximetimeVC: UIViewController {
    
    @IBOutlet weak var cifixmetimeTV: UITableView!
    var time  = ["Morning","Noon","Evening","Night"]
    var selectedIndex = [Int]()
    var serverValue = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.cifixmetimeTV.delegate = self
        self.cifixmetimeTV.dataSource = self
        cifixmetimeTV.register(UINib(nibName: "CifiximeweekTVCell", bundle: nil), forCellReuseIdentifier: "CifiximeweekTVCell")
    }
    

    @IBAction func backbtn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextBtn(_ sender: Any) {
        if serverValue.count == 0{
            Alert.showSimple("Select day Time")
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CifiximePillVC") as! CifiximePillVC
                  medData["med_day"] = self.serverValue.joined(separator:",")
                  medData["on_which_days_do_u_take_this_med"] = self.serverValue.joined(separator:",")
                  self.navigationController?.pushViewController(vc, animated: true)
        }
      
    }
}
extension CifiximetimeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cifixmetimeTV.dequeueReusableCell(withIdentifier: "CifiximeweekTVCell", for: indexPath) as! CifiximeweekTVCell
        cell.weekLbl.text = time[indexPath.row]
        if self.selectedIndex.contains(indexPath.row){
            cell.checkBoxBtn.isSelected = true
        }else{
            cell.checkBoxBtn.isSelected = false
        }
        return cell
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
        self.cifixmetimeTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height
        return height / 7

}
}
