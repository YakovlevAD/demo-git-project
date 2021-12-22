//
//  AuthNavigatingDelegate.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 22.12.2021.
//

import Foundation

protocol AuthNavigationDeligate: class {
    func toLoginVC()
    func toSignUpVC()
}
