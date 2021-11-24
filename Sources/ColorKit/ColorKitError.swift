//
//  ColorKitError.swift
//  ColorKit
//
//  Created by Chris Harper on 11/19/21.
//

enum ColorKitError: Error {
    /// An error occured while creating a `CIImage` instance.
    case ciImageFailure
    /// An error occured while creating a `CGImage` instance.
    case cgImageFailure
    /// An error occured while creating a `CIFilter` instance.
    case ciFilterFailure
    /// Failed to get the pixel data from the `CGImage` instance.
    case cgImageDataFailure
    /// An error happened during the creation of the image after applying the filter.
    case outputImageFailure
	
	/// An error occured while processing the given hex code.
	case hexProcessingFailure
	/// An error occured while generate a hex code for a color.
	case hexGenerationFailure
	
	/// An error occured while adjusting the given color.
	case colorAdjustmentFailure
    
    var localizedDescription: String {
        switch self {
        case .ciImageFailure:
            return "Failed to get a `CIImage` instance."
        case .cgImageFailure:
            return "Failed to get a `CGImage` instance."
        case .ciFilterFailure:
            return "Failed to get a `CIFilter instance."
        case .cgImageDataFailure:
            return "Failed to get image data."
        case .outputImageFailure:
            return "Could not get the output image from the filter."
			
		case .hexProcessingFailure:
			return "Failed to process the given hex information."
		case .hexGenerationFailure:
			return "Failed to get a hex from color information."
		
		case .colorAdjustmentFailure:
			return "Failed to adjust the given color."
        }
    }
}
