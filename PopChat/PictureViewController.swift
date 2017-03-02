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
        if isUploaded(){
            performSegue(withIdentifier: "selectUserSegue", sender: nil)
        }else{
            //alert code
            let alert=UIAlertController(title: "Information", message: "please check your internet connection!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: { 
                self.lblNext.isEnabled=true
            })
            //alert code end here
        }
    }
    
    func isUploaded()->Bool{
        var done:Bool=false
        let imgFolder=FIRStorage.storage().reference().child("images")
        let imgData=UIImageJPEGRepresentation(imgView.image!, 0.1)
        imgFolder.child("images.png").put(imgData!, metadata: nil) { (metadata, error) in
            if error != nil{
                done=false
            }else{
                done=true
            }
        }
        return done
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
