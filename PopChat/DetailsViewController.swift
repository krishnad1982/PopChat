//
//  DetailsViewController.swift
//  PopChat
//
//  Created by KR DEVARAJAN NAIR on 2017/03/04.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import SDWebImage

class DetailsViewController: UIViewController {
    
    var snaps=Snap()
    
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.sd_setImage(with: URL(string: snaps.imageUrl))
        lblDescription.text=snaps.description
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser!.uid)!).child("snaps").removeValue()
        
        FIRStorage.storage().reference().child("images").child("\(snaps.uuid).jpg").delete { (error) in
            if error != nil{
                
            }else{
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
