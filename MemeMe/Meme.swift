//
//  Meme.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/18/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import Foundation
import UIKit

// Defines a class of a single meme. Contains all attributes of a meme
// plus the combined image.
struct Meme {
    
    // Define object elements.
    var topText: String!
    var bottomText: String!
    var originalImage: UIImage!
    var memedImage: UIImage!
    
    // Defines a gunction to retrieve the meme.
    func getMeme() -> Meme {
        return self
    }
    
}
