//
//  MemeObject.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/18/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import Foundation
import UIKit

// Defines a class of a single meme. Contains all attributes of a meme
// plus the combined image.
class MemeObject: NSObject {
    
    // Define object elements.
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memeImaged: UIImage!
    
    override init() {
        super.init()
    }
    
    // Defines a function to save the meme.
    func saveMeme (topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memeImaged = memedImage
    }
    
    // Defines a gunction to retrieve the meme.
    func getMeme() -> MemeObject {
        return self
    }
    
}
