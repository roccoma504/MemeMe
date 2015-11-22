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
    
    // Defines a single meme image to be passed to the detail view.
    private var detailMemeImage : UIImage!
    
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
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        detailMemeImage = receivedMemeArray[indexPath.row].memeImaged
        self.performSegueWithIdentifier("collectionToDetailSegue", sender: nil)
    }
    
    
    // Defines a function that is invoked when the cancel button is pressed.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
    if (segue.identifier == "collectionToDetailSegue")
        {
            let detailVC:MemeDetailViewController = segue.destinationViewController as! MemeDetailViewController
            detailVC.receivedMemeImage = detailMemeImage
        }
    }
}