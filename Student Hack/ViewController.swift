//
//  ViewController.swift
//  Student Hack
//
//  Created by Parham on 27/10/2014.
//  Copyright (c) 2014 Parham Majdabadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let test = PFObject(className: "Test")
        test["Foo"] = "Bar"
        test.saveInBackground()
    }



}

