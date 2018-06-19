//
// Pattern.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//


fileprivate let UNIT_SIZE = 8
fileprivate let PATTERN_SIZE = UNIT_SIZE * 2

struct Pattern {
    var data: [[UInt8]]

    init() {
        data = [[UInt8]](repeating: [UInt8](repeating: 0, count: 1), count: 1)
    }

    static func readPattern(_ upper: [UInt8], _ lower: [UInt8]) -> Pattern {
        var pattern = Pattern()
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
