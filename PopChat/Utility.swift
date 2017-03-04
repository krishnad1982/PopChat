//
//  Utility.swift
//  PopChat
//
//  Created by KR DEVARAJAN NAIR on 2017/03/03.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import Foundation
import UIKit

class Utility{
    
    // Alert method
    func generateAlert(title:String,message:String,actiontitle:String,page:UIViewController){
        let alert=UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: actiontitle, style: UIAlertActionStyle.default, handler: nil))
        page.present(alert, animated: true, completion: nil)
    }
}
