//
//  UIColor+Hex.swift
//  ColorKit
//
//  Created by Chris Harper on 11/19/21.
//

import UIKit

extension UIColor {
	///Creates a `UIColor` instance from a given hex code, with an optional alpha as `CGFloat` if it is not given in the hex.
    public convenience init?(hex: Int, alpha: CGFloat? = nil) throws {
        let length  = String(hex).count
        if length == 6 {
			self.init(red: CGFloat((hex >> 16) & 0xFF), green: CGFloat((hex >> 8) & 0xFF), blue: CGFloat(hex & 0xFF), alpha: alpha ?? 1.0)
        } else if length == 8 && alpha == nil {
            self.init(red: CGFloat((hex >> 32) & 0xFF), green: CGFloat((hex >> 16) & 0xFF), blue: CGFloat((hex >> 8) & 0xFF), alpha: CGFloat(hex & 0xFF))
        } else {
			throw ColorKitError.hexProcessingFailure
        }
    }
    
	///Creates a `UIColor` instance from a given hex code.
	public convenience init?(hexString: String, alpha: CGFloat? = nil) throws {
        var hexSanitized = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
		guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { throw ColorKitError.hexProcessingFailure }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 && alpha != nil {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
			throw ColorKitError.hexProcessingFailure
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
	///Generates a hex string of the given `UIColor`.
	///
	/// - Parameters:
	///    - withAlpha:a `Bool` indicating whether the hex string should include the alpha as the last two characters. Default is `false`.
	public func asHexString(withAlpha alpha: Bool = false) throws -> String {
        guard let components = cgColor.components, components.count >= 3 else {
			throw ColorKitError.hexGenerationFailure
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}
