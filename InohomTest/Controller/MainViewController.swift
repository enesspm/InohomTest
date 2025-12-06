//
//  MainViewController.swift
//  InohomTest
//
//  Created by Enes Pamukçu on 6.12.2025.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    let ws = WebSocketManager.shared
    
    let data = [
        "Favoriler", "Aydinlatma", "Perde", "Priz", "Seanryo", "Kumanda", "Kamera", "Alarm", "Interkom", "Sistem", "Isitma", "Klima", "Sensor", "Site Yonetimi", "Konsiyerj"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        WebSocketManager.shared.mainOnMessage = nil
    }
    
    @objc func settingsTapped() {
        print("Settings tapped")
    }
    
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.title = "Inohom"
        let settingsItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingsTapped)
        )
        navigationItem.rightBarButtonItem = settingsItem
    }
    
    func goToLightingScreen() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LightingViewController") as! LightingViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let loginRequest = LoginRequestModel(isRequest: true, id: 5, params: [nil], method: "GetControlList")
            do {
                let jsonData = try JSONEncoder().encode(loginRequest)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    ws.send(jsonString)
                    ws.mainOnMessage = { [weak self] response in
                        self?.goToLightingScreen()
                    }
                }
            } catch {
                showAlert(title: "Error", message: "Failed to create request: \(error.localizedDescription)")
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",for: indexPath) as! MainCollectionViewCell
        cell.imageView.image = UIImage(systemName: "bolt")
        cell.label.text = data[indexPath.row]
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 140)
    }
    
    deinit {
        WebSocketManager.shared.mainOnMessage = nil
    }
}
