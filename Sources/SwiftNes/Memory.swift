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
    
    func load(at offset: UInt16, data: Data) {

    }
}
