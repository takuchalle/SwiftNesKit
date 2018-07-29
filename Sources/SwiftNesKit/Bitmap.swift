//
// Extension.swift
//
// Copyright © 2018 Takuya OHASHI. All rights reserved.
//
import Foundation

func RGBImage(data: [UInt8], width: Int, height: Int) -> CGImage? {
    
    let bitsPerComponent = 8
    let numberOfComponents = 3
    let bitsPerPixel = bitsPerComponent * numberOfComponents
    let bytesPerPixel = bitsPerPixel / 8
    
    guard width > 0, height > 0 else { return nil }
    guard width * height * numberOfComponents == data.count else { return nil }
    
    let provider = CGDataProvider(dataInfo: nil, data: data, size: data.count) { _,_,_ in }
    return CGImage(width: width,
                   height: height,
                   bitsPerComponent: bitsPerComponent,
                   bitsPerPixel: bitsPerPixel,
                   bytesPerRow: width * bytesPerPixel,
                   space: CGColorSpaceCreateDeviceRGB(),
                   bitmapInfo: [],
                   provider: provider!,
                   decode: nil,
                   shouldInterpolate: false,
                   intent: .defaultIntent)
}
