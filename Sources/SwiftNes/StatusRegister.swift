// 
// StatusRegister.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

struct StatusRegister: CustomStringConvertible {
    var n: Bool /* negative */
    var v: Bool /* overfloe */
    var r: Bool /* reserved */
    var b: Bool /* break */
    var d: Bool /* decimal */
    var i: Bool /* irq disable */
    var z: Bool /* zero */
    var c: Bool /* carry */

    var bits: UInt8 {
        get {
            var reg: UInt8 = 0
            if n {
                reg |= 0x80
            }
            if v {
                reg |= 0x40
            }
            if b {
                reg |= 0x10
            }
            if d {
                reg |= 0x08
            }
            if i {
                reg |= 0x04
            }
            if z {
                reg |= 0x02
            }
            if c {
                reg |= 0x01
            }
            
            return reg
        }

        set(reg) {
            if (reg & (UInt8)(0x80)) != 0 {
                n = true
            }
            if (reg & (UInt8)(0x40)) != 0 {
                v = true
            }
            if (reg & (UInt8)(0x10)) != 0 {
                b = true 
            }
            if (reg & (UInt8)(0x08)) != 0 {
                d = true
            }
            if (reg & (UInt8)(0x04)) != 0 {
                i = true
            }
            if (reg & (UInt8)(0x02)) != 0 {
                z = true
            }
            if (reg & (UInt8)(0x01)) != 0 {
                c = true
            }
        }
    }

    var description: String {
        return "[N: \(self.n.toInt), " +
          "V: \(self.v.toInt), " +
          "B: \(self.b.toInt), " +
          "I: \(self.i.toInt), " +
          "Z: \(self.z.toInt), " +
          "C: \(self.c.toInt)]"
    }

    init() {
        n = false
        v = false
        r = true /* always true */
        b = false
        d = false
        i = false
        z = false
        c = false
    }
}
