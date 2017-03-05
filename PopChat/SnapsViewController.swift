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
import FirebaseStorage


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
        if snaps.count==0{
            return 1
        }else{
            return snaps.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        if snaps.count==0{
            cell.textLabel?.text="No spans to dispaly!"
        }else{
            let snapiInfos=self.snaps[indexPath.row]
            cell.textLabel?.text=snapiInfos.from
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap=snaps[indexPath.row]
        //let details:[String:String]=["Description":snap.description,"ImageURL":snap.imageUrl]
        performSegue(withIdentifier: "detailsSegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="detailsSegue"{
            let nextVc=segue.destination as! DetailsViewController
            nextVc.snaps=sender as! Snap
        }
    }
    
    
    //fetch data from firebase
    func fetchData(){
        // child add event firebase
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("snaps").observe(FIRDataEventType.childAdded,with: { (snapshot) in
            let snap=Snap()
            snap.from=((snapshot.value as? NSDictionary)?["from"] as? String)!
            snap.description=((snapshot.value as? NSDictionary)?["description"] as? String)!
            snap.imageUrl=((snapshot.value as? NSDictionary)?["imageURL"] as? String)!
            snap.uid=snapshot.key
            snap.uuid=((snapshot.value as? NSDictionary)?["uuid"] as? String)!
            self.snaps.append(snap)
            self.tblView.reloadData()
        })
        removeData()
    }
    func removeData(){
        // child removed event
        FIRDatabase.database().reference().child("users").child((FIRAuth.auth()?.currentUser?.uid)!).child("snaps").observe(FIRDataEventType.childRemoved,with: { (snapshot) in
            var index=0
            for snap in self.snaps{
                if snap.uid==snapshot.key{
                    self.snaps.remove(at: index)
                }
            }
            index+=1
            self.tblView.reloadData()
        })
    }
    
}
