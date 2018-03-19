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

    subscript(index: Int) -> UInt8 {
        get {
            return read1byte(at: UInt16(index))
        }
        set(newValue) {
            write(at: UInt16(index), value: newValue)
        }
    }

    subscript(index: Int) -> UInt16 {
        return read2byte(at: UInt16(index))
    }
    
    mutating func load(at address: Int, data: [UInt8]) {
        let last = address + data.count
        ram.replaceSubrange(address...last, with: data)
    }

    private func read1byte(at address: UInt16) -> UInt8 {
        let _address = Int(address)
        return ram[_address]
    }

    private func read2byte(at address: UInt16) -> UInt16 {
        let _address = Int(address)
        return (UInt16)(ram[_address]) | (UInt16)(ram[_address + 1]) << 8
    }

    private mutating func write(at address: UInt16, value: UInt8) {
        let _address = Int(address)
        ram[_address] = value
    }
}
