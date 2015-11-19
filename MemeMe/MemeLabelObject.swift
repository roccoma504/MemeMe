//
//  MemeLabelObject.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/18/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import Foundation
import UIKit

class MemeLabelObject: NSObject {
    
    // Define object elements.
    var text: String!
    var color: UIColor
    var font : UIFont
    var alignment : NSTextAlignment
    var correction : UITextAutocorrectionType!
    
    // Define an init subprogram.
    init(text: String, color: UIColor, font: UIFont, alignment: NSTextAlignment, correction: UITextAutocorrectionType) {
        self.text = text
        self.color = color
        self.font = font
        self.alignment = alignment
        self.correction = correction
    }
}
