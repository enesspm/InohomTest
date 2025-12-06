//
//  ViewController.swift
//  InohomTest
//
//  Created by Enes Pamukçu on 6.12.2025.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var inohomLabel: UILabel!
    @IBOutlet weak var accountsButton: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inohomLabel.text = "inohom+"
        versionLabel.text = "v.1.7.0"
        accountsButton.titleLabel?.text = "Hesaplar"
    }
    
    @IBAction func accountsButtonAction(_ sender: Any) {
        
    }
}

