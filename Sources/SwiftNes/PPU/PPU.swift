//
// PPU.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

final class PPU {
    var interruptNMI: Bool
    var vram: VRAM

    init() {
        interruptNMI = false
        self.vram = VRAM()
    }

    func load(with data: [UInt8]) {
        vram.memory.load(at: 0x0000, data: data)
    }

    /* Control Register
     * bit7: NMI Interruput enable 0:off, 1:on
     * bit6: select PPU 0: master, 1:slave
     * bit5: sprite size 0:0x8, 1: 0x16
     * bit4: character table base for BG, 0:0x0000, 1:1000
     * bit3: character table base for Sprite, 0:0x0000, 1:1000
     * bit2: VRAM addres increment per CPU read/write of PPUDATA
     *       0: add 1, 1: add 32
     * bit0-1: Base nametable address
     *         00: 0x0000, 01: 0x2400, 10: 0x28000, 11: 0x2C00
     */
    func setPPUCTRL(with value: UInt8) {
        self.interruptNMI = (value & 0x80) != 0
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
