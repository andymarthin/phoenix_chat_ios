//
//  MessagesManager.swift
//  ChatAppDemo
//
//  Created by Andy Marthin on 25/06/24.
//

import Foundation
import SwiftPhoenixClient

class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var isJoining: Bool = false
    private var channel: Channel
    
    let socket = Socket("ws://localhost:4000/socket/websocket")
    
    init(){
        socket.connect()
        self.channel = socket.channel("room:lobby")
        channel.join()
            .receive("ok") { message in
                DispatchQueue.main.async {
                    self.isJoining = true
                }
                print("Channel Joined", message.payload)
            }
            .receive("error") { message in print("Failed to join", message.payload) }
        
        
        getMessages()
    }
    
    func getMessages(){
        channel.on("new_msg") { [weak self] (newMessage) in
            DispatchQueue.main.async {
                let payload = newMessage.payload
                let body = payload["body"] as? String ?? ""
                let received = payload["received"] as? Bool ?? false
                self?.messages.append(Message(id: "\(UUID())", text: body, received: received, timestamp: Date()))
            }
        }
    }
    
    func sendMessage(text: String) {
        if !text.isEmpty{
            channel.push("new_msg", payload: ["body": text, "received": false])
                .receive("ok") {payload in print("Message sent")}
        }
    }
        
}
