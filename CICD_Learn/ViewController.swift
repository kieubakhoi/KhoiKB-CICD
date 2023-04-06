//
//  ViewController.swift
//  CICD_Learn
//
//  Created by Kiều Khôi on 31/03/2023.
//

import UIKit
import AppCenter
import AppCenterCrashes
import AppCenterAnalytics

class ViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AppCenter.start(withAppSecret: "aff0eb3b-70ba-4502-b0bd-7a46ca216405", services:[
          Crashes.self
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Crashes.hasCrashedInLastSession {
            let alert = UIAlertController(title: "Opps", message: "Sorry about that, an error occured", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    @IBAction func invokeToSubmit(_ sender: UIButton) {
        Crashes.generateTestCrash()
        nameLabel.text = "This name is: \(nameTextField.text ?? "no data")"
        Analytics.trackEvent("Submit Name", withProperties: ["name" : "\(nameTextField.text ?? "no data")"])
    }

}

