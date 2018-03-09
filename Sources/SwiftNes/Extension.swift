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

extension Bool {
    var toInt: Int {
        return self ? 1 : 0 
    }
}
