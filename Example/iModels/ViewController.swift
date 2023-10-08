//
//  ViewController.swift
//  iModels
//
//  Created by Anbalagan D on 02/18/2023.
//  Copyright (c) 2023 Anbalagan D. All rights reserved.
//

import UIKit
import iModels

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(Device.modelName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

