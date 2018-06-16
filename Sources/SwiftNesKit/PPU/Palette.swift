//
// Palette.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

fileprivate let ColorTable : [XColor] = [
    XColor.init(red: 0x6D, green: 0x6D, blue: 0x6D), // 0x00
    XColor.init(red: 0x00, green: 0x24, blue: 0x91), // 0x01
    XColor.init(red: 0x00, green: 0x00, blue: 0xDA), // 0x02
    XColor.init(red: 0x6D, green: 0x48, blue: 0xDA), // 0x03
    XColor.init(red: 0x91, green: 0x00, blue: 0x6D), // 0x04
    XColor.init(red: 0xB6, green: 0x00, blue: 0x6D), // 0x05
    XColor.init(red: 0xB6, green: 0x24, blue: 0x00), // 0x06
    XColor.init(red: 0x91, green: 0x48, blue: 0x00), // 0x07
    XColor.init(red: 0x6D, green: 0x48, blue: 0x00), // 0x08
    XColor.init(red: 0x24, green: 0x48, blue: 0x00), // 0x09
    XColor.init(red: 0x00, green: 0x6D, blue: 0x24), // 0x0A
    XColor.init(red: 0x00, green: 0x91, blue: 0x00), // 0x0B
    XColor.init(red: 0x00, green: 0x48, blue: 0x48), // 0x0C
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x0D
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x0E
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x0F
    XColor.init(red: 0xB6, green: 0xB6, blue: 0xB6), // 0x10
    XColor.init(red: 0x00, green: 0x6D, blue: 0xDA), // 0x11
    XColor.init(red: 0x00, green: 0x48, blue: 0xFF), // 0x12
    XColor.init(red: 0x91, green: 0x00, blue: 0xFF), // 0x13
    XColor.init(red: 0xB6, green: 0x00, blue: 0xFF), // 0x14
    XColor.init(red: 0xFF, green: 0x00, blue: 0x91), // 0x15
    XColor.init(red: 0xFF, green: 0x00, blue: 0x00), // 0x16
    XColor.init(red: 0xDA, green: 0x6D, blue: 0x00), // 0x17
    XColor.init(red: 0x91, green: 0x6D, blue: 0x00), // 0x18
    XColor.init(red: 0x24, green: 0x91, blue: 0x00), // 0x19
    XColor.init(red: 0x00, green: 0x91, blue: 0x00), // 0x1A
    XColor.init(red: 0x00, green: 0xB6, blue: 0x6D), // 0x1B
    XColor.init(red: 0x00, green: 0x91, blue: 0x91), // 0x1C
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x1D
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x1E
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x1F
    XColor.init(red: 0xFF, green: 0xFF, blue: 0xFF), // 0x20
    XColor.init(red: 0x6D, green: 0xB6, blue: 0xFF), // 0x21
    XColor.init(red: 0x91, green: 0x91, blue: 0xFF), // 0x22
    XColor.init(red: 0xDA, green: 0x6D, blue: 0xFF), // 0x23
    XColor.init(red: 0xFF, green: 0x00, blue: 0xFF), // 0x24
    XColor.init(red: 0xFF, green: 0x6D, blue: 0xFF), // 0x25
    XColor.init(red: 0xFF, green: 0x91, blue: 0x00), // 0x26
    XColor.init(red: 0xFF, green: 0xB6, blue: 0x00), // 0x27
    XColor.init(red: 0xDA, green: 0xDA, blue: 0x00), // 0x28
    XColor.init(red: 0x6D, green: 0xDA, blue: 0x00), // 0x29
    XColor.init(red: 0x00, green: 0xFF, blue: 0x00), // 0x2A
    XColor.init(red: 0x48, green: 0xFF, blue: 0xDA), // 0x2B
    XColor.init(red: 0x00, green: 0xFF, blue: 0xFF), // 0x2C
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x2D
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x2E
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x2F
    XColor.init(red: 0xFF, green: 0xFF, blue: 0xFF), // 0x30
    XColor.init(red: 0xB6, green: 0xDA, blue: 0xFF), // 0x31
    XColor.init(red: 0xDA, green: 0xB6, blue: 0xFF), // 0x32
    XColor.init(red: 0xFF, green: 0xB6, blue: 0xFF), // 0x33
    XColor.init(red: 0xFF, green: 0x91, blue: 0xFF), // 0x34
    XColor.init(red: 0xFF, green: 0xB6, blue: 0xB6), // 0x35
    XColor.init(red: 0xFF, green: 0xDA, blue: 0x91), // 0x36
    XColor.init(red: 0xFF, green: 0xFF, blue: 0x48), // 0x37
    XColor.init(red: 0xFF, green: 0xFF, blue: 0x6D), // 0x38
    XColor.init(red: 0xB6, green: 0xFF, blue: 0x48), // 0x39
    XColor.init(red: 0x91, green: 0xFF, blue: 0x6D), // 0x3A
    XColor.init(red: 0x48, green: 0xFF, blue: 0xDA), // 0x3B
    XColor.init(red: 0x91, green: 0xDA, blue: 0xFF), // 0x3C
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x3D
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x3E
    XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x3F
]

struct Palette {
    static func read(_ data :[UInt8]) -> [XColor] {
        var palette: [XColor] = []
        
        for i in 0..<4 {
            palette.append(ColorTable[Int(data[i])])
        }
        
        return palette
    }
}
