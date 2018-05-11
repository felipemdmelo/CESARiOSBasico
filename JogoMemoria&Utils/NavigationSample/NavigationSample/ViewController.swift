//
//  ViewController.swift
//  NavigationSample
//
//  Created by Marlon Chalegre on 14/04/18.
//  Copyright © 2018 CESAR School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var meuValor = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = "Manolo Screen"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        print(meuValor)
        self.navigationController?.popViewController(animated: true)
    }
    
}

