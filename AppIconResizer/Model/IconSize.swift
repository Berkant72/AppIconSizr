//
//  IconSize.swift
//  AppIconResizer
//
//  Created by Berkant Dursun on 21.11.20.
//

import SwiftUI

enum IconSet {
    case iOS, macOS, watchOS
}

enum RetinaType {
    case x1 // no Retina
    case x2 // Retina (double resolution)
    case x3 // Super Retina (triple resolution)
}


struct IconSize {
    var sideLength: Double
    var x1, x2, x3: Bool
    
    init(_ sideLength: CGFloat, _ x1: Bool, _ x2: Bool, _ x3: Bool) {
        self.sideLength = Double(sideLength)
        self.x1 = x1
        self.x2 = x2
        self.x3 = x3
    }
    
    static func getSizes(set: IconSet) -> [IconSize] {
        switch set {
        case .iOS:
            return IconSize.iosSizes()
        case .macOS:
            return IconSize.macosSizes()
        case .watchOS:
            return IconSize.watchosSize()
        }
    }
    
    private static func iosSizes() -> [IconSize] {
        
        return [
            // iPhone
            IconSize(20, false, true, true),
            IconSize(29, false, true, true),
            IconSize(40, false, true, true),
            IconSize(60, false, true, true),
            
            // iPad
            IconSize(20, false, true, true),
            IconSize(29, true, true, false),
            IconSize(40, true, true, false),
            IconSize(76, true, true, false),
            IconSize(83.5, false, true, false),
            
            // App Store
            IconSize(1024, true, false, false)
        ]
        
    }
    
    private static func macosSizes() -> [IconSize] {
        return [
            // macOS
            IconSize(20, false, true, true),
            IconSize(29, false, true, true),
            IconSize(40, false, true, true),
            IconSize(60, false, true, true),
            
            
            // App Store
            IconSize(1024, true, false, false)
        ]
    }
    
    private static func watchosSize() -> [IconSize] {
        return [
            // watchOS
            IconSize(20, false, true, true),
            IconSize(29, false, true, true),
            IconSize(40, false, true, true),
            IconSize(60, false, true, true),
            
            
            // App Store
            IconSize(1024, true, false, false)
        ]
    }
    
    private func scale(_ icon: NSImage, to type: RetinaType) -> CGImage? {
        // new size
        let newlength: Int
        
        switch type {
        case .x1:
            newlength = Int(sideLength)
        case .x2:
            newlength = Int(sideLength * 2)
        case .x3:
            newlength = Int(sideLength * 3)
        }
        
        // NSImage --> CGImage
        var rect = CGRect(x: 0, y: 0, width: icon.size.width, height: icon.size.height)
        
        
        if let cgimg = icon.cgImage(forProposedRect: &rect, context: nil, hints: nil) {
            // scale CGImage
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo (rawValue : CGImageAlphaInfo.premultipliedLast.rawValue)
            let context = CGContext(
                data: nil,
                width: newlength,
                height: newlength,
                bitsPerComponent: 8,
                bytesPerRow: 0,
                space: colorSpace,
                bitmapInfo : bitmapInfo.rawValue)
            context!.interpolationQuality = .high
            let newrect = CGRect(x: 0, y: 0, width: newlength, height: newlength)
            // draw scaled Bitmap
            context?.draw(cgimg, in: newrect)
            // return as CGImage
            return context?.makeImage() }
            // something wrong
            return nil
        }
    
    
    // scale icons and save in given or temporary folder with name
    
    func save(_ icon: NSImage, type: RetinaType , folder: String ) -> String {
        let name = IconSize.iconName(prefix: "icon_", sideLength: sideLength, type: type)
        let folderName = NSString(string: folder).appendingPathComponent(name)
        if let img = scale(icon, to: type) {
            if savePNG(img, in: folderName) {
                return folderName // return folder name
            }
        }
        return "" // something wrong
    }
    
    // save CGImage in PNG
    
    private func savePNG(_ img: CGImage, in fName: String) -> Bool {
        let url = URL(fileURLWithPath: fName)
        if let dest = CGImageDestinationCreateWithURL(url as CFURL, kUTTypePNG, 1, nil) {
            CGImageDestinationAddImage(dest, img, nil)
            return CGImageDestinationFinalize(dest)
        }
        // something wrong
        return false
    }
    
    // create icon name:
    // iconName(prefix: "icon_", sidelength: 40, type: X2)
    // return icon_40x40@2x .png
    
    static func iconName(prefix: String, sideLength: Double, type rType: RetinaType) -> String {
        // convert sidelength in NSNumber
        let sideNmb = NSNumber(value: sideLength)
        
        // show as floating point, comma as divider
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.locale = Locale(identifier: "en_US")
        
        let txt = formatter.string(from: sideNmb)!
        
        var result = prefix + txt + "x" + txt
        if rType == .x2 { result += "@2x" }
        if rType == .x3 { result += "@3x" }
        result += ".png"
        
        return result
        
    }
}


