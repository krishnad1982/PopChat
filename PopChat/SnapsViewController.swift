//
//  SnapsViewController.swift
//  PopChat
//
//  Created by KR DEVARAJAN NAIR on 2017/03/02.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SnapsViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogout(_ sender: AnyObject) {

        dismiss(animated: true, completion: nil)
    }
    
}
