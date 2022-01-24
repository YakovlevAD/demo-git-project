//
//  MMessage.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 17.01.2022.
//

import UIKit
import FirebaseFirestore

struct MMessage: Hashable {
    let content: String
    let senderId: String
    let senderUserName: String
    var sentDate: Date
    let id: String?
    
    
    init(user: MUser, content:String) {
        self.content = content
        senderId = user.id
        senderUserName  =  user.username
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let content = data["content"] as? String else { return nil }
        
        self.id = document.documentID
        self.senderId = senderId
        self.senderUserName = senderName
        self.sentDate = sentDate.dateValue()
        self.content = content
    }
    
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderID": senderId,
            "senderName": senderUserName,
            "content": content
        ]
        return rep
    }
}
