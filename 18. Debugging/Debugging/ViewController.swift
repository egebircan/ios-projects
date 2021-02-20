//
//  ViewController.swift
//  Debugging
//
//  Created by Kocfinans on 4.01.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        //print(1, 2, 3, 4, 5, separator: " - ")
        
        //assert(1==2, "Math failure!")
        
        for num in 1...50 {
            print(num)
        }
    }


}

