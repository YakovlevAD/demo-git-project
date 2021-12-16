//
//  SelfConfiguringCell.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 13.12.2021.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with value: MChat)
}
