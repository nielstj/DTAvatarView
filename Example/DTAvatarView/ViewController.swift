//
//  ViewController.swift
//  DTAvatarView
//
//  Created by Daniel Tjuatja on 12/14/2015.
//  Copyright (c) 2015 Daniel Tjuatja. All rights reserved.
//

import UIKit
import DTAvatarView

class ViewController: UIViewController {

    @IBOutlet weak var sizeConstraint : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changeSize(_ sender : AnyObject) {
        var size = sizeConstraint.constant
        size = size == 0 ? -60 : 0
        sizeConstraint.constant = size
        view.subviews.forEach { (view) -> () in
            view.setNeedsDisplay()
        }
    }
    

}

