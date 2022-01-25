//
//  MMessage.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 17.01.2022.
//

import UIKit
import FirebaseFirestore
import MessageKit

struct MMessage: Hashable, MessageType {
    
    let content: String
    var sender: SenderType
    var sentDate: Date
    let id: String?
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var kind: MessageKind {
        return .text(content)
    }
    
    init(user: MUser, content: String) {
        self.content = content
        self.sender = Sender(senderId: user.id, displayName: user.username)
        self.sentDate = Date()
        self.id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let content = data["content"] as? String else { return nil }
        
        self.id = document.documentID
        self.sender = Sender(senderId: senderId, displayName: senderName)
        self.sentDate = sentDate.dateValue()
        self.content = content
    }
    
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName,
            "content": content
        ]
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}
