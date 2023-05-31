//
//  HomeVC.swift
//  medicine-ios
//
//  Created by MAC on 06/05/21.
//

import UIKit
import IBAnimatable

class HomeVC: UIViewController {
    @IBOutlet weak var nameTF: UILabel!
    @IBOutlet weak var emailTF: UILabel!
    @IBOutlet weak var homeCV: UICollectionView!
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var profileImg: AnimatableImageView!
    //    @IBOutlet weak var editBackView: AnimatableView!
    var mainImage = [ #imageLiteral(resourceName: "bacteria"),#imageLiteral(resourceName: "pills"),#imageLiteral(resourceName: "surgery"),#imageLiteral(resourceName: "qr-code"),#imageLiteral(resourceName: "sos"),#imageLiteral(resourceName: "color line")]
    var mainLbl = ["DIAGNOSIS","MEDICATION","SURGERY","YOUR QR CODE","SOS CONTACTS","PROFILE"]
    var homeModelData: homeModelClass?
    var model = HomeVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.homeCV.delegate = self
        self.homeCV.dataSource = self
        backview.isHidden = true
        self.model.delegate = self
        model.hitApimedata()
        setdata()
        let nib = UINib.init(nibName: "HomeCVCell", bundle: nil)
        self.homeCV.register(nib, forCellWithReuseIdentifier: "HomeCVCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        model.hitApimedata()
            setdata()
    }
    
    func setdata(){
        self.emailTF.text =  Cookies.userInfo()?.email ?? ""
        self.nameTF.text = Cookies.userInfo()?.name ?? ""
       
        let url = URL(string: imageBaseUrl + (Cookies.userInfo()?.profileimage ?? ""))
        self.profileImg.sd_setImage(with: url , placeholderImage:#imageLiteral(resourceName: "color line"))
    }
    @IBAction func closeBtn(_ sender: Any) {
        backview.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first
        if touch?.view == self.backview{  backview.isHidden = true }
}
    
    @IBAction func addDiganosisBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDiagnisVC") as! AddDiagnisVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addMedicionBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddMedicionVC") as! AddMedicionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addSurgeryBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddSurgeryVC") as! AddSurgeryVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addSosBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddsosContactsVC") as! AddsosContactsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func scanbarcodeBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ScannerVC") as! ScannerVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        
      
        backview.isHidden = false
//        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
}
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        cell.cellImage.image = mainImage[indexPath.item]
        cell.cellLabel.text = mainLbl[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.homeCV.frame.size.width - 15) / 2
        
        return CGSize(width: width , height: 180)
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0{
            let vc = storyboard?.instantiateViewController(withIdentifier: "DiagnosisVC") as! DiagnosisVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if  indexPath.item == 1{
            let vc = storyboard?.instantiateViewController(withIdentifier: "MedicionVC") as! MedicionVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if  indexPath.item == 2{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SurgeryVC") as! SurgeryVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if  indexPath.item == 3{
            let vc = storyboard?.instantiateViewController(withIdentifier: "BarCodeVC") as! BarCodeVC
//            vc.userID = "\(self.homeModelData?.first?.id ?? 0)"
            vc.userID = "\(Cookies.userInfo()?.id ?? 0)"
            self.navigationController?.pushViewController(vc, animated: true)
        }else if  indexPath.item == 4{
            let vc = storyboard?.instantiateViewController(withIdentifier: "SosContactsVC") as! SosContactsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if  indexPath.item == 5{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
        }
    }
}
extension HomeVC: ResponseProtocol{
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
