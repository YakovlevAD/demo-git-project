//
//  WaitingChatsNavigation.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 22.01.2022.
//

import Foundation

protocol WaitingChatsNavigation: class {
    func remoweWaitingChat(chat: MChat)
    func chatToActive(chat: MChat)
}
