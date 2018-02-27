// 
// CPU.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

struct CPU {
    /*
     * CPU Memory Map
     *
     * -- $FFFF --
     * Usual ROM, commonly with Mapper Registers
     * -- $8000 --
     * Battery Backed Save or Work RAM
     * -- $6000 --
     * -- $401F --
     * Use Test Mode
     * -- $4017 --
     * NES APU and I/O registers
     * -- $4000 --
     * Mirrors of $2000-2007
     * -- $2007 --
     * NES PPU registers
     * -- $2000 --
     * Mirrors of $0000-$07FF
     * -- $0800 --
     * RAM
     * -- $0000 --
     */
    private let memory: Memory

    init(with memory: Memory) {
        self.memory = memory
    }
}
