//
//  ValuePlayer.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 17.12.2021.
//

import UIKit

class ValuePlayer<T> {
    
    private var values: [(T, TimeInterval)]
    var startingDate: Date?
    var timer: Timer?
    var isPlaying = false
    
    let callback: (T)->()
    
    init(values:  [(T, TimeInterval)], callback: @escaping (T)->()) {
        self.values = values
        self.callback = callback
    }
    
    func play() {
        if (isPlaying) {
            return
        }
        
        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(onTimerTick),
            userInfo: nil,
            repeats: true
        )
        
        startingDate = Date()
        isPlaying = true
    }
    
    @objc
    func onTimerTick() {
        guard let date = startingDate else {
            return
        }
        
        let interval = Date().timeIntervalSince(date)

        var index = 0
        
        for i in 0..<values.count {
            if (values[i].1 <= interval) {
                index += 1
            }
        }
        
        let valuesToExecute = values.prefix(index).compactMap {
            $0.0 //TODO: - что обозначает знак $ и почему 0.0
        }
        
        values.removeFirst(index)
        
        for value in valuesToExecute {
            DispatchQueue.main.async { [weak self] in
                self?.callback(value)
            }
        }
        
        if (values.isEmpty) {
            timer?.invalidate()
            timer = nil
        }
        
    }
    
    
}
