//
// Decoder.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

import Foundation

struct Decoder {
    let InstructionTable: [UInt8:Instruction] = [
        // LDA: LoaD to A register
        0xA9: Instruction(opcode: .LDA, addressing: .Immediate, bytes: 2, cycle: 2),
        0xA5: Instruction(opcode: .LDA, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xB5: Instruction(opcode: .LDA, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0xAD: Instruction(opcode: .LDA, addressing: .Absolute,  bytes: 3, cycle: 4),
        0xBD: Instruction(opcode: .LDA, addressing: .AbsoluteX, bytes: 3, cycle: 4),
        0xB9: Instruction(opcode: .LDA, addressing: .AbsoluteY, bytes: 3, cycle: 4),
        0xA1: Instruction(opcode: .LDA, addressing: .IndirectX, bytes: 2, cycle: 6),
        0xB1: Instruction(opcode: .LDA, addressing: .IndirectY, bytes: 2, cycle: 5),

        // LDX: LoaD to X register
        0xA2: Instruction(opcode: .LDX, addressing: .Immediate, bytes: 2, cycle: 2),
        0xA6: Instruction(opcode: .LDX, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xB6: Instruction(opcode: .LDX, addressing: .ZeroPageY, bytes: 2, cycle: 4),
        0xAE: Instruction(opcode: .LDX, addressing: .Absolute,  bytes: 3, cycle: 4),
        0xBE: Instruction(opcode: .LDX, addressing: .AbsoluteY, bytes: 3, cycle: 4),

        // LDY: LoaD to Y register
        0xA0: Instruction(opcode: .LDY, addressing: .Immediate, bytes: 2, cycle: 2),
        0xA4: Instruction(opcode: .LDY, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xB4: Instruction(opcode: .LDY, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0xAC: Instruction(opcode: .LDY, addressing: .Absolute,  bytes: 3, cycle: 4),
        0xBC: Instruction(opcode: .LDY, addressing: .AbsoluteX, bytes: 3, cycle: 4),

        // STA: STore from A register
        0x85: Instruction(opcode: .STA, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0x95: Instruction(opcode: .STA, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0x8D: Instruction(opcode: .STA, addressing: .Absolute,  bytes: 3, cycle: 4),
        0x9D: Instruction(opcode: .STA, addressing: .AbsoluteX, bytes: 3, cycle: 5),
        0x99: Instruction(opcode: .STA, addressing: .AbsoluteY, bytes: 3, cycle: 5),
        0x81: Instruction(opcode: .STA, addressing: .IndirectX, bytes: 2, cycle: 6),
        0x91: Instruction(opcode: .STA, addressing: .IndirectY, bytes: 2, cycle: 6),

        // STX: STore from X register
        0x86: Instruction(opcode: .STX, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0x96: Instruction(opcode: .STX, addressing: .ZeroPageY, bytes: 2, cycle: 4),
        0xBE: Instruction(opcode: .STX, addressing: .Absolute,  bytes: 3, cycle: 4),

        // STY: STore from Y register
        0x84: Instruction(opcode: .STX, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0x94: Instruction(opcode: .STX, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0xBC: Instruction(opcode: .STX, addressing: .Absolute,  bytes: 3, cycle: 4),

        // TAX: Transfer from A to X
        0xAA: Instruction(opcode: .TAX, addressing: .Implied,  bytes: 1, cycle: 2),

        // TAY: Transfer from A to Y
        0xA8: Instruction(opcode: .TAY, addressing: .Implied,  bytes: 1, cycle: 2),

        // TSX: Transfer from S to X
        0xBA: Instruction(opcode: .TSX, addressing: .Implied,  bytes: 1, cycle: 2),

        // TXA: Transfer from X to A
        0x8A: Instruction(opcode: .TXA, addressing: .Implied,  bytes: 1, cycle: 2),

        // TXS: Transfer from X to S
        0x9A: Instruction(opcode: .TXS, addressing: .Implied,  bytes: 1, cycle: 2),

        // TYA: Transfer from X to S
        0x98: Instruction(opcode: .TYA, addressing: .Implied,  bytes: 1, cycle: 2),

        // ADC: ADd with Carry flag to a register
        0x69: Instruction(opcode: .ADC, addressing: .Immediate, bytes: 2, cycle: 2),
        0x65: Instruction(opcode: .ADC, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0x75: Instruction(opcode: .ADC, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0x6D: Instruction(opcode: .ADC, addressing: .Absolute,  bytes: 3, cycle: 4),
        0x7D: Instruction(opcode: .ADC, addressing: .AbsoluteX, bytes: 3, cycle: 4),
        0x79: Instruction(opcode: .ADC, addressing: .AbsoluteY, bytes: 3, cycle: 4),
        0x61: Instruction(opcode: .ADC, addressing: .IndirectX, bytes: 2, cycle: 6),
        0x71: Instruction(opcode: .ADC, addressing: .IndirectY, bytes: 2, cycle: 5),

        // AND: AND
        0x29: Instruction(opcode: .AND, addressing: .Immediate, bytes: 2, cycle: 2),
        0x25: Instruction(opcode: .AND, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0x35: Instruction(opcode: .AND, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0x2D: Instruction(opcode: .AND, addressing: .Absolute,  bytes: 3, cycle: 4),
        0x3D: Instruction(opcode: .AND, addressing: .AbsoluteX, bytes: 3, cycle: 4),
        0x39: Instruction(opcode: .AND, addressing: .AbsoluteY, bytes: 3, cycle: 4),
        0x21: Instruction(opcode: .AND, addressing: .IndirectX, bytes: 2, cycle: 6),
        0x31: Instruction(opcode: .AND, addressing: .IndirectY, bytes: 2, cycle: 5),

        // ASL:
        0x0A: Instruction(opcode: .ASL, addressing: .Accumulator, bytes: 1, cycle: 2),
        0x06: Instruction(opcode: .ASL, addressing: .ZeroPage,    bytes: 2, cycle: 5),
        0x16: Instruction(opcode: .ASL, addressing: .ZeroPageX,   bytes: 2, cycle: 6),
        0x0E: Instruction(opcode: .ASL, addressing: .Absolute,    bytes: 3, cycle: 6),
        0x1E: Instruction(opcode: .ASL, addressing: .AbsoluteX,   bytes: 3, cycle: 7),

        // BIT:
        0x24: Instruction(opcode: .BIT, addressing: .ZeroPage, bytes: 2, cycle: 3),
        0x2C: Instruction(opcode: .BIT, addressing: .Absolute, bytes: 3, cycle: 4),

        // CMP: CoMPare with a register
        0xC9: Instruction(opcode: .CMP, addressing: .Immediate, bytes: 2, cycle: 2),
        0xC5: Instruction(opcode: .CMP, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xD5: Instruction(opcode: .CMP, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0xCD: Instruction(opcode: .CMP, addressing: .Absolute,  bytes: 3, cycle: 4),
        0xDD: Instruction(opcode: .CMP, addressing: .AbsoluteX, bytes: 3, cycle: 4),
        0xD9: Instruction(opcode: .CMP, addressing: .AbsoluteY, bytes: 3, cycle: 4),
        0xC1: Instruction(opcode: .CMP, addressing: .IndirectX, bytes: 2, cycle: 6),
        0xD1: Instruction(opcode: .CMP, addressing: .IndirectY, bytes: 2, cycle: 5),

        // CPX: ComPare with X register
        0xE0: Instruction(opcode: .CPX, addressing: .Immediate, bytes: 2, cycle: 2),
        0xE4: Instruction(opcode: .CPX, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xEC: Instruction(opcode: .CPX, addressing: .Absolute,  bytes: 3, cycle: 4),

        // CPY: ComPare with Y register
        0xC0: Instruction(opcode: .CPY, addressing: .Immediate, bytes: 2, cycle: 2),
        0xC4: Instruction(opcode: .CPY, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xCC: Instruction(opcode: .CPY, addressing: .Absolute,  bytes: 3, cycle: 4),

        // DEC: DECrement
        0xC6: Instruction(opcode: .DEC, addressing: .ZeroPage,  bytes: 2, cycle: 5),
        0xD6: Instruction(opcode: .DEC, addressing: .ZeroPageX, bytes: 2, cycle: 6),
        0xCE: Instruction(opcode: .DEC, addressing: .Absolute,  bytes: 3, cycle: 6),
        0xDE: Instruction(opcode: .DEC, addressing: .AbsoluteX, bytes: 3, cycle: 7),

        // DEX: DEcrement X register
        0xCA: Instruction(opcode: .DEX, addressing: .Implied, bytes: 1, cycle: 2),

        // DEY: DEcrement Y register
        0x88: Instruction(opcode: .DEY, addressing: .Implied, bytes: 1, cycle: 2),

        // INC: INCrement
        0xE6: Instruction(opcode: .INC, addressing: .ZeroPage,  bytes: 2, cycle: 5),
        0xF6: Instruction(opcode: .INC, addressing: .ZeroPageX, bytes: 2, cycle: 6),
        0xEE: Instruction(opcode: .INC, addressing: .Absolute,  bytes: 3, cycle: 6),
        0xFE: Instruction(opcode: .INC, addressing: .AbsoluteX, bytes: 3, cycle: 7),

        // INX: INcrement X register
        0xE8: Instruction(opcode: .INX, addressing: .Implied,  bytes: 1, cycle: 6),

        // INY: INcrement Y register
        0xC8: Instruction(opcode: .INY, addressing: .Implied,  bytes: 1, cycle: 6),

        // LSR:
        0x4A: Instruction(opcode: .LSR, addressing: .Accumulator, bytes: 1, cycle: 2),
        0x46: Instruction(opcode: .LSR, addressing: .ZeroPage,    bytes: 2, cycle: 5),
        0x56: Instruction(opcode: .LSR, addressing: .ZeroPageX,   bytes: 2, cycle: 6),
        0x4E: Instruction(opcode: .LSR, addressing: .Absolute,    bytes: 3, cycle: 6),
        0x5E: Instruction(opcode: .LSR, addressing: .AbsoluteX,   bytes: 3, cycle: 7),

        // ORA:
        0x09: Instruction(opcode: .ORA, addressing: .Immediate, bytes: 2, cycle: 2),
        0x05: Instruction(opcode: .ORA, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0x15: Instruction(opcode: .ORA, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0x0D: Instruction(opcode: .ORA, addressing: .Absolute,  bytes: 3, cycle: 4),
        0x1D: Instruction(opcode: .ORA, addressing: .AbsoluteX, bytes: 3, cycle: 4),
        0x19: Instruction(opcode: .ORA, addressing: .AbsoluteX, bytes: 3, cycle: 4),
        0x01: Instruction(opcode: .ORA, addressing: .AbsoluteX, bytes: 2, cycle: 6),
        0x11: Instruction(opcode: .ORA, addressing: .AbsoluteX, bytes: 2, cycle: 5),

        // ROL: Rotate A register Left
        0x2A: Instruction(opcode: .ROL, addressing: .Accumulator, bytes: 1, cycle: 2),
        0x26: Instruction(opcode: .ROL, addressing: .ZeroPage,    bytes: 2, cycle: 5),
        0x36: Instruction(opcode: .ROL, addressing: .ZeroPageX,   bytes: 2, cycle: 6),
        0x2E: Instruction(opcode: .ROL, addressing: .Absolute,    bytes: 3, cycle: 6),
        0x3E: Instruction(opcode: .ROL, addressing: .AbsoluteX,   bytes: 3, cycle: 7),

        // ROR: Rotate A register Right
        0x6A: Instruction(opcode: .ROR, addressing: .Accumulator, bytes: 1, cycle: 2),
        0x66: Instruction(opcode: .ROR, addressing: .ZeroPage,    bytes: 2, cycle: 5),
        0x76: Instruction(opcode: .ROR, addressing: .ZeroPageX,   bytes: 2, cycle: 6),
        0x6E: Instruction(opcode: .ROR, addressing: .Absolute,    bytes: 3, cycle: 6),
        0x7E: Instruction(opcode: .ROR, addressing: .AbsoluteX,   bytes: 3, cycle: 7),

        // SBC: SuBtracton with Carry flag
        0xE9: Instruction(opcode: .SBC, addressing: .Immediate, bytes: 2, cycle: 2),
        0xE5: Instruction(opcode: .SBC, addressing: .ZeroPage,  bytes: 2, cycle: 3),
        0xF5: Instruction(opcode: .SBC, addressing: .ZeroPageX, bytes: 2, cycle: 4),
        0xED: Instruction(opcode: .SBC, addressing: .Absolute,  bytes: 3, cycle: 4),
        0xFD: Instruction(opcode: .SBC, addressing: .AbsoluteX, bytes: 3, cycle: 4),
        0xF9: Instruction(opcode: .SBC, addressing: .AbsoluteY, bytes: 3, cycle: 4),
        0xE1: Instruction(opcode: .SBC, addressing: .IndirectX, bytes: 2, cycle: 6),
        0xF1: Instruction(opcode: .SBC, addressing: .IndirectX, bytes: 2, cycle: 5),

        // PHA: Push A register to Stack
        0x48: Instruction(opcode: .PHA, addressing: .Implied, bytes: 1, cycle: 3),

        // PHP: Push P register to Stack
        0x08: Instruction(opcode: .PHP, addressing: .Implied, bytes: 1, cycle: 3),

        // PLA: Pop from stack to A register
        0x68: Instruction(opcode: .PLA, addressing: .Implied, bytes: 1, cycle: 4),

        // PLP: Pop from stack to P register
        0x28: Instruction(opcode: .PLP, addressing: .Implied, bytes: 1, cycle: 1),

        // JMP:
        0x4C: Instruction(opcode: .JMP, addressing: .Absolute, bytes: 3, cycle: 3),
        0x6C: Instruction(opcode: .JMP, addressing: .Indirect, bytes: 3, cycle: 5),

        // JSR:
        0x20: Instruction(opcode: .JSR, addressing: .Absolute, bytes: 3, cycle: 6),

        // RTS:
        0x60: Instruction(opcode: .RTS, addressing: .Implied, bytes: 1, cycle: 6),

        // RTI:
        0x40: Instruction(opcode: .RTI, addressing: .Implied, bytes: 1, cycle: 6),

        // BCC:
        0x90: Instruction(opcode: .BCC, addressing: .Relative, bytes: 2, cycle: 2),

        // BCS:
        0xB0: Instruction(opcode: .BCS, addressing: .Relative, bytes: 2, cycle: 2),

        // BEQ:
        0xF0: Instruction(opcode: .BEQ, addressing: .Relative, bytes: 2, cycle: 2),

        // BMI:
        0x30: Instruction(opcode: .BMI, addressing: .Relative, bytes: 2, cycle: 2),

        // BNE:
        0xD0: Instruction(opcode: .BNE, addressing: .Relative, bytes: 2, cycle: 2),

        // BPL:
        0x10: Instruction(opcode: .BPL, addressing: .Relative, bytes: 2, cycle: 2),

        // BVC:
        0x50: Instruction(opcode: .BVC, addressing: .Relative, bytes: 2, cycle: 2),

        // BVS:
        0x70: Instruction(opcode: .BVS, addressing: .Relative, bytes: 2, cycle: 2),

        // CLC: Clear Carry flag
        0x18: Instruction(opcode: .CLC, addressing: .Implied, bytes: 1, cycle: 2),

        // CLD:
        0xD8: Instruction(opcode: .CLD, addressing: .Implied, bytes: 1, cycle: 2),

        // CLI:
        0x58: Instruction(opcode: .CLI, addressing: .Implied, bytes: 1, cycle: 2),

        // CLV:
        0xB8: Instruction(opcode: .CLV, addressing: .Implied, bytes: 1, cycle: 2),

        // SEC: Set Carry Flag
        0x38: Instruction(opcode: .SEC, addressing: .Implied, bytes: 1, cycle: 2),

        // SED:
        0xF8: Instruction(opcode: .SED, addressing: .Implied, bytes: 1, cycle: 2),

        // SEI: Disable Interrupt
        0x78: Instruction(opcode: .SEI, addressing: .Implied, bytes: 1, cycle: 2),

        // BRK: Break
        0x00: Instruction(opcode: .SEI, addressing: .Implied, bytes: 1, cycle: 7),

        // NOP: No Operation
        0xEA: Instruction(opcode: .NOP, addressing: .Implied, bytes: 1, cycle: 2),
        ]

    func decode(opcode op: UInt8) -> Instruction {
        guard let _op = InstructionTable[op] else {
            fatalError()
        }
        return _op;
    }

    func decodeAll() {
    }
}
