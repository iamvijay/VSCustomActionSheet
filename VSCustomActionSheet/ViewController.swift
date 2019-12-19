//
//  ViewController.swift
//  VSCustomActionSheet
//
//  Created by Vijay on 02/12/19.
//  Copyright © 2019 Loco Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func showCustomSheet(_ sender: Any) {
           
        let selectOption = VSCustomActionSheet.init(title : "Choose Photo", cancelButtonTitle: "Cancel", otherButtonTitle: ["Take a photo","Pick from gallery","Remove photo"], completion: { buttonSelected in
                   
                   if(buttonSelected == 3){
                       print("selected index 3")
                   } else if(buttonSelected == 2) {
                      print("selected index 2")
                   } else {
                      print("selected index 1")
                   }
               })
        selectOption.showButtons(self.view)
    }

}

