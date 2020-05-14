//
//  ViewController.swift
//  EuromsgTest
//
//  Created by Egemen on 29.04.2020.
//  Copyright © 2020 Egemen. All rights reserved.
//

import UIKit
import Euro_IOS

class ViewController: UIViewController {
    
    @IBOutlet weak var keyID: UITextField!
    @IBOutlet weak var eMail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func updateUI(_ notification: Notification?){
        print("updateUI")
        
        textField.text = ""
        textField.text += "User Info"
        textField.text += "\n"
        textField.text += "\n"
        
        if let ui3 = EuroManager.userInfo(){
            for (key, value) in ui3 {
                textField.text += "Key: "
                textField.text += key as! String
                textField.text += "\n"
                textField.text += "Value: "
                textField.text += String(describing: value)
                textField.text += "\n"
            }
        }
    }
    
    @IBOutlet weak var textField: UITextView!
    
    @IBAction func subscribe(_ sender: Any) {
        EuroManager.sharedManager("EuromsgTest")?.setUserKey(self.keyID.text!)
        EuroManager.sharedManager("EuromsgTest")?.setUserEmail(self.eMail.text!)
        EuroManager.sharedManager("EuromsgTest")?.addParams("emailPermit", value: "Y")
        EuroManager.sharedManager("EuromsgTest")?.addParams("gsmPermit", value: "Y")
        EuroManager.sharedManager("EuromsgTest")?.addParams("pushPermit", value: "Y")
        EuroManager.sharedManager("EuromsgTest").synchronize()
    }
    
}

