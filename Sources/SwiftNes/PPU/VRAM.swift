//
// VRAM.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

struct VRAM {
    var memory: Memory
    var addCount: UInt8

    init() {
        self.memory = Memory()
        self.addCount = 0
    }
}
