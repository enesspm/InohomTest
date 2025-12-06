//
//  WebSocketManager.swift
//  InohomTest
//
//  Created by Enes Pamukçu on 6.12.2025.
//

import Foundation
import Starscream

protocol WebSocketManagerDelegate: AnyObject {
    func webSocketManager(_ manager: WebSocketManager, didReceiveMessage message: String)
}


class WebSocketManager: WebSocketDelegate {
    
    static let shared = WebSocketManager()  // Singleton

    private init() { }
    
    private var socket: WebSocket?
    var loginOnMessage: ((String) -> Void)?
    var mainOnMessage: ((String) -> Void)?
    var lightingOnMessage: ((String) -> Void)?
    
    func connect() {
        print("🔵 Connecting...")
        var request = URLRequest(url: URL(string: "ws://64.227.77.73:9095/ws")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }

    func disconnect() {
        print("🔴 Disconnect")
        socket?.disconnect()
    }

    func send(_ text: String) {
        print("➡️ Sending: \(text)")
        socket?.write(string: text)
    }

    // MARK: - Starscream Delegate
    func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {
        switch event {
        case .connected(let headers):
            print("⚡️ WebSocket connected: \(headers)")

        case .disconnected(let reason, let code):
            print("❌ Disconnected: \(reason) (code: \(code))")
        case .text(let text):
            print("Received text: \(text)")
            if let loginOnMessage = loginOnMessage {
                loginOnMessage(text)
            }
            if let mainOnMessage = mainOnMessage {
                mainOnMessage(text)
            }
            if let lightingOnMessage = lightingOnMessage {
                lightingOnMessage(text)
            }
        case .binary(let data):
            print("Received binary: \(data.count) bytes")
        case .error(let error):
            print("❗️ Error: \(error?.localizedDescription ?? "Unknown")")
        case .cancelled:
            print("❌ Cancelled")

        default:
            break
        }
    }
}
