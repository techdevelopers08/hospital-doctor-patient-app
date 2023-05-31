//
//  ViewControllerHelperClass.swift
//  WorkPlace
//
//  Created by tech on 18/02/21.
//

import Foundation
import UIKit

struct StoryboardName {
 
    static let Main   = "Main"
    static let Admin  = "Admin"
}


enum ViewControllerType : String{
    
    case LoginVC
    case HomeVC
}

class ViewControllerHelper: NSObject {
    
    // This is used to retirve view controller and intents to reutilize the common code.
    
    class func getViewController(ofType viewControllerType: ViewControllerType,storyboardName :String) -> UIViewController {
        var viewController: UIViewController?
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: viewControllerType.rawValue)
        if let vc = viewController {
            return vc
        } else {
            return UIViewController()
        }
    }
}

