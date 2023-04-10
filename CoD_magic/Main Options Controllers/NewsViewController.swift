//
//  NewsViewController.swift
//  CoD_magic
//
//  Created by user230431 on 3/20/23.
//  Sean Flanagan

import UIKit
import SwiftUI


class NewsViewController: UIViewController {
    

    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Do any additional setup after loading the view
        
        // Area to put text into TextView. Editability and selectability for textview has been manually disabled
        myTextView.text += "What is a Parks and Recreation Master Plan?\n\nThe goal of the Parks and Recreation Master Plan is to create a long-range, community-supported vision for how the city will move the Park and Recreation System forward. The plan is data-driven and rooted in understanding the current conditions of the park system and city, coupled with planning for projected changes and expected future improvements. It will provide recommendations for the facilities, programs, services, improvements, and more, all with the mission of making Decatur more resilient, healthy, and thriving."
        
        
        // Set the background image
        backgroundImageView.image = UIImage(named: "CoD_bg_img_2")
        // Set the content mode to scale aspect fill
        backgroundImageView.contentMode = .scaleAspectFill
        // Clip to bounds
        backgroundImageView.clipsToBounds = true
      
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
