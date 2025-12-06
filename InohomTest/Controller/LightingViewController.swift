//
//  LightingViewController.swift
//  InohomTest
//
//  Created by Enes Pamukçu on 6.12.2025.
//

import UIKit

class LightingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    let ws = WebSocketManager.shared
    
    let data = [
        "Yönetim Harita Spot", "Serkan Led", "Yönetim Spot", "Abajur", "Pano Aydınlatma 2", "Teknik Aydınlatma", "Arge WC", "Toplantı Aydınlatma", "Giriş Aydınlatma", "Mutfak Aydınlatma", "Bodrum Depo Ayd 1", "Saha Arıza Ayd 1"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        WebSocketManager.shared.mainOnMessage = nil
    }
    
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.title = "Aydinlatma"
        let settingsItem = UIBarButtonItem(
            image: UIImage(systemName: "lightbulb"),
            style: .plain,
            target: self,
            action: #selector(settingsTapped)
        )
        
        navigationItem.rightBarButtonItem = settingsItem
    }
    
    @objc func settingsTapped() {
        print("Settings tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let loginRequest = LoginRequestModel(isRequest: true, id: 84, params: [Param(id: "a2830d60-ddff-4dad-8f3d-dfca0ded2462", value: 1)], method: "UpdateControlValue")
        do {
            let jsonData = try JSONEncoder().encode(loginRequest)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                ws.send(jsonString)
                ws.lightingOnMessage = { response in }
            }
        } catch {
            showAlert(title: "Error", message: "Failed to create request: \(error.localizedDescription)")
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lightingCell",for: indexPath) as! LightingCollectionViewCell
        cell.imageView.image = UIImage(systemName: "lightbulb")
        cell.label.text = data[indexPath.row]
        cell.label.numberOfLines = 0
        cell.label.lineBreakMode = .byWordWrapping

        cell.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 140)
    }
    
    deinit {
        WebSocketManager.shared.lightingOnMessage = nil
    }
}
