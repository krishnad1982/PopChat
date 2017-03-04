//
//  SelectUserViewController.swift
//  PopChat
//
//  Created by KR DEVARAJAN NAIR on 2017/03/03.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SelectUserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    var users:[Users]=[]
    var snapInfo:[String:String]=[:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblView.delegate=self
        tblView.dataSource=self
        fetchData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        
        let user=users[indexPath.row]
        cell.textLabel?.text=user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user=users[indexPath.row]
        let snaps:[String:String] = ["from":user.email,"imageURL":snapInfo["imageURL"]!,"description":snapInfo["Description"]!]
        FIRDatabase.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snaps)
        tblView.deselectRow(at: indexPath, animated: true)
    }
    
    //fetch data from firebase
    func fetchData(){
        // fetch from firebase
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded,with: { (snapshot) in
            let user=Users()
            user.email=((snapshot.value as? NSDictionary)?["email"] as? String)!
            user.uid=snapshot.key
            self.users.append(user)
            self.tblView.reloadData()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
