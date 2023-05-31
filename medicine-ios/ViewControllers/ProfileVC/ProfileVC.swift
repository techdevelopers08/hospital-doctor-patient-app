//
//  ProfileVC.swift
//  medicine-ios
//
//  Created by MAC on 07/05/21.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var profileTV: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailTF: UILabel!
    @IBOutlet weak var nameTF: UILabel!
    var mainImage = [ #imageLiteral(resourceName: "info"),#imageLiteral(resourceName: "lock (1)"),#imageLiteral(resourceName: "help"),#imageLiteral(resourceName: "privacy"),#imageLiteral(resourceName: "arrow")]
    var mainLbl = ["About me","Change Password","Help & Support","Privacy Policies","Logout"]
    var model = HomeVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileTV.delegate = self
        self.profileTV.dataSource = self
        self.profileTV.register(UINib.init(nibName:"ProfileTVCell" , bundle: nil), forCellReuseIdentifier: "ProfileTVCell")
        self.model.delegate = self
        model.hitApimedata()
        setdata()
    }
    override func viewWillAppear(_ animated: Bool) {
        model.hitApimedata()
            setdata()
    }
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    func setdata(){
        self.emailTF.text =  Cookies.userInfo()?.email ?? ""
        self.nameTF.text = Cookies.userInfo()?.name ?? ""
        let url = URL(string: imageBaseUrl + (Cookies.userInfo()?.profileimage ?? ""))
        self.profileImage.sd_setImage(with: url , placeholderImage:#imageLiteral(resourceName: "color line"))
    }

}
extension ProfileVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTVCell", for: indexPath) as! ProfileTVCell
        cell.logomain.image = mainImage[indexPath.item]
        cell.lablmain.text = mainLbl[indexPath.item]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  indexPath.row == 0{
         let vc = storyboard?.instantiateViewController(withIdentifier: "AboutmeVC") as! AboutmeVC
         self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true,completion: nil)
        }else if indexPath.row == 2{
            let vc = storyboard?.instantiateViewController(withIdentifier: "Help_SupportVC") as! Help_SupportVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
            let vc = storyboard?.instantiateViewController(withIdentifier: "PrivacyPoloiciesVC") as! PrivacyPoloiciesVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4{
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
    }
}
}
extension ProfileVC: ResponseProtocol{
    func onSucsses(msg: String, response: [String : Any]) {
    LoaderClass.shared.stopAnimation()
    print(response)

            let userDict = MeData(dict: response)
            Cookies.userInfoSave(dict: userDict.body?.first?.serverData)
            print(Cookies.userInfo()?.id ?? 0)
//            showToast(message: "Updated Successfully")
            self.setdata()
            
}

func onFailure(msg: String) {
    LoaderClass.shared.stopAnimation()
    print(msg)
    showToast(message: msg)
}
}
