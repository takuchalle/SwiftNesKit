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
    private var memory: Memory

    private let decoder: Decoder

    /* Accumulator */
    private var a: UInt8

    /* Index register */
    private var x: UInt8
    private var y: UInt8

    /* Stack Pointer */
    private var s: UInt8 {
        willSet {
            if(newValue == (UInt8)(0x0)) {
                fatalError("Stack OverFlow")
            }
        }
    }

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
        self.s = 0xFF
        self.p = StatusRegister()
        self.pc = 0x8000
    }

    public mutating func step() {
        let inst = fetch()
        pc = pc + UInt16(inst.bytes)
        exec(inst)
    }

    func fetch() -> Instruction {
        return decoder.decode(memory.ram, pc: self.pc)
    }

    mutating func exec(_ inst: Instruction) {
        switch inst.opcode {
        case .LDA:
            lda(inst)
        case .LDX:
            ldx(inst)
        case .LDY:
            ldy(inst)
        case .STA:
            sta(inst)
        case .STX:
            stx(inst)
        case .STY:
            sty(inst)
        case .TAX:
            tax()
        case .TAY:
            tay()
        case .TSX:
            tsx()
        case .TXA:
            txa()
        case .TXS:
            txs()
        case .TYA:
            tya()
        default:
            print("Unknown opcode")
        }
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

    /* Stack Operation */
    mutating func push(_ value: UInt8) {
        memory.write(at: UInt16(0x100) + UInt16(self.s), value: value)
        self.s = self.s - 1
    }

    mutating func pop() -> UInt8 {
        self.s = self.s + 1
        return memory.read1byte(at: UInt16(0x100) + UInt16(self.s))
    }

    func read(_ inst: Instruction) -> UInt8 {
        guard let value = inst.value else {
            return UInt8(0)
        }

        switch inst.addressing {
        case .ZeroPage, .Absolute:
            return memory.read1byte(at: value)
        case .ZeroPageX, .AbsoluteX:
            return memory.read1byte(at: value + UInt16(self.x))
        case .ZeroPageY, .AbsoluteY:
            return memory.read1byte(at: value + UInt16(self.y))
        case .Immediate:
            return UInt8(value)
        case .IndirectX:
            let addr = memory.read2byte(at: value + UInt16(self.x))
            return memory.read1byte(at: addr)
        case .IndirectY:
            let addr = memory.read2byte(at: value)
            return memory.read1byte(at: addr + UInt16(self.x))
        default:
            return UInt8(0)
        }
    }

    mutating func setNZ(_ value: UInt8) {
        self.p.z = (value == UInt8(0))
        self.p.n = (value & (1 << 7) != 0)
    }

    mutating func lda(_ inst: Instruction) {
        self.a = read(inst)
        setNZ(self.a)
    }

    mutating func ldx(_ inst: Instruction) {
        self.x = read(inst)
        setNZ(self.x)
    }

    mutating func ldy(_ inst: Instruction) {
        self.y = read(inst)
        setNZ(self.y)
    }

    mutating func sta(_ inst: Instruction) {
        memory.write(at: inst.value!, value: self.a)
    }

    mutating func stx(_ inst: Instruction) {
        memory.write(at: inst.value!, value: self.x)
    }

    mutating func sty(_ inst: Instruction) {
        memory.write(at: inst.value!, value: self.y)
    }

    mutating func tax() {
        self.x = self.a
        setNZ(self.x)
    }

    mutating func tay() {
        self.y = self.a
        setNZ(self.y)
    }

    mutating func tsx() {
        self.x = self.s
        setNZ(self.x)
    }

    mutating func txa() {
        self.a = self.x
        setNZ(self.a)
    }

    mutating func txs() {
        self.s = self.x
        setNZ(self.s)
    }

    mutating func tya() {
        self.a = self.y
        setNZ(self.a)
    }
}
