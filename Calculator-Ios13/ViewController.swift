//
//  ViewController.swift
//  Calculator-Ios13
//
//  Created by wesam Khallaf on 4/23/20.
//  Copyright © 2020 wesam Khallaf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var program : [String] = ["5", "+" ,"30" ,"sin","+", "(" , "8" , "*", "9", ")", "/", "(", "(", "9", "*" , "60","cos" ,")",")"]
    
      var model = CalculatorModel()
    override func viewDidLoad() {
        super.viewDidLoad()
         //Do any additional setup after loading the view.
       model.stack = program
        model.Scan()
       
    }


}

