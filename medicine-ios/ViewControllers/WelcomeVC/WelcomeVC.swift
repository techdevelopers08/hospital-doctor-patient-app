//
//  WelcomeVC.swift
//  medicine-ios
//
//  Created by MAC on 06/05/21.
//

import UIKit
import IBAnimatable

class WelcomeVC: UIViewController {

    @IBOutlet weak var backBtn: AnimatableButton!
    @IBOutlet weak var welcomeCV: UICollectionView!
    var welcomeimg = [ #imageLiteral(resourceName: "Group 147"),#imageLiteral(resourceName: "Group 151"),#imageLiteral(resourceName: "Group 152"),#imageLiteral(resourceName: "Group 153")]
    var welcomelbl = ["Save Your Physical examination records, Generating provisional and differential diagnosis reports & many more","Will Save include all the records of the medicines taken in past and present & many more.","This will save the details for emergency contacts details when need press the SOS","Using QR code, the doctor in emergency department can scan QR in their mobile phone and will get all the details of the patient"]
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backBtn.isHidden = true
        self.welcomeCV.delegate = self
        self.welcomeCV.dataSource = self
       
        self.welcomeCV.register(UINib.init(nibName:"WelcomeCVCell" , bundle: nil), forCellWithReuseIdentifier: "WelcomeCVCell")
    }
    override func viewDidLayoutSubviews() {
           setUpCollectionView()
       }
       fileprivate func setUpCollectionView() {
           let collectionFlowLayout = UICollectionViewFlowLayout()
           collectionFlowLayout.scrollDirection = .horizontal
           collectionFlowLayout.itemSize = CGSize(width: welcomeCV.frame.size.width , height: welcomeCV.frame.size.height )
           collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
           collectionFlowLayout.minimumInteritemSpacing = 0
           collectionFlowLayout.minimumLineSpacing = 0
   //                layout.scrollDirection = .horizontal
        welcomeCV!.collectionViewLayout = collectionFlowLayout
        welcomeCV.setCollectionViewLayout(collectionFlowLayout, animated: false)
        welcomeCV.delegate = self
        welcomeCV.dataSource = self
       }
    @IBAction func nextBtn(_ sender: Any) {
        
        let collectionBounds = self.welcomeCV.bounds
              let contentOffset = CGFloat(floor(self.welcomeCV.contentOffset.x + collectionBounds.size.width))
              self.moveCollectionToFrame(contentOffset: contentOffset)
        if index == 3{
            let vc = storyboard?.instantiateViewController(withIdentifier: "WelcomeHomeVC") as! WelcomeHomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        welcomeCV.reloadData()

           
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
        
        let collectionBounds = self.welcomeCV.bounds
              let contentOffset = CGFloat(floor(self.welcomeCV.contentOffset.x - collectionBounds.size.width))
              self.moveCollectionToFrame(contentOffset: contentOffset)
        welcomeCV.reloadData()
        
    }
    
}
extension WelcomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.index = indexPath.row
        let cell = welcomeCV.dequeueReusableCell(withReuseIdentifier: "WelcomeCVCell", for: indexPath ) as! WelcomeCVCell
        
        cell.welcomelbl.text = welcomelbl[indexPath.item]
        cell.welcomeimage.image = welcomeimg[indexPath.item]
        if indexPath.item == 0{
        self.backBtn.isHidden = true
        }else{
            self.backBtn.isHidden = false
        }
    
        return cell
    }

    func moveCollectionToFrame(contentOffset : CGFloat) {
           let frame: CGRect = CGRect(x : contentOffset ,y : self.welcomeCV.contentOffset.y ,width : self.welcomeCV.frame.width,height : self.welcomeCV.frame.height)
           self.welcomeCV.scrollRectToVisible(frame, animated: false)
        
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: welcomeCV.frame.size.width, height: welcomeCV.frame.size.height)
       }
    

}
