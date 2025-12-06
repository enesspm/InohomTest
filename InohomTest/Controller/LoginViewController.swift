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
    let ws = WebSocketManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        ws.connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        WebSocketManager.shared.loginOnMessage = nil
    }
    
    func setupUI() {
        inohomLabel.text = "inohom+"
        versionLabel.text = "v.1.7.0"
        accountsButton.setTitle("Hesaplar", for: .normal)
    }
    
    func goToMainScreen() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func accountsButtonAction(_ sender: Any) {
        let loginRequest = LoginRequestModel(isRequest: true, id: 8, params: [Param(userName: "demo", password: "123456")], method: "Authenticate")
        do {
            let jsonData = try JSONEncoder().encode(loginRequest)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                self.ws.send(jsonString)
                ws.loginOnMessage =  { [weak self] res in
                    if let data = res.data(using: .utf8) {
                        let response = try? JSONDecoder().decode(LoginResponse.self, from: data)
                        if response?.error == nil {
                            self?.goToMainScreen()
                        } else {
                            print("Login error: \(String(describing: response?.error))")
                        }
                    }
                }
            }
        } catch {
            showAlert(title: "Error", message: "Failed to create request: \(error.localizedDescription)")
        }
    }
    
    deinit {
        WebSocketManager.shared.loginOnMessage = nil
    }
}
