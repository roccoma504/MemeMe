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
    var color: UIColor
    var alignment : NSTextAlignment
    var correction : UITextAutocorrectionType!
    
    // Define an init subprogram.
    init(color: UIColor, alignment: NSTextAlignment, correction: UITextAutocorrectionType) {
        self.color = color
        self.alignment = alignment
        self.correction = correction
    }
}
