//
//  ContentView.swift
//  ChatAppDemo
//
//  Created by Andy Marthin on 25/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var messagesManager = MessagesManager()
    var messageArray = ["Hello you", "How are you doing?", "I've been building SwiftUI applications from scratch and it's so much fun!"]
    
    var body: some View {
        VStack {
            VStack {
                TitleRow(status: messagesManager.isJoining)
                
                ScrollView {
                    ForEach(messagesManager.messages, id: \.id) { message in
                        MessageBuble(message: message)
                        
                    }
                }
                .padding(.top, 10)
                .background(.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
            }
            .background(Color("Peach"))
            
            MessageField(messagesManager: messagesManager)
        }
    }
}

#Preview {
    ContentView()
}
