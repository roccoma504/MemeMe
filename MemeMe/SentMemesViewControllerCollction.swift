//
//  SentMemesViewControlletCollction.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/18/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import UIKit

class SentMemesViewControllerCollection: UICollectionViewController {
    
    // Defines a cell identifier.
    private let reuseIdentifier = "cell"
    
    // Defines the inserts for the cells (frame)
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    var receivedMemeArray : Array <MemeObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return receivedMemeArray.count
    }
    
    func memeForIndexPath(indexPath: NSIndexPath) -> UIImage {
        return receivedMemeArray[indexPath.row].memeImaged
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCell
        let memeImage = memeForIndexPath(indexPath)
        cell.backgroundColor = UIColor.blackColor()
        cell.memeImage.image = memeImage
        return cell
    }
}