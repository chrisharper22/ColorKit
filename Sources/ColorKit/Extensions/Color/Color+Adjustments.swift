//
//  Color+Adjustments.swift
//  
//
//  Created by Chris Harper on 11/24/21.
//

import SwiftUI

extension Color {
	///Brighten a `Color`.
	/// - Parameters:
	///    - percentage: the amount (`CGFloat`) to brighten by. Default is `30.0`.
	public func lighten(by percentage: CGFloat = 30.0) throws -> Color {
		return try self.adjustBrightness(by: abs(percentage) )
	}
	
	///Darken a `UIColor`.
	/// - Parameters:
	///    - percentage: the amount (`CGFloat`) to darken by. Default is `30.0`.
	public func darken(by percentage: CGFloat = 30.0) throws -> Color {
		return try self.adjustBrightness(by: -1 * abs(percentage) )
	}
	
	func adjustBrightness(by percentage: CGFloat = 30.0) throws -> Color {
		let uiColor = UIColor(self)
		var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
		if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			return Color(UIColor(red: min(red + percentage/100, 1.0), green: min(green + percentage/100, 1.0), blue: min(blue + percentage/100, 1.0), alpha: alpha))
		} else {
			throw ColorKitError.colorAdjustmentFailure
		}
	}
	
	///Saturate a `Color`.
	/// - Parameters:
	///    - percentage: the amount (`CGFloat`) to saturate by. Default is `30.0`.
	public func saturate(by percentage: CGFloat = 30.0) throws -> Color {
		return try self.adjustSaturation(by: abs(percentage))
	}
	
	///Desaturate a `CColor`.
	/// - Parameters:
	///    - percentage: the amount (`CGFloat`) to desaturate by. Default is `30.0`.
	public func desaturate(by percentage: CGFloat = 30.0) throws -> Color {
		return try self.adjustSaturation(by: -1 * abs(percentage))
	}
	
	func adjustSaturation(by percentage: CGFloat = 30.0) throws -> Color {
		let uiColor = UIColor(self)
		var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
		if uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
			return Color(UIColor(hue: hue, saturation: min(saturation + percentage / 100, 1.0), brightness: brightness, alpha: alpha))
		} else {
			throw ColorKitError.colorAdjustmentFailure
		}
	}
}
