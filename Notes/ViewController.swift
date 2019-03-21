//
//  ViewController.swift
//  Notes
//
//  Created by Ayush Kadakia on 3/6/19.
//  Copyright © 2019 Ayush Kadakia. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        
        //Gets the Auth UI Object
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else{
            return
        }
        
        //Assigns Delegate
        authUI?.delegate = self
        
        //Get the ref to the auth UI VC
        let authViewController = authUI!.authViewController()
        
        //Show it
        present(authViewController, animated: true, completion: nil)
    }
    
}

extension ViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        if(error != nil){
            return
        }
        
        performSegue(withIdentifier: "goHome", sender: self)
    }
}
