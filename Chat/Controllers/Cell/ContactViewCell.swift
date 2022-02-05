//
//  ContactViewCell.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 30.01.2022.
//

import UIKit

protocol SelfConfiguringContactCell {
    static var reuseId: String { get }
    func configure(with value: Contact)
}

class ContactViewCell: UICollectionViewCell, SelfConfiguringContactCell {
    static var reuseId: String = "ContactChatCell"
    
    let friendImageView  = UIImageView()
    let friendName = UILabel(text: "User Name", font: .avenir20())
    
    
    // тут сетим
    func configure<U>(with value: U) where U : Hashable {
        guard let chat: Contact = value as? Contact else { return }
        friendName.text = chat.userName
//        friendImageView.sd_setImage(with: URL(string: chat.userImage), completed: nil)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - SwiftUI
import SwiftUI

struct ContacVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        
        let contactVC = SecondMainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ContacVCProvider.ContainerView>) ->  SecondMainTabBarController {
            return contactVC
        }
        
        func updateUIViewController(_ uiViewController: ContacVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ContacVCProvider.ContainerView>) {
            
        }
    }
}
