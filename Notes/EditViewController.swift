//
//  EditViewController.swift
//  Notes
//
//  Created by Ayush Kadakia on 4/22/19.
//  Copyright © 2019 Ayush Kadakia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class EditViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var currentNote: String?
    var ref:DatabaseReference?
    var currentKey: String = ""
    var currentIndexPath: Int?


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        textView.text = currentNote
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelEdit(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        let userID = Auth.auth().currentUser!.uid

        let note = textView.text
        
        noteData[currentIndexPath!] = note!
        
        let childUpdates = ["Users/\(userID)/Notes/\(currentKey)": note]
        print("Keys: \(childUpdates.keys)")
        ref!.updateChildValues(childUpdates)
        

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
