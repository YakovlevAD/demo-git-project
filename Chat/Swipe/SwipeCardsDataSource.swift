//
//  SwipeCardsDataSource.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 27.12.2021.
//

import UIKit

protocol SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> SwipeCardView
    func emptyView() -> UIView?
    
}

protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: SwipeCardView)
}
