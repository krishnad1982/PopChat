//
//  PictureViewController.swift
//  PopChat
//
//  Created by KR DEVARAJAN NAIR on 2017/03/02.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit

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
