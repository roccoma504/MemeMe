//
//  SentMemesViewControlletCollction.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/18/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import UIKit

class SentMemesViewControllerCollection: UICollectionViewController {
    
    // Private variables.
    
    // Defines a cell identifier.
    private let reuseIdentifier = "cell"
    
    // Defines a single meme image to be passed to the detail view.
    private var detailMemeImage : UIImage!
    
    // Public variables.
    
    // Defines an array of meme objects that is retrieved from the table view.
    var receivedMemeArray : Array <Meme> = []
    
    // Defines the number of sections in the collection.
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Defines the number of cells in the section, this scales depending on
    // the number of memes.
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return receivedMemeArray.count
    }
    
    // Returns the image based on which cell we are trying to fill.
    func memeForIndexPath(indexPath: NSIndexPath) -> UIImage {
        return receivedMemeArray[indexPath.row].memedImage
    }
    
    // Configures and returns the cell.
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MemeCell
        let cellMemeImage = memeForIndexPath(indexPath)
        cell.backgroundColor = UIColor.grayColor()
        // Set the image for the UIImageView.
        cell.memeImage.image = cellMemeImage
        return cell
    }
    
    // When the item in the collection is selected transistion to the detail
    // view.
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        detailMemeImage = receivedMemeArray[indexPath.row].memedImage
        performSegueWithIdentifier("collectionToDetailSegue", sender: nil)
    }
    
    // Prepare the data when the segue occurs.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "collectionToDetailSegue") {
            let detailVC:MemeDetailViewController = segue.destinationViewController as! MemeDetailViewController
            detailVC.receivedMemeImage = detailMemeImage
        }
        else if (segue.identifier == "collectionAddSegue") {
            let navigationController = segue.destinationViewController as! UINavigationController
            let destView = navigationController.viewControllers[0] as! MemeEditorViewController
            destView.newSentMemeArray = receivedMemeArray
            destView.receivedMemeArray = receivedMemeArray
        }
    }
}