//
// ViewController.swift
// Evolution simulator
//
// Created by Vlasto, Benedict (JDN) on 19/09/2020.
//

// This is the view loaded when the app first runs

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Button to access parameter input screen
    @IBAction func showParameterInputVC(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "parameterInputVC") as? ParameterInputViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
}