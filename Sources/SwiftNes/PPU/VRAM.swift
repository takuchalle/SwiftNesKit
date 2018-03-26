//
// VRAM.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

struct VRAM {
    var memory: Memory
    var addCount: UInt8

    var address: UInt16

    init() {
        self.memory = Memory()

        self.addCount = 1
        self.address = 0
    }

    mutating func setAddress(with addr: UInt8) {
        self.address = self.address & ~(UInt16(0xFF) << (self.addCount * 8))
        self.address = self.address | UInt16(addr) << (self.addCount * 8)
        self.addCount = (self.addCount + 1) % 2
    }
}
