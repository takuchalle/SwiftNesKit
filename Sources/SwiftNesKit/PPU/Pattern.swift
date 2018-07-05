//
// Pattern.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//

fileprivate let UNIT_SIZE = 8
fileprivate let PATTERN_SIZE = UNIT_SIZE * 2

fileprivate func bits(fromByte byte: UInt8) -> [UInt8] {
    var byte = byte
    var bits = [UInt8](repeating: 0, count: 8)
    for i in 0..<8 {
        bits[i] = byte & 0x01
        byte >>= 1
    }
    return bits.reversed()
}

struct Pattern {
    var data: [[UInt8]]

    init() {
        data = [[UInt8]](repeating: [UInt8](repeating: 0, count: UNIT_SIZE), count: UNIT_SIZE)
    }

    static func readPattern(_ upper: [UInt8], _ lower: [UInt8]) -> Pattern {
        var pattern = Pattern()

        for i in 0..<UNIT_SIZE {
            var u = bits(fromByte: upper[i])
            var l = bits(fromByte: lower[i])

            for j in 0..<UNIT_SIZE {
                pattern.data[i][j] = u[j] << 0 | l[j] << 1
            }
        }

        return pattern
    }
    
    static func readPatterns(_ data: [UInt8]) -> [Pattern] {
        var patterns = [Pattern]()

        for i in stride(from: 0, to: data.count, by: PATTERN_SIZE) {
            let upper = Array(data[i..<i + UNIT_SIZE])
            let lower = Array(data[i + UNIT_SIZE..<i + PATTERN_SIZE])
            let pattern = readPattern(upper, lower)
            patterns.append(pattern)
        }

        return patterns
    }
}
