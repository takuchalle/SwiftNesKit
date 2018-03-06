//
//  Memory.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

import Foundation

struct Memory {

    var ram: [UInt8]

    private let maxMemSize = 0x10000

    init() {
        ram = [UInt8](repeating: 0, count: maxMemSize)
    }
    
    mutating func load(at offset: Int, data: [UInt8]) {
        let last = maxMemSize - offset + data.count
        ram.replaceSubrange(offset...last, with: data)
    }

    func read1byte(at offset: Int) -> UInt8 {
        return ram[offset]
    }

    func read2byte(at offset: Int) -> UInt16 {
        return (UInt16)(ram[offset + 1]) | (UInt16)(ram[offset + 2]) << 8
    }

    mutating func write(at offset: Int, value: UInt8) {
        ram[offset] = value
    }
}
