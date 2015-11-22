//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/17/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import UIKit

// Defines a class that is used to display a fully developed meme in the
// details view.
class MemeDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var memeImage: UIImageView!
    
    var receivedMemeImage : UIImage!
    
    override func viewDidLoad() {
        memeImage.image = receivedMemeImage
    }
}
