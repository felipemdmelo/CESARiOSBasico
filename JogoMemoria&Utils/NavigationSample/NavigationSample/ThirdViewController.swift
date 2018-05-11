//
//  ThirdViewController.swift
//  NavigationSample
//
//  Created by Marlon Chalegre on 14/04/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        let alert = UIAlertController(title: "Meu Alert", message: "Olá tudo bem?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            print("Ok")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print("Cancel")
        }))
        
        alert.addAction(UIAlertAction(title: "Destrutive", style: .destructive, handler: { (action) in
            print("Destrutive")
        }))
        
        present(alert, animated: true)
    }
}
