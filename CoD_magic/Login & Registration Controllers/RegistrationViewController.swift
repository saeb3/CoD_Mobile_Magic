//
//  RegistrationViewController.swift
//  CoD_magic
//
//  Created by user230431 on 3/12/23.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtVerifyPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var currentUser: RegisterUser?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let textFields: [UITextField] = [txtUsername, txtPassword, txtEmail]
        for textfield in textFields {
            textfield.addTarget(self, action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)), for: UIControl.Event.editingDidEnd)
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if currentUser == nil {
            let context = appDelegate.persistentContainer.viewContext
            currentUser = RegisterUser(context: context)
        }
        currentUser?.username = txtUsername.text
        currentUser?.password = txtPassword.text
        currentUser?.email = txtEmail.text
        return true
    }

    //Steps to add button and implement save functionality
    
    @objc func saveUser() {
        appDelegate.saveContext()
    }
    
    //Button to create user
    @IBAction func btnCreate(_ sender: UIButton) {
        
        //Prevent the creation of a new user if the username already exists in CoreData
        guard let username = txtUsername.text else {
           
            return
            
        }
        
        if userExists(username: username) {
            //Username already exists, show an error message
            let alertController = UIAlertController(title: "Error", message: "Username already exists.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            //Username does not exist, create new username
            
            //Verification that email is in correct format. If it is not, will show an error.
            guard let email = txtEmail.text else {
                //Email field is empty
                return
            }
            
            if isValidEmail(email) {
                //Email is valid, continue with submission process
                
                //Verification that both passwords match. If they do not, will show an error.
                guard let password = txtPassword.text, let confirmPassword = txtVerifyPassword.text else {
                    //Password fields are empty
                    return
                }
                
                if password == confirmPassword {
                    //Passwords match, continue with sign up process
                    
                    //Get the managed object context from the app delegate
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    
                    //Create a new entity object and set its properties
                    let entity = NSEntityDescription.entity(forEntityName: "RegisterUser", in: context)!
                    let object = RegisterUser(entity: entity, insertInto: context)
                    object.username = txtUsername.text
                    object.password = txtPassword.text
                    
                    //Save the changes to Core Data
                    do {
                        try context.save()
                        print("Saved to Core Data")
                    } catch let error as NSError {
                        print("Could not save to Core Data: \(error), \(error.userInfo)")
                    }
                } else {
                    //Passwords do not match, show an error message
                    let alertController = UIAlertController(title: "Error", message: "Passwords do not match.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    present(alertController, animated: true, completion: nil)
                }
            } else {
                //Email is invalid, show an error message
                let alertController = UIAlertController(title: "Error", message: "Invalid email format.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
            
            func isValidEmail(_ email: String) -> Bool {
                //Regular expression pattern for email validation
                let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
                
            }
        }
        
        //Function to determine if username already exists in CoreData
        func userExists(username: String) -> Bool {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RegisterUser")
            fetchRequest.predicate = NSPredicate(format: "username = %@", username)
            
            do {
                let users = try context.fetch(fetchRequest) as! [RegisterUser]
                if users.count > 0 {
                    return true
                } else {
                    return false
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                return false
            }
        }
    }
}

