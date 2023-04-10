//
//  ViewController.swift
//  CoD_magic
//
//  Created by user230431 on 3/12/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loads the saved username and password from UserDefaults and set
        //the "remember me" switch to on if there is a saved username and password
        let defaults = UserDefaults.standard
        
        if let savedUsername = defaults.string(forKey: "savedUsername"),
               let savedPassword = defaults.string(forKey: "savedPassword") {
                   txtUsername.text = savedUsername
                   txtPassword.text = savedPassword
                   rememberMeSwitch.isOn = true
               } else {
                   rememberMeSwitch.isOn = false
               }
        // Do any additional setup after loading the view.
    }
    
    // Pops this controller out of navigation controller, so the back button at the top left doesn't appear after you have registered
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }

    //Function that saves the username and password to UserDefaults if the
    //"remember me" switch is on, or removes the stored username and password
    //if the switch is off
    
    func updateRememberMeSetting() {
        let defaults = UserDefaults.standard
        
        if rememberMeSwitch.isOn {
            defaults.set(txtUsername.text, forKey: "savedUsername")
            defaults.set(txtPassword.text, forKey: "savedPassword")
        } else {
            defaults.removeObject(forKey: "savedUsername")
            defaults.removeObject(forKey: "savedPassword")
        }
    }
    
    @IBAction func dismissKeyboard() {
        txtUsername.resignFirstResponder()
    }
    
    //Call the 'updateRememberMeSetting' function from the 'saveButtonPressed' function
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        //Save user's data to Core Data
        updateRememberMeSetting()
        
        
        
        //Call the 'sign-in' function from your 'btnSubmit' function, passing in the username and password entered by the user
        //Retrieve the username and password entered by the user
        guard let username = txtUsername.text, !username.isEmpty else {
            //Display an error message or perform other error handling
            print("No username present!")
            return
        }
        
        guard let password = txtPassword.text, !password.isEmpty else {
            //Display an error message or perform other error handling
            print("No password present!")
            return
        }
        
        //Perform sign-in logic with the username and password
        if signIn(username: username, password: password) {
            //Sign-in successful, navigate to the next screen or perform other logic
            print("Successful sign-in!")
            
        } else {
            
            let alertController = UIAlertController(title: "Error", message: "Incorrect Login.", preferredStyle: .alert)
            
            //Add an OK button to the alert controller
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            //Present the alert controller
            present(alertController, animated: true, completion: nil)
            //Sign-in failed, display an error message or perform other error handling
            print("Sign-in failed!")
        }
    }
    
    //Function to perform the sign-in logic
    func signIn(username: String, password: String) -> Bool {
        //Retrieve the NSManagedObjectContext from your CoreData stack
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let context = appDelegate.persistentContainer.viewContext
        
        //Create a fetch request to retrieve the user with the given username and password
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterUser")
        request.predicate = NSPredicate(format: "username = %@ AND password = %@", username, password)
        request.fetchLimit = 1
        
        //Execute the fetch request
        do {
            let results = try context.fetch(request)
            if let user = results.first as? RegisterUser {
                //User found, sign in successful
                print("User found!")
                
                
                let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "username == %@", username)
                
                do {
                    let results = try context.fetch(fetchRequest)
                    
                    if let user = results.first {
                        UserSingleton.shared.user = user
                    }
                
                } catch let error as NSError {
                    print("Could not fetch user object")
                }
                
                return true
            } else {
                //User not found, sign in failed
                print("User not found!")
                return false
            }
        } catch {
            //Error occurred while executing the fetch request
            print("Error occurred while executing the fetch request")
            return false
        }
    }
    
    
}

