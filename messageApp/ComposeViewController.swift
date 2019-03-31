//
//  ComposeViewController.swift
//  messageApp
//
//  Created by ongarj wongkeaw on 8/24/18.
//  Copyright © 2018 ongarj wongkeaw. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {

    var ref: DatabaseReference!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPost(_ sender: Any) {
        ref?.child("Posts").childByAutoId().setValue(textView.text)
        presentingViewController?.dismiss(animated: true, completion: nil )
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        //presentedViewController?.dismiss(animated: true, completion: nil )
        presentingViewController?.dismiss(animated: true, completion: nil )
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
