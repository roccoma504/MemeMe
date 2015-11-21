//
//  MemeArrayObject.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/20/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import Foundation
import UIKit

class MemeArrayObject: NSObject {
    
    // Define object elements.
    private var memeArray : Array <UIImage> = []
    
    func setMeme (Meme : UIImage) {
    memeArray.append(Meme)
    }
    
    func getMeme() -> Array <UIImage> {
    return memeArray
    }
}

