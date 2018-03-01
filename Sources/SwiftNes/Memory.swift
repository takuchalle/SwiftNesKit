//
//  Memory.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

import Foundation

struct Memory {

    var ram: [UInt8]

    init() {
        ram = [UInt8](repeating: 0, count: 0x1000)
    }
    
    mutating func load(at offset: Int, data: [UInt8]) {
        let last = 0x1000 - offset + data.count
        ram.replaceSubrange(offset...last, with: data)
    }
}
