//
// Extension.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

extension UInt16 {
    var hex: String {
        return String(self, radix: 16)
    }
}

extension UInt8 {
    var hex: String {
        return String(self, radix: 16)
    }
}

extension Bool {
    var toInt: Int {
        return self ? 1 : 0 
    }
}

#if os(iOS)
import UIKit
extension UIColor {
    public convenience init(red: UInt8, green: UInt8, blue: UInt8) {
        let divisor = CGFloat(255)
        let red     = CGFloat(red) / divisor
        let green   = CGFloat(green) / divisor
        let blue    = CGFloat(blue) / divisor
        self.init(red: red, green: green, blue: blue, alpha: CGFloat(0xFF))
    }
}
#elseif os(OSX)
import AppKit
extension NSColor {
    public convenience init(red: UInt8, green: UInt8, blue: UInt8) {
        let divisor = CGFloat(255)
        let red     = CGFloat(red) / divisor
        let green   = CGFloat(green) / divisor
        let blue    = CGFloat(blue) / divisor
        self.init(red: red, green: green, blue: blue, alpha: CGFloat(0xFF))
    }
}
#endif
