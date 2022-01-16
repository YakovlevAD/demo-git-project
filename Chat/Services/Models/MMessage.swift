//
//  MMessage.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 17.01.2022.
//

import UIKit

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
