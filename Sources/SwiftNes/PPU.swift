//
// PPU.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

final class PPU {
    var interruptNMI: Bool

    init() {
        interruptNMI = false
    }

    /* Control Register 1
     * bit7: NMI Interruput enable 0:off, 1:on
     * bit6: select PPU 0: master, 1:slave
     * bit5: sprite size 0:8x8, 1: 8x16
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
}
