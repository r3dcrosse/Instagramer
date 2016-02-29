//
//  LoginViewController.swift
//  Instagramer
//
//  Created by David Wayman on 2/29/16.
//  Copyright © 2016 David Wayman. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("You're logged in")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                print("Username is required")
            }
        }
    }

    @IBAction func onSignUp(sender: AnyObject) {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        if username != "" && password != "" {
            // sign up user
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            
            newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if success {
                    print("Yay created a user")
                    self.performSegueWithIdentifier("loginSegue", sender: nil)
                } else {
                    print(error?.localizedDescription)
                    if error?.code == 202 {
                        print("Username is taken")
                    }
                }
            }
        } else {
            print("Please enter a username and password to sign up")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
