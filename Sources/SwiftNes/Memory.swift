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
        ram = [UInt8](repeating: 0, count: maxMemSize + 1)
    }
    
    mutating func load(at address: Int, data: [UInt8]) {
        let last = address + data.count
        ram.replaceSubrange(address...last, with: data)
    }

    func read1byte(at address: UInt16) -> UInt8 {
        let _address = Int(address)
        return ram[_address]
    }

    func read2byte(at address: UInt16) -> UInt16 {
        let _address = Int(address)
        return (UInt16)(ram[_address]) | (UInt16)(ram[_address + 1]) << 8
    }

    mutating func write(at address: UInt16, value: UInt8) {
        let _address = Int(address)
        ram[_address] = value
    }
}
