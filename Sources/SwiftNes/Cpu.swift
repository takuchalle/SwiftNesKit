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

    mutating func load(with data: [UInt8]) {
        memory.load(at: 0x8000, data: data)
    }

    mutating func step() {
        let inst = fetch()
        pc = pc + UInt16(inst.bytes)
        exec(inst)
    }

    func fetch() -> Instruction {
        return decoder.decode(memory, pc: self.pc)
    }

    func printInst() {
        print("pc:\(self.pc.hex):  ", fetch())
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
        case .ADC:
            adc(inst)
        case .AND:
            and(inst)
        case .ASL:
            asl(inst)
        case .BIT:
            bit(inst)
        case .CMP:
            cmp(inst)
        case .CPX:
            cpx(inst)
        case .CPY:
            cpy(inst)
        case .DEC:
            dec(inst)
        case .DEX:
            dex(inst)
        case .DEY:
            dex(inst)
        case .EOR:
            eor(inst)
        case .INC:
            inc(inst)
        case .INX:
            inx(inst)
        case .INY:
            inx(inst)
        case .LSR:
            lsr(inst)
        case .ORA:
            ora(inst)
        case .ROL:
            rol(inst)
        case .ROR:
            ror(inst)
        case .SBC:
            sbc(inst)
        case .PHA:
            push(self.a)
        case .PHP:
            push(self.p.bits)
        case .PLA:
            self.a = pop()
            setNZ(self.a)
        case .PLP:
            self.p.bits = pop()
        case .JMP:
            self.pc = address(inst)
        case .JSR:
            push16(self.pc)
            self.pc = address(inst)
        case .RTS:
            self.pc = pop16()
        case .RTI:
            self.p.bits = pop()
            self.pc = pop16()
        case .BCC:
            if self.p.c == false {
                self.pc = address(inst)
            }
        case .BCS:
            if self.p.c == true {
                self.pc = address(inst)
            }
        case .BNE:
            if self.p.z == false {
                self.pc = address(inst)
            }
        case .BEQ:
            if self.p.z == true {
                self.pc = address(inst)
            }
        case .BPL:
            if self.p.n == false {
                self.pc = address(inst)
            }
        case .BMI:
            if self.p.n == true {
                self.pc = address(inst)
            }
        case .BVC:
            if self.p.v == false {
                self.pc = address(inst)
            }
        case .BVS:
            if self.p.v == true {
                self.pc = address(inst)
            }
        case .CLC:
            self.p.c = false
        case .CLI:
            self.p.i = false
        case .CLV:
            self.p.v = false
        case .SEC:
            self.p.c = true
        case .SEI:
            self.p.i = true
        case .BRK:
            self.p.b = true
        case .NOP:
            break /* do nothing */
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

    /* Stack Operation */
    mutating func push16(_ value: UInt16) {
        push(UInt8(value >> 8))
        push(UInt8(value & 0xFF))
    }

    mutating func pop() -> UInt8 {
        self.s = self.s + 1
        return memory.read1byte(at: UInt16(0x100) + UInt16(self.s))
    }

    mutating func pop16() -> UInt16 {
        self.s = self.s + 1
        let data = memory.read2byte(at: UInt16(0x100) + UInt16(self.s))
        self.s = self.s + 1
        return data
    }

    func address(_ inst: Instruction) -> UInt16 {
        guard let value = inst.value else {
            return UInt16(0)
        }

        switch inst.addressing {
        case .ZeroPage, .Absolute:
            return value
        case .ZeroPageX, .AbsoluteX:
            return value + UInt16(self.x)
        case .ZeroPageY, .AbsoluteY:
            return value + UInt16(self.y)
        case .IndirectX:
            return memory.read2byte(at: value + UInt16(self.x))
        case .IndirectY:
            let addr = memory.read2byte(at: value)
            return addr + UInt16(self.x)
        default:
            return UInt16(0)
        }
    }

    func read(_ inst: Instruction) -> UInt8 {
        switch inst.addressing {
        case .Immediate:
            return UInt8(inst.value!)
        default:
            return memory.read1byte(at: address(inst))
        }
    }

    mutating func setNZ(_ value: UInt8) {
        self.p.z = (value == UInt8(0))
        self.p.n = (value & (1 << 7) != 0)
    }
}

/* Executor */
extension CPU {
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

    mutating func adc(_ inst: Instruction) {
        let value: Int = Int(self.a) + Int(read(inst)) + self.p.c.toInt

        self.p.c = (value > 0xFF)
        self.p.v = ((self.a <= 0xFF && 0x80 <= UInt8(value)) ||
            (UInt8(value) <= 0x7F && 0x80 <= self.a))
        self.a = UInt8(value)
        setNZ(self.a)
    }

    mutating func and(_ inst: Instruction) {
        self.a = self.a & read(inst)
        setNZ(self.a)
    }

    mutating func asl(_ inst: Instruction) {
        if inst.addressing == .Accumulator {
            self.p.c = (self.a & 0x1) == 0x1
            self.a = self.a << 1
            setNZ(self.a)
        } else {
            var value: UInt8 = read(inst)
            self.p.c = (value & 0x1) == 0x1
            value = value << 1
            memory.write(at: address(inst), value: value)
            setNZ(value)
        }
    }

    mutating func bit(_ inst: Instruction) {
        let value = read(inst)
        self.p.n = (value >> 7) == 1
        self.p.v = (value >> 6 & 0x1) == 1
        self.p.z = (value & self.a) == 0
    }

    mutating func cmp(_ inst: Instruction) {
        let value = read(inst)
        setNZ(self.a - value)
        self.p.c = self.a >= value
    }

    mutating func cpx(_ inst: Instruction) {
        let value = read(inst)
        setNZ(self.x - value)
        self.p.c = self.x >= value
    }

    mutating func cpy(_ inst: Instruction) {
        let value = read(inst)
        setNZ(self.y - value)
        self.p.c = self.y >= value
    }

    mutating func dec(_ inst: Instruction) {
        let value = read(inst)
        memory.write(at: address(inst), value: value - 1)
        setNZ(value - 1)
    }

    mutating func dex(_ inst: Instruction) {
        self.x = self.x - 1
        setNZ(self.x)
    }

    mutating func dey(_ inst: Instruction) {
        self.y = self.y - 1
        setNZ(self.y)
    }

    mutating func eor(_ inst: Instruction) {
        self.a = self.a ^ read(inst)
        setNZ(self.a)
    }

    mutating func inc(_ inst: Instruction) {
        let value = read(inst)
        memory.write(at: address(inst), value: value + 1)
        setNZ(value + 1)
    }

    mutating func inx(_ inst: Instruction) {
        self.x = self.x + 1
        setNZ(self.x)
    }

    mutating func iny(_ inst: Instruction) {
        self.y = self.y + 1
        setNZ(self.y)
    }

    mutating func lsr(_ inst: Instruction) {
        if inst.addressing == .Accumulator {
            self.p.c = (self.a & 0x1) == 0x1
            self.a = self.a >> 1
            setNZ(self.a)
        } else {
            var value: UInt8 = read(inst)
            self.p.c = (value & 0x1) == 0x1
            value = value >> 1
            memory.write(at: address(inst), value: value)
            setNZ(value)
        }
    }

    mutating func ora(_ inst: Instruction) {
        self.a = self.a | read(inst)
        setNZ(self.a)
    }

    mutating func rol(_ inst: Instruction) {
        let carried: UInt8 = self.p.c ? 0x00 : 0x08

        if inst.addressing == .Accumulator {
            self.p.c = (self.a & 0x1) == 0x1
            self.a = (self.a & carried) << 1
            setNZ(self.a)
        } else {
            var value: UInt8 = read(inst)
            self.p.c = (value & 0x1) == 0x1
            value = (value & carried) << 1
            memory.write(at: address(inst), value: value)
            setNZ(value)
        }
    }

    mutating func ror(_ inst: Instruction) {
        let carried: UInt8 = self.p.c ? 0x00 : 0x08

        if inst.addressing == .Accumulator {
            self.p.c = (self.a & 0x1) == 0x1
            self.a = (self.a & carried) >> 1
            setNZ(self.a)
        } else {
            var value: UInt8 = read(inst)
            self.p.c = (value & 0x1) == 0x1
            value = (value & carried) >> 1
            memory.write(at: address(inst), value: value)
            setNZ(value)
        }
    }

    mutating func sbc(_ inst: Instruction) {
        let value: Int = Int(self.a) - Int(read(inst)) - ~(self.p.c.toInt)
        self.p.c = (value >= 0x00)
        self.p.v = ((self.a <= 0xFF && 0x80 <= UInt8(value)) ||
            (UInt8(value) <= 0x7F && 0x80 <= self.a))
        self.a = UInt8(value)
        setNZ(self.a)
    }
}
