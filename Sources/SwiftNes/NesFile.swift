// 
// NesFile.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//
import Foundation

fileprivate let headerSize = 16
fileprivate let magicSize = 4

// MagicCode is placed in top of header
fileprivate func checkMagic(_ magic: Data) -> Bool {
	return (magic[0] == 0x4E &&
            magic[1] == 0x45 &&
            magic[2] == 0x53 &&
            magic[3] == 0x1A)
}

struct NesFile {
	let Program: [UInt8]
	let Character: [UInt8]
    let programSize: Int
    let characterSize: Int

	private let programSizeUnit = 16 * 1024
	private let characterSizeUnit = 8 * 1024

	init?(_ data: Data) {
		guard checkMagic(data.subdata(in: 0..<magicSize)) else {
			return nil
		}
		self.programSize = Int(data[4]) * programSizeUnit
		self.characterSize = Int(data[5]) * characterSizeUnit

        let programBottom = headerSize + programSize
		Program = [UInt8](data.subdata(in: headerSize..<programBottom))
		Character = [UInt8](data.subdata(in: programBottom..<(programBottom + characterSize)))
	}
}
