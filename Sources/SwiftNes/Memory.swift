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
        let index = offset - 1
        let last = maxMemSize - offset + data.count - 1
        ram.replaceSubrange(index...last, with: data)
    }

    func read1byte(at offset: UInt16) -> UInt8 {
        let _offset = Int(offset)
        return ram[_offset]
    }

    func read2byte(at offset: UInt16) -> UInt16 {
        let _offset = Int(offset)
        return (UInt16)(ram[_offset]) | (UInt16)(ram[_offset + 1]) << 8
    }

    mutating func write(at offset: UInt16, value: UInt8) {
        let _offset = Int(offset)
        ram[_offset] = value
    }
}
