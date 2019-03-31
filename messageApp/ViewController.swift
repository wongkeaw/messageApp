//
//  ViewController.swift
//  messageApp
//
//  Created by ongarj wongkeaw on 8/23/18.
//  Copyright © 2018 ongarj wongkeaw. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var databaseHendld:DatabaseHandle!
    var databaseHendld2:DatabaseHandle!
    var postData = [String]()
    
    let model = CounterModel()
    var observers = [NSKeyValueObservation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        ref = Database.database().reference()
        
        // retive the posts and listen for changes
        databaseHendld = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            // code to excute when child is added under Posts
            // take the data from the snapshot and added to the Postdata array
            let post = snapshot.value as? String
            if let actualPost = post {
                // append the data to our postData array
                    self.postData.append(actualPost)
                // reload the table view
                    self.tableView.reloadData()
                self.model.value  = self.model.value + 1
                //self.model.messages.append("Sequence 1") ;
            }
        })
        observeModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func observeModel() {
        self.observers = [
            model.observe(\.value, options: [.initial]) { (model, change) in
                print(" model.value \(String(model.value))")
            },
            model.observe(\.messages, options: [.initial]) { (model, change) in
                print(" model.messages \( String(model.messages.joined(separator: "\n")) )")
            }
        ]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }


}

