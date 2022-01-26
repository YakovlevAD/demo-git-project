//
//  ActiveChatCell.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 13.12.2021.
//

import UIKit

class ActiveChatCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId: String = "ActiveChatCell"
    
    var friendImageView = UIImageView()
    var friendName = UILabel(text: "User Name", font: .laoSangamMN20())
    var lastMessage = UILabel(text: "How are you?", font: .laoSangamMN18())
    let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.8309458494, green: 0.7057176232, blue: 0.9536159635, alpha: 1), endColor: #colorLiteral(red: 0.5460671782, green: 0.7545514107, blue: 0.9380497336, alpha: 1))
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.1787690818, green: 0.1787690818, blue: 0.1787690818, alpha: 1)
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else { return }
        friendName.text = chat.friendUsername
        lastMessage.text = chat.lastMessageContent
        friendImageView.sd_setImage(with: URL(string: chat.friendAvatarStringURL), completed: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup constraints
extension ActiveChatCell {
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendName.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        friendImageView.backgroundColor = .black
        friendImageView.contentMode = .scaleAspectFill
        friendImageView.clipsToBounds = true
        gradientView.backgroundColor = .black
        friendName.textColor = .mainWhite()
        lastMessage.textColor = #colorLiteral(red: 0.3029474616, green: 0.3290647268, blue: 0.364199847, alpha: 1)
        
        addSubview(friendImageView)
        addSubview(friendName)
        addSubview(lastMessage)
        addSubview(gradientView)
        
        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImageView.heightAnchor.constraint(equalToConstant: 78),
            friendImageView.widthAnchor.constraint(equalToConstant: 78)
        ])
        
        NSLayoutConstraint.activate([
            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            friendName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            lastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
            lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 78),
            gradientView.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
}

//// MARK: - SwiftUI
//import SwiftUI
//
//struct ActiveChatProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
//    }
//    
//    struct ContainerView: UIViewControllerRepresentable {
//        
//        
//        let tabBarVC = MainTabBarController()
//        
//        func makeUIViewController(context: UIViewControllerRepresentableContext<ActiveChatProvider.ContainerView>) ->  MainTabBarController {
//            return tabBarVC
//        }
//        
//        func updateUIViewController(_ uiViewController: ActiveChatProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ActiveChatProvider.ContainerView>) {
//            
//        }
//    }
//}
