//
//  Helper.swift
//  Collecting_Arts
//
//  Created by Bhoomi Kathiriya on 27/06/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import Foundation
import  UIKit
import MBProgressHUD

let kAppName             = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String

public class Helper
{
    static let sharedInstance = Helper()
    var appDelegate : AppDelegate?
    
    
    func checkIntenetConnection() -> Bool
    {
        if Reachability.isConnectedToNetwork()
        {
            print("Internet Connection Available!")
            return true
        }
        else
        {
            print("Internet Connection not Available!")
            self.finishLoading()
            return false
            
        }
        
    }
    
    
    func startLoading() {
        if #available(iOS 13, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate)
            {
                MBProgressHUD.showAdded(to: (sd.window?.rootViewController?.view)!, animated: true)
            }
        }
        else
        {
            MBProgressHUD.showAdded(to: (APPDELEGATE.window?.rootViewController?.view)!, animated: true)
        }

    }

    func finishLoading() {
        if #available(iOS 13, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate)
            {
          
                MBProgressHUD.hide(for: (sd.window?.rootViewController?.view)!, animated: false)                       }
        }
        else
        {
            MBProgressHUD.hide(for: (APPDELEGATE.window?.rootViewController?.view)!, animated: false)                   }

    }


}


extension UIViewController
{
    typealias AlertCompletion = (Int) -> ()


    func showAlertWithCompletion(pTitle : String? ,pStrMessage : String , buttons : [String]? = ["Ok"], completionBlock: AlertCompletion?){
        
        let alertController = UIAlertController(title: pTitle, message: pStrMessage, preferredStyle: .alert)
        if let aButtons = buttons{
            for (index,btn) in aButtons.enumerated(){
                
                let btnAction = UIAlertAction(title: btn, style: .default, handler: { (action) in
                    if (completionBlock != nil) {
                        completionBlock!(index)
                    }
                })
                alertController.addAction(btnAction)
                
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }

}
