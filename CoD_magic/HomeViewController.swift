//
//  HomeViewController.swift
//  CoD_magic
//
//  Created by user230431 on 3/20/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    
    //Create list
    var list = ["1","2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Dispose of any resources that can be recreated
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowInComponent component: Int) -> Int {
        
        return list.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow
                    row: Int, forComponent component: Int) -> String! {
        
        self.view.endEditing(true)
        return list[row]
    }
    
    func pickerView(pickerViw: UIPickerView, didSelectRow
                    row: Int, inComponent component: Int) {
        
        self.textBox.text = self.list[row]
        self.dropDown.isHidden = true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField == self.textBox {
            self.dropDown.isHidden = false
        }
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
