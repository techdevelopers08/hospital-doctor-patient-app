//
//  DiagnosisTVCell.swift
//  medicine-ios
//
//  Created by MAC on 06/05/21.
//

import UIKit

class DiagnosisTVCell: UITableViewCell {

    @IBOutlet weak var imageweidth: NSLayoutConstraint!
    @IBOutlet weak var imagetop: NSLayoutConstraint!
    @IBOutlet weak var calenderWidth: NSLayoutConstraint!
    @IBOutlet weak var clanderimg: UIImageView!
    @IBOutlet weak var diagnosisName: UILabel!
    @IBOutlet weak var diagnosisType: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var diganosisImg: UIImageView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    @IBAction func menuBtn(_ sender: Any) {
        if menuView.isHidden == true{
            menuView.isHidden = false
        }else{
            menuView.isHidden = true
        }
    }
    
}
