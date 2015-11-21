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
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let row = indexPath.row
        
//        if let memeImage = self.view.viewWithTag(1) as? UIImageView {
//            memeImage.image = memeArray[row].memeImaged
//        }
        
//        if let topLabel = self.view.viewWithTag(2) as? UILabel {
//            topLabel.text = memeArray[row].topText
//        }
        
//        if let botLabel = self.view.viewWithTag(3) as? UILabel {
//            botLabel.text = memeArray[row].bottomText
//        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

