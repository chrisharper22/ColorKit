//
//  UIImage+AverageColor.swift
//  ColorKit
//
//  Created by Chris Harper on 11/19/21.
//

import UIKit
import SwiftUI

extension UIImage {
    /// Returns a `UIColor` that is the average color of a`UIImage`.
    public func averageUIColor() throws -> UIColor {
        guard let ciImage = CIImage(image: self) else {
            throw ColorKitError.ciImageFailure
        }
        guard let areaAverageFilter = CIFilter(name: "CIAreaAverage") else {
            throw ColorKitError.ciFilterFailure
        }
        areaAverageFilter.setValue(ciImage, forKey: kCIInputImageKey)
        areaAverageFilter.setValue(CIVector(cgRect: ciImage.extent), forKey: "inputExtent")
        guard let outputImage = areaAverageFilter.outputImage else {
            throw ColorKitError.outputImageFailure
        }

        let context = CIContext()
        var bitmap = [UInt8](repeating: 0, count: 4)
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())
        let averageColor = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
        
        return averageColor
    }
    
	/// Returns a `Color` that is the average color of a`UIImage`.
    public func averageColor() throws -> Color {
        return Color(try! averageUIColor())
    }
}
