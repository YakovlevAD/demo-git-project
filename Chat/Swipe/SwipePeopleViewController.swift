//
//  SwipePeopleViewController.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 27.12.2021.
//

import UIKit
import FirebaseFirestore

class SwipePeopleViewController: UIViewController {
    private var usersListener: ListenerRegistration?
    var users = [MUser]()
    
    //MARK: - Properties
    var viewModelData = [CardsDataModel]()
//    var viewModelData = [CardsDataModel(bgColor: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0), text: "Hamburger", image: "hamburger"),
//                         CardsDataModel(bgColor: UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0), text: "Puppy", image: "puppy"),
//                         CardsDataModel(bgColor: UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0), text: "Poop", image: "poop"),
//                         CardsDataModel(bgColor: UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0), text: "Panda", image: "panda"),
//                         CardsDataModel(bgColor: UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0), text: "Subway", image: "subway"),
//                         CardsDataModel(bgColor: UIColor(red:0.83, green:0.82, blue:0.69, alpha:1.0), text: "Robot", image: "robot")]
    var stackContainer : StackContainerView!
    
    
    //MARK: - Init
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.09766673297, green: 0.09766673297, blue: 0.09766673297, alpha: 1)
        stackContainer = StackContainerView()
        view.addSubview(stackContainer)
        configureStackContainer()
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        configureNavigationBarButtonItem()
    }
    
    deinit {
        usersListener?.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Expense Tracker"
        stackContainer.dataSource = self
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = .white
        
        usersListener = ListenerService.shared.userObserve(users: users, completion: { (result) in
            switch result {
            case .success(let users):
                self.users = users
                self.reloadData(with: nil)
                print("count>>>\(users.count)")
            case .failure(let error):
                self.showAlert(with: "Ошибка!", and: error.localizedDescription)
            }
        })
    }
    
    private func reloadData(with searchText: String?) {
        let filtred = users.filter { (user) -> Bool in
            user.contains(filter: searchText)
        }
        filtred.forEach { muser in
            guard let url = URL(string: muser.avatarStringURL) else { return }
            let userImageView = UIImageView()
            userImageView.sd_setImage(with: url, completed: nil)
            viewModelData.append(CardsDataModel(bgColor: UIColor(.black), text: muser.username, image: userImageView))
        }
    }
    
    
    //MARK: - Configurations
    func configureStackContainer() {
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //TODO: - непонятно почему не заводятся значения экрана
        stackContainer.widthAnchor.constraint(equalToConstant: 350).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    func configureNavigationBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))
    }
    
    //MARK: - Handlers
    @objc func resetTapped() {
        stackContainer.reloadData()
    }
    
}

extension SwipePeopleViewController : SwipeCardsDataSource {
    
    func numberOfCardsToShow() -> Int {
        return viewModelData.count
    }
    
    func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = viewModelData[index]
        return card
    }
    
    func emptyView() -> UIView? {
        return nil
    }
}
// MARK: - SwiftUI
import SwiftUI

struct SwipePeopleVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        
        let loginVC = SwipePeopleViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SwipePeopleVCProvider.ContainerView>) ->  SwipePeopleViewController {
            return loginVC
        }
        
        func updateUIViewController(_ uiViewController: SwipePeopleVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SwipePeopleVCProvider.ContainerView>) {
            
        }
    }
}
