//
//  SentMemesViewController
//  MemeMe
//
//  Created by Matthew Rocco on 11/17/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import UIKit

class SentMemesViewControllerTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // IBOutlets.
    @IBOutlet weak var memeTable: UITableView!
    
    // Define the cell identifier for filling the table cells.
    private let textCellIdentifier = "tableCell"
    
    // Defines a single meme image to be passed to the detail view.
    private var detailMemeImage : UIImage!
    
    // Defines an array that contains all of the users memes.
    var receivedMemeArray : Array <MemeObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates.
        memeTable.delegate = self
        memeTable.dataSource = self
    }

    override func viewDidAppear(animated: Bool) {
        // Define a constant of all of the tabs embeded in the tab bar controller.
        let navControllers = self.tabBarController?.viewControllers
        
        // Define a constant of the collection view and pass the array
        // of memes to it. This table view is the first one to appear after
        // memes are added so we want to pass the data here.
        let collectionNavViewController = navControllers![1] as! UINavigationController
        let collectionViewController = collectionNavViewController.viewControllers[0] as! SentMemesViewControllerCollection
        collectionViewController.receivedMemeArray = receivedMemeArray
    }
    
    //#MARK UITable subprograms
    
    // Returns the number of sections in the table.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Defines the number of cells in the section, this scales depending on
    // the number of memes.    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedMemeArray.count
    }
    
    // Define the cell.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let row = indexPath.row
        
        // Here we check to ensure that each element of the cell is non nil.
        // If the particular element is good, set it to the portion of the cell.
        if let memeImage = self.view.viewWithTag(1) as? UIImageView {
            memeImage.image = receivedMemeArray[row].memeImaged
        }
        if let topLabel = self.view.viewWithTag(2) as? UILabel {
            topLabel.text = receivedMemeArray[row].topText
        }
        if let botLabel = self.view.viewWithTag(3) as? UILabel {
            botLabel.text = receivedMemeArray[row].bottomText
        }
        return cell
    }
    
    // When the cell is chosen segue to the detil view.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        detailMemeImage = receivedMemeArray[indexPath.row].memeImaged
        self.performSegueWithIdentifier("tableToDetailSegue", sender: nil)
    }
    
    // Prepare the data for segue.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If the user has successfully picked an image then pass the data.
        // If we dont check this here the app will crash.
        if (segue.identifier == "tableAddSegue") {
            let navigationController = segue.destinationViewController as! UINavigationController
            let destView = navigationController.viewControllers[0] as! MemeEditorViewController
            destView.receivedMemeArray = receivedMemeArray
        }
        else if (segue.identifier == "tableToDetailSegue") {
            let detailVC:MemeDetailViewController = segue.destinationViewController as! MemeDetailViewController
            detailVC.receivedMemeImage = detailMemeImage
        }
    }
}

