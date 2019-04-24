//
//  ComposeViewController.swift
//  Notes
//
//  Created by Ayush Kadakia on 4/3/19.
//  Copyright © 2019 Ayush Kadakia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class ComposeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNote(_ sender: Any) {
        //posts data to firebase
        let userID = Auth.auth().currentUser!.uid

        ref?.child("Users/\(userID)/Notes").childByAutoId().setValue(textView.text)
        
        //dismiss the popover
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        
        presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
