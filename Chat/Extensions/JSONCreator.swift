//
// Created by Alexandr Yakovlev on 17.12.2021.
//

import UIKit
import Foundation

extension ValuePlayer {
    func saveToJSON(values: String) {
        let jsonString = values

        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("myJsonString.json")
            do {
                try jsonString.write(to: pathWithFilename,
                        atomically: true,
                        encoding: .utf8)
            } catch {
                // Handle error
            }
        }
    }

}