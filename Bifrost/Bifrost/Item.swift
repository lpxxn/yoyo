//
//  Item.swift
//  Bifrost
//
//  Created by li on 2024/5/9.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
