//
//  ContactViewController.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 26.01.2022.
//

import UIKit

struct Contact: Hashable {
    var userName: String
    var userImage: UIImage
    var lastMesssage: String
    var id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id == rhs.id
    }
}

class ContactViewController: UIViewController {
    
    let contacts: [Contact] = [
        Contact(userName: "a", userImage: UIImage(systemName: "plus")!, lastMesssage: "c")
    ]
    
    enum Sectionn: Int, CaseIterable {
        case activeChats
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Sectionn, Contact>?
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupCollectionView()
//        setupSerchBar()
        title = "hhh"
        createDataSource()
        reloadData()
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Sectionn, Contact>(collectionView: collectionView, cellProvider: { collectionView, indexPath, chat in
            // определяем в какой секции находимся
            guard let section = Sectionn(rawValue: indexPath.section) else {
                fatalError("Неполучилось определить тип секции")
            }
            // в зависимости от секции возвращаем декуае реюзабел селл по идентификатору нужной нам ViewCell
//            switch section {
//            case .activeChats:
//                return self.configure(cellType: ActiveChatCell.self, with: chat, for: indexPath)
//            }
        })
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Sectionn, Contact>()
        snapshot.appendSections([.activeChats])
        snapshot.appendItems(contacts, toSection: .activeChats)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
//    private func setupSerchBar() {
//        navigationController?.navigationBar.barTintColor = .systemBlue
//        let searchController = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.delegate = self
//
//    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(ContactViewCell.self, forCellWithReuseIdentifier: ContactViewCell.reuseId)
//        collectionView.delegate = self
//        collectionView.dataSource = self
    }
    
    private func createCompositionLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(84))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 6, leading: 6, bottom: 6, trailing: 6)
            return section
        }
        
        return layout
    }
    
}

extension ContactViewController {
    // обобщенный метод передачи данных в ячейку
    private func configure<T: SelfConfiguringContactCell>(cellType: T.Type, with value: Contact, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {fatalError("немогу декуае тип ячейки") }
        cell.configure(with: value)
        return cell
    }
}

//extension ContactViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
//    }
//}

// MARK: - SwiftUI
import SwiftUI

struct ContactVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        
        let contactVC = MainTabBarController(currentUser: MUser(username: "alex", email: "x@x.xx", avatarStringURL: "url", description: "desc", sex: "male", id: "id"))
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ContactVCProvider.ContainerView>) ->  MainTabBarController {
            return contactVC
        }
        
        func updateUIViewController(_ uiViewController: ContactVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ContactVCProvider.ContainerView>) {
            
        }
    }
}
