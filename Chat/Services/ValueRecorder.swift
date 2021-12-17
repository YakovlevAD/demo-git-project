//
//  ValueRecorder.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 17.12.2021.
//

import UIKit

class ValueRecorder<T> {
    
    private var values: [(T, TimeInterval)] = []
    
    var timer: Timer?
    var isRecording: Bool = false
    var startingDate: Date?
    
    let recordCallback: () -> T
    
    init(recordCallback: @escaping () -> T) {
        self.recordCallback = recordCallback
    }
    
    func startRecording() {
        
        if (isRecording) {
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
        isRecording = true
    }
    
    @objc
    func onTimerTick() {
        guard let startingDate = startingDate else {
            assert(false)
            return
        }
        let value = recordCallback()
        let interval = Date().timeIntervalSince(startingDate)
        
        values.append((value, interval))
    }
    
    func stopRecording() -> [(T, TimeInterval)] {
        timer?.invalidate()
        timer = nil
        
        isRecording = false
        
        return values
    }
    
}
