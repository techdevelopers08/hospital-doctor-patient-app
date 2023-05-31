//
//  AddSurgeryCell.swift
//  medicine-ios
//
//  Created by MAC on 07/05/21.
//

import UIKit
import IBAnimatable
class AddSurgeryCell: UICollectionViewCell {

    @IBOutlet weak var addImage: UIPhotosButton!
    @IBOutlet weak var mainImage: AnimatableImageView!
    @IBOutlet weak var showdataView: UIView!
    @IBOutlet weak var adddataview: UIView!
    @IBOutlet weak var imagecount: UILabel!
    
    
    
    var index = IndexPath()
    var callBackUploadImage : ((IndexPath) -> Void)?

    func configure(indexPath:IndexPath){
        self.index = indexPath
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        showdataView.isHidden = false
        adddataview.isHidden = true
        
    }
    @IBAction func uploadImage(_ sender: UIButton){
        callBackUploadImage?(self.index)
    }
}
