//
//  MemeObject.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/18/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import Foundation
import UIKit

class MemeObject: NSObject {
    
    // Define object elements.
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memeImage: UIImage!
    
    // Define an init subprogram.
    init(topText: String, bottomText: String, originalImage: UIImage, memeImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memeImage = memeImage
    }
}
