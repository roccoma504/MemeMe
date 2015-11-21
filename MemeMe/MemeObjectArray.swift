//
//  MemeObjectArray.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/19/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import Foundation

class MemeObjectArray: NSObject {
    
    var memeArray : Array <MemeObject> = []
    
    
    func pushMeme(Meme: MemeObject) {
        memeArray.append(Meme)
    }
    
    func getArray() -> Array <MemeObject> {
        return memeArray
    }
    
}