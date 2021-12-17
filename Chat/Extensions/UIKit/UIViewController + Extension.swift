//
//  UIViewController + Extension.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 17.12.2021.
//

import UIKit

extension UIViewController {
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath:IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Enable to dequeue \(cellType)")}
        cell.configure(with: value)
        return cell
    }
}
