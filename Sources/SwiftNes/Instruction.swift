//
// Instruction.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

struct Instruction {
    enum Opcode {
        case LDA
        case LDX
        case LDY
        case STA
        case STX
        case STY
        case TAX
        case TAY
        case TSX
        case TXA
        case TXS
        case TYA
        case ADC
        case AND
        case ASL
        case BIT
        case CMP
        case CPX
        case CPY
        case DEC
        case DEX
        case DEY
        case EOR
        case INC
        case INX
        case INY
        case LSR
        case ORA
        case ROL
        case ROR
        case SBC
        case PHA
        case PHP
        case PLA
        case PLP
        case JMP
        case JSR
        case RTS
        case RTI
        case BCC
        case BCS
        case BEQ
        case BMI
        case BNE
        case BPL
        case BVC
        case BVS
        case CLC
        case CLD
        case CLI
        case CLV
        case SEC
        case SED
        case SEI
        case BRK
        case NOP
    }
    
    enum Addressing {
        case ZeroPage
        case Relative
        case Implied
        case Absolute
        case Accumulator
        case Immediate
        case ZeroPageX
        case ZeroPageY
        case AbsoluteX
        case AbsoluteY
        case IndirectX
        case IndirectY
        case Indirect
        case None
    }

    let opcode: Opcode 
    let addressing: Addressing
    let bytes: UInt8
    let cycle: UInt8
}
