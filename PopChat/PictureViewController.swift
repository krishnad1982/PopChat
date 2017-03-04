//
//  PictureViewController.swift
//  PopChat
//
//  Created by KR DEVARAJAN NAIR on 2017/03/02.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import FirebaseStorage


class PictureViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var lblNext: UIButton!
    let imgPicker=UIImagePickerController()
    let utility=Utility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPicker.delegate=self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnNext(_ sender: AnyObject) {
        lblNext.isEnabled=false
        let imgFolder=FIRStorage.storage().reference().child("images")
        let imgData=UIImageJPEGRepresentation(imgView.image!, 0.1)
        imgFolder.child("\(NSUUID().uuidString).jpg").put(imgData!, metadata: nil) { (metadata, error) in
            if error != nil{
                self.utility.generateAlert(title: "Information", message: "Please check your internet connection", actiontitle: "Ok", page: self)
                self.lblNext.isEnabled=true
            }else{
                let snapInfo:[String:String]=["Description":self.txtDescription.text!,"imageURL":(metadata?.downloadURL()?.absoluteString)!]
                self.performSegue(withIdentifier: "selectUserSegue", sender: snapInfo)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVc=segue.destination as! SelectUserViewController
        nextVc.snapInfo=sender as! [String:String]
        
    }
    @IBAction func btnCamera(_ sender: AnyObject) {
        imgPicker.sourceType = .savedPhotosAlbum
        present(imgPicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image=info[UIImagePickerControllerOriginalImage] as! UIImage
        imgView.image=image
        imgPicker.dismiss(animated: true, completion: nil)
    }
}
