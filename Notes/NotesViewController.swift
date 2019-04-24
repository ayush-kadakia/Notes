//
//  NotesViewController.swift
//  Notes
//
//  Created by Ayush Kadakia on 4/3/19.
//  Copyright © 2019 Ayush Kadakia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

var noteData = [String]()
var noteIDs = [String]()

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tableView: UITableView!
    
    var currentNote: String?
    var currentKey: String?
    var currentIndexPath: Int?
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()

        
        //Set firebase ref
        ref = Database.database().reference()
        
        //Get the posts and look for changes
        let userID = Auth.auth().currentUser!.uid
        databaseHandle = ref?.child("Users/\(userID)/Notes").observe(.childAdded , with: { (snapshot) in
            
            //code to do when child is added under /users/username/posts
            
            //take snapshot value and add to note data array
            let note = snapshot.value as? String
            
            //add the ID to the IDs array
            let id = snapshot.key as String
            
            //making sure its not null and an actual note
            if let actualNote = note {
                noteData.append(actualNote)
                
                //reload that
                self.tableView.reloadData()
            }
            
                noteIDs.append(id)
            
        })
        
        databaseHandle = ref?.child("Users/\(userID)/Notes").observe(.childChanged , with: { (snapshot) in
            
            print("summin changed")
            self.tableView.reloadData()

            
            }
            
            
        )

    }
    

    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError{
            print(logoutError)
        }
        
        let loginVC = self.storyboard?.instantiateInitialViewController()
        present(loginVC!, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            let userID = Auth.auth().currentUser!.uid
            ref?.child("Users/\(userID)/Notes/\(noteIDs[indexPath.row])").removeValue()
            
            noteIDs.remove(at: indexPath.row)
            noteData.remove(at: indexPath.row)
            
            self.tableView.reloadData()

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        //get the current value of cell and store in var
        currentNote = noteData[indexPath.row]
        currentKey = noteIDs[indexPath.row]
        currentIndexPath = indexPath.row
        
        
        //present a textbox view controller that already has the text from the var
        performSegue(withIdentifier: "editNoteSegue", sender: self)
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let currentNote = currentNote else {
            return
        }
        
        guard let currentKey = currentKey else {
            return
        }
        
        guard let currentIndexPath = currentIndexPath else {
            return
        }
        
        if segue.identifier == "editNoteSegue" {
            guard let destination = segue.destination as? EditViewController else { return }
            destination.currentNote = currentNote
            destination.currentKey = currentKey
            destination.currentIndexPath = currentIndexPath
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = noteData[indexPath.row]
        
        return cell!
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
