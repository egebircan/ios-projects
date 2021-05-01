//
//  ViewController.swift
//  Project12
//
//  Created by Kocfinans on 26.09.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(25, forKey: "Age")
        defaults.setValue(true, forKey: "UseFaceId")
        defaults.setValue(CGFloat.pi, forKey: "Pi")
        
        defaults.setValue(Date(), forKey: "date")
        
        let array = ["Hello", "World"]
        defaults.setValue(array, forKey: "SavedArray")
        
        let dict = ["name": "paul", "country": "uk"]
        defaults.setValue(dict, forKey: "SavedDict")
        
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBoolean = defaults.bool(forKey: "UseFaceId")
        let savedCGFloat = defaults.float(forKey: "Pi")
        
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let savedDict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
        
        print(savedInteger)
        print(savedArray)
    }


}

