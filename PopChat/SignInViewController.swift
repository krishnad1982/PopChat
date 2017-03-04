//
//  SignInViewController.swift
//  PopChat
//
//  Created by KR DEVARAJAN NAIR on 2017/02/28.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    let utility=Utility()
    
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
                self.utility.generateAlert(title: "Information", message: "User not found, but we created it", actiontitle: "Login again!",page: self)
                
                FIRAuth.auth()?.createUser(withEmail: self.txtUsername.text!, password: self.txtPassword.text!, completion: { (user, error) in
                    if error != nil{
                        self.utility.generateAlert(title: "Information", message: error.debugDescription, actiontitle: "Ok",page: self)
                        //place code here
                    }
                })
            }else{
                let users = FIRDatabase.database().reference().child("users")
                users.child(user!.uid).child("email").setValue(self.txtUsername.text)
                self.performSegue(withIdentifier: "signinSegue", sender: nil)
            }
        })
    }
    
    
    
}

