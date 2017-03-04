//
//  SnapsViewController.swift
//  PopChat
//
//  Created by KR DEVARAJAN NAIR on 2017/03/02.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class SnapsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tblView: UITableView!
    var snaps:[Snap]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate=self
        tblView.dataSource=self
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnLogout(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        let snaps=self.snaps[indexPath.row]
        cell.textLabel?.text=snaps.from
        return cell
    }
    
    //fetch data from firebase
    func fetchData(){
        // fetch from firebase
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("snaps").observe(FIRDataEventType.childAdded,with: { (snapshot) in
            let snaps=Snap()
            snaps.from=((snapshot.value as? NSDictionary)?["from"] as? String)!
            snaps.description=((snapshot.value as? NSDictionary)?["description"] as? String)!
            snaps.imageUrl=((snapshot.value as? NSDictionary)?["imageURL"] as? String)!
            self.snaps.append(snaps)
            self.tblView.reloadData()
        })
        
    }
    
    
}
