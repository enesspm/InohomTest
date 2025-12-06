//
//  UIViewController+Extension.swift
//  InohomTest
//
//  Created by Enes Pamukçu on 6.12.2025.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async { 
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
}
