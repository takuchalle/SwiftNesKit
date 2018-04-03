//
// PPU.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

final class PPU {
    var vram: VRAM

    /* For Control Register */
    var interruptNMI: Bool
    var selectPPU: UInt8 /* 0: master, 1:slave*/
    var spriteSize: UInt8
    var tableBaseForBG: UInt16
    var tableBaseForSprite: UInt16
    var addressIncStep: UInt8
    var nametableBase: UInt16

    init() {
        interruptNMI = false
        self.vram = VRAM()

        self.selectPPU = 0
        self.spriteSize = 0x8
        self.tableBaseForBG = 0x0000
        self.tableBaseForSprite = 0x0000
        self.addressIncStep = 1
        self.nametableBase = 0x0000
    }

    func load(with data: [UInt8]) {
        vram.memory.load(at: 0x0000, data: data)
    }

    /* Control Register
     * bit7: NMI Interruput enable 0:off, 1:on
     * bit6: select PPU 0: master, 1:slave
     * bit5: sprite size 0:0x8, 1: 0x16
     * bit4: character table base for BG, 0:0x0000, 1:0x1000
     * bit3: character table base for Sprite, 0:0x0000, 1:0x1000
     * bit2: VRAM addres increment per CPU read/write of PPUDATA
     *       0: add 1, 1: add 32
     * bit0-1: Base nametable address
     *         00: 0x0000, 01: 0x2400, 10: 0x28000, 11: 0x2C00
     */
    func setPPUCTRL(with value: UInt8) {
        self.interruptNMI       =  (value & 0x80) != 0
        self.selectPPU          = ((value & 0x40) != 0) ? 1 : 2
        self.spriteSize         = ((value & 0x20) != 0) ? 0x8 : 0x16
        self.tableBaseForBG     = ((value & 0x10) != 0) ? 0x0000 : 0x1000
        self.tableBaseForSprite = ((value & 0x08) != 0) ? 0x0000 : 0x1000
        self.addressIncStep     = ((value & 0x04) != 0) ? 1 : 32
        switch value & 0b11 {
        case 0b00:
            self.nametableBase = 0x0000
        case 0b01:
            self.nametableBase = 0x2400
        case 0b10:
            self.nametableBase = 0x2800
        case 0b11:
            self.nametableBase = 0x2C00
        default:
            self.nametableBase = 0x0000
        }
    }

    /* Mask Register
     * bit7: Emphasize blue
     * bit6: Emphasize green
     * bit5: Emphasize red
     * bit4: Show sprite 0:hide
     * bit3: Show Background 0:hide
     * bit2: Show sprite in leftmost 8 pixel 0:hide
     * bit1: Show Background in leftmost 8 pixel 0:hide
     * bit0: Greyscale 0:color, 1: grayscale
     */
    func setPPUMASK(with value: UInt8) {
    }

    func setVRAMAddress(with addr: UInt8) {
        self.vram.setAddress(with: addr)
    }
}
