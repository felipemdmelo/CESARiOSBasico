//
//  HomeViewController.swift
//  NavigationSample
//
//  Created by Marlon Chalegre on 14/04/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Home"
        
        myImageView.image = #imageLiteral(resourceName: "memoria-logo")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueViewController" {
            if let controller = segue.destination as? ViewController {
                controller.meuValor = "Isso ae"
            }
        }
    }
}
