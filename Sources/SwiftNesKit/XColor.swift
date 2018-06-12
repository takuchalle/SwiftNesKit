//
// XColor.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

#if os(iOS)
import UIKit
typealias XColor = UIColor
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
typealias XColor = NSColor
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
