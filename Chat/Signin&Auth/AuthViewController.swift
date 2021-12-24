//
//  ViewController.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 09.12.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    var button:  UIButton = {
        let button  = UIButton()
        return button
    }()
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)
    
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sign up with")
    let alreadyOnboardLabel = UILabel(text: "Already onboard")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonDark(), isShadow: false)
    let loginButton = UIButton(title: "Login", titleColor: .buttonRed(), backgroundColor: .white, isShadow: true)
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        googleButton.customizedGoogleButton()
        view.backgroundColor  = .black
        
        googleLabel.textColor = .white
        emailLabel.textColor = .white
        alreadyOnboardLabel.textColor = .white
        
        
        setupConstraints()
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        signUpVC.deligate = self
        loginVC.delegate = self
    }
    
    @objc private func emailButtonTapped() {
        print(#function)
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTapped() {
        print(#function)
        present(loginVC, animated: true, completion: nil)
    }
}

// MARK: -Setup Constraints
extension AuthViewController {
    private func setupConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: alreadyOnboardLabel, button: loginButton)
        
        
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView], axis: .vertical, spacing: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}

extension AuthViewController: AuthNavigationDeligate  {
    func toLoginVC() {
        present(loginVC, animated: true, completion: nil)
    }
    
    func toSignUpVC() {
        present(signUpVC, animated: true, completion: nil)
    }
    
    
}

// MARK: - SwiftUI
import SwiftUI

struct AuthVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        
        let viewController = AuthViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) ->  AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: AuthVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) {
            
        }
    }
}

