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

    private let decoder: Decoder

    /* Accumulator */
    private var a: UInt8

    /* Index register */
    private var x: UInt8
    private var y: UInt8

    /* Stack Pointer */
    private var s: UInt8

    /* Status Register */
    private var p: StatusRegister

    /* Program Counter */
    private var pc: UInt16

    init(with memory: Memory) {
        self.memory = memory
        self.decoder = Decoder()

        self.a = 0
        self.x = 0
        self.y = 0
        self.s = 0
        self.p = StatusRegister()
        self.pc = 0
    }

    /* Interrupt Handler */
    mutating func nmiHandler() {
        self.pc = memory.read2byte(at: 0xFFFA)
        self.p.i = true
        self.p.b = false
    }

    mutating func resetHandler() {
        self.pc = memory.read2byte(at: 0xFFFC)
        self.p.i = true
    }

    mutating func irqHandler() {
        self.pc = memory.read2byte(at: 0xFFFE)
        self.p.i = true
    }
}
