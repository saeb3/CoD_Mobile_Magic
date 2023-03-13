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
    
    
    @IBAction func btnCreate(_ sender: UIButton) {
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
    }
    
    
}

