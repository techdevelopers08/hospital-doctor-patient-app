//
//  UIViewController_Extention.swift
//  WorkPlace
//
//  Created by tech on 02/03/21.
//

import Foundation
import UIKit
import AVKit
//MARK: - UIAlert action sheet title
enum ActionSheetLabel: String {
  case playVideo = "Play Video"
  case recodeVideo = "Record Video"
  case cancel = "Cancel"
}

extension UIViewController{
    
    typealias AlertAction = () -> ()
    typealias AlertButtonAction = (ActionSheetLabel, AlertAction)
    
    func showActionSheetWithCancel(titleAndAction: [AlertButtonAction]) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for value in titleAndAction {
            actionSheet.addAction(UIAlertAction(title: value.0.rawValue, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                value.1()
                
            }))
        }
        actionSheet.addAction(UIAlertAction(title: ActionSheetLabel.cancel.rawValue, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.player = player
        
        self.present(vc, animated: true) { vc.player?.play() }
    }
    
    func deleteAllLocalSaveValue(){
        UserDefaults.standard.setValue("", forKey: UserDefaultKey.kLoginSwitch)
        UserDefaults.standard.setValue("", forKey: UserDefaultKey.kUserID)
        UserDefaults.standard.setValue("", forKey: UserDefaultKey.kUserToken)
        UserDefaults.standard.setValue("", forKey: UserDefaultKey.kUserRefreshToken)
        UserDefaults.standard.setValue("", forKey: UserDefaultKey.kUserName)
        UserDefaults.standard.setValue("", forKey: UserDefaultKey.kUserMobile)
        UserDefaults.standard.setValue("", forKey: UserDefaultKey.kUserEmail)
        UserDefaults.standard.setValue("", forKey: UserDefaultKey.kUserMobCode)
        UserDefaults.standard.setValue("", forKey: UserDefaultKey.kUserRole)
    }
}

