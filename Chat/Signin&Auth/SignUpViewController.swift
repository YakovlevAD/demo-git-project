//
//  SignUpViewController.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 09.12.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let  welcomeLabel = UILabel(text:"Registration", font: .avenir26())
    
    let  emailLabel = UILabel(text:"Email")
    let  passwordLabel = UILabel(text:"Password")
    let  confirmPasswordLabel = UILabel(text:"Confirm password")
    let  alreadyOnBoardLabel = UILabel(text:"Already onBoard?")
    
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    let confirmTextField = OneLineTextField(font: .avenir20())
    
    let  signUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .buttonDark(), cornerRadius: 4)
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
    weak var deligate: AuthNavigationDeligate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        welcomeLabel.textColor = .white
        emailLabel.textColor = .white
        passwordLabel.textColor = .white
        confirmPasswordLabel.textColor = .white
        alreadyOnBoardLabel.textColor = .white
        
        emailTextField.textColor = .white
        passwordTextField.textColor = .white
        confirmTextField.textColor = .white
        emailTextField.autocapitalizationType = .none
        passwordTextField.autocapitalizationType = .none
        confirmTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        confirmTextField.autocorrectionType = UITextAutocorrectionType.no
        
        setupConstraints()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func loginButtonTapped() {
        self.dismiss(animated: true) {
            self.deligate?.toLoginVC()
        }
    }
    
    @objc private func signUpButtonTapped() {
        print(#function)
        AuthService.shared.register(email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmTextField.text) { (result) in
            switch result {
            case .success(let user):
                self.showAlert(with: "Успешно!", and: "Вы зарегистрированны") {
                    self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                }
                print(user.email)
            case .failure(let error):
                self.showAlert(with: "Ошибка!", and: error.localizedDescription)
            }
        }
    }
    
}

// MARK: - Setup constraints
extension SignUpViewController {
    private func setupConstraints() {
        let emailStackView  = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView  = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
        let confirmPasswordStackView  = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmTextField], axis: .vertical, spacing: 0)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [
        emailStackView,
        passwordStackView,
        confirmPasswordStackView,
        signUpButton
        ],
                                    axis: .vertical,
                                    spacing: 40)
        loginButton.contentHorizontalAlignment = .leading
        let bottomStackView  = UIStackView(arrangedSubviews: [
        alreadyOnBoardLabel,
        loginButton
        ],
                                           axis: .horizontal,
                                           spacing: 10)
        bottomStackView.alignment = .firstBaseline
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            //bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct SignUpVCProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        
        let signUpVC = SignUpViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) ->  SignUpViewController {
            return signUpVC
        }
        
        func updateUIViewController(_ uiViewController: SignUpVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) {
            
        }
    }
}

extension UIViewController {
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
