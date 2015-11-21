//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/17/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var memeImage: UIImageView!
    
    var receivedMemeImage : UIImage!
    
    override func viewDidLoad() {
        memeImage.image = receivedMemeImage
    }
}
