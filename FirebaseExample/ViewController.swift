//
//  ViewController.swift
//  FirebaseExample
//
//  Created by Basil on 2016-11-16.
//  Copyright © 2016 Makeinfo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UITableViewController {

    struct postStruct {
        let title : String
        let message : String
        
    }
    
    var posts = [postStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("Posts").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
           // let title  = snapshot.value as? ["title";]
            let title = (snapshot.value as? NSDictionary)?["title"] as? String ?? ""
            //let message = snapshot.value!["message"] as! String
            let message = (snapshot.value as? NSDictionary)?["message"] as? String ?? ""
            
            self.posts.insert(postStruct(title: title,message:message),at:0)
            self.tableView.reloadData()
        })
        post()
    }
    
    func post() {
        let title = "Title"
        let message = "Message"
        
        let post : [String:AnyObject] = ["title":title as AnyObject,"message":message as AnyObject]
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Posts").childByAutoId().setValue(post)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = posts[indexPath.row].title
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = posts[indexPath.row].message
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

