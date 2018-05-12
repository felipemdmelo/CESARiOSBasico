//
//  ViewController.swift
//  ScrollView
//
//  Created by Aluno on 12/05/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var myImg: UIImageView!
    @IBOutlet weak var myScroll: UIScrollView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myImg
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myImg.image = #imageLiteral(resourceName: "space")
        myScroll.delegate = self
        myScroll.minimumZoomScale = 1/10
        myScroll.maximumZoomScale = 1.2
        
        let x = myImg.frame.width / 2
        let y = myImg.frame.height / 2
        
        myScroll.setContentOffset(CGPoint(x: x, y: y), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

