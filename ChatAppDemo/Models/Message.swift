//
//  Message.swift
//  ChatAppDemo
//
//  Created by Andy Marthin on 25/06/24.
//

import Foundation


struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
