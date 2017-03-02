//
//  SignInViewController.swift
//  PopChat
//
//  Created by KR DEVARAJAN NAIR on 2017/02/28.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: AnyObject) {
        FIRAuth.auth()?.signIn(withEmail: txtUsername.text!, password: txtPassword.text!, completion: { (user, error) in
            if error != nil{
                //alert code
                let alert=UIAlertController(title: "Information", message: "\(error.debugDescription)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                //alert code end here
                FIRAuth.auth()?.createUser(withEmail: self.txtUsername.text!, password: self.txtPassword.text!, completion: { (user, error) in
                    if error != nil{
                        
                        //place code here
                    }
                })
            }else{
                self.performSegue(withIdentifier: "signinSegue", sender: nil)
            }
        })
    }
    
}

