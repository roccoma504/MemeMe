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
    
    
    let textCellIdentifier = "tableCell"
    
    var receivedMemeArray : Array <MemeObject> = []
    
    var detailMemeImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates.
        memeTable.delegate = self
        memeTable.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#MARK UITable subprograms
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedMemeArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let row = indexPath.row
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        detailMemeImage = receivedMemeArray[indexPath.row].memeImaged
        
        self.performSegueWithIdentifier("tableToDetailSegue", sender: nil)

    }
    
    // Defines a function that is invoked when the cancel button is pressed.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // If the user has successfully picked an image then pass the data.
        // If we dont check this here the app will crash.
        if (segue.identifier == "tableAddSegue")
        {
            let navigationController = segue.destinationViewController as! UINavigationController
            let destView = navigationController.viewControllers[0] as! MemeEditorViewController
            destView.receivedMemeArray = receivedMemeArray

        }
        
        else if (segue.identifier == "tableToDetailSegue")
        {
            let detailVC:MemeDetailViewController = segue.destinationViewController as! MemeDetailViewController
            detailVC.receivedMemeImage = detailMemeImage
        }
    }
}

