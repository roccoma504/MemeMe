//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/17/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // UI elements.
    
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var activityButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    
    // Private variables.
    
    // Defines an image picker for use by the photo picking functions.
    private var imagePicker = UIImagePickerController()
    
    // Defines a memeobject.
    private var memeObject = Meme()
    
    // Defines a variable that the memed image is stored in.
    private var savedMemeImage : UIImage!
    
    // Public variables.
    
    // Define an array of meme objects. This array will contain new memes
    // that the user creates.
    var newSentMemeArray : Array <Meme>!
    
    // Define an array of meme objects. This is the array before any
    // modifications.
    var receivedMemeArray : Array <Meme>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps to dismiss a text field.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Set the delegates.
        imagePicker.delegate = self
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        // Define the common text attributes for both labels.
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
            NSStrokeWidthAttributeName : -5.0]
        
        // Set the labels initial text field parameters.
        topTextField.text = "TOP"
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .Center
        
        bottomTextField.text = "BOTTOM"
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .Center
        
        // Set the enabled status of the camera button to the
        // availability of the device's camera.
        cameraButton.enabled = UIImagePickerController
            .isSourceTypeAvailable(UIImagePickerControllerSourceType .Camera)
        
        // Disable the activity button by default. This is reenabled when
        // a image is successfully selected.
        activityButton.enabled = false
        
        // Set up UI background color.
        view.backgroundColor = UIColor .grayColor()
        
        // Set the content mode for the image.
        memeImage.image = nil
        memeImage.contentMode = UIViewContentMode .ScaleAspectFit
    }
    
    override func viewDidAppear(animated: Bool) {
        // Establish listeners for detecting when the keyboard hides and shows.
        NSNotificationCenter.defaultCenter().addObserver(self, selector:
            Selector("keyboardWillShow:"),
            name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:
            Selector("keyboardWillHide:"),
            name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        // Remove all observers.
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillShowNotification, object: view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillHideNotification, object: view.window)
    }
    
    //# MARK Text field subprograms.
    
    // When the keyboard is dismissed end the editing on the field.
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Called when the return key is pressed.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // When the keyboard shows move the view up the height of the keyboard.
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if bottomTextField.editing {
                view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    // When the keyboard shows move the view down the height of the keyboard.
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if bottomTextField.editing {
                view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    //#MARK Meme subprograms
    
    // Defines a function that returns UIImage with the text embeded in it.
    func generateMeme() -> UIImage {
        // Hide toolbar and navbar.
        navigationController?.navigationBar.hidden = true;
        toolbar.hidden = true;
        
        // Render the view after the screen updates.
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let snapShotMeme : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar.
        toolbar.hidden = false;
        navigationController?.navigationBar.hidden = false;
        
        return snapShotMeme
    }
    
    // This save function creates a meme object.
    func save(snapShotMeme : UIImage) {
        // Create the meme.
        let meme = Meme(topText:topTextField.text!,
            bottomText : bottomTextField.text!, originalImage: memeImage.image!,
            memedImage : snapShotMeme)
        
        // Append the new meme to the array for output.
        newSentMemeArray.append(meme)
    }
    
    //#MARK IBActions
    
    // Defines a function that will show the camera view.
    @IBAction func cameraButtonPress(sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Defines a function that will show the image picker view.
    @IBAction func albumButtonPress(sender: AnyObject) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Define a function that launches the actionview.
    // The actionview is passed the meme to be shared.
    @IBAction func actionButtonPress(sender: AnyObject) {
        
        // Define a local snapshot of the meme so it can be passed to the
        // activity view and the save function if required.
        // This is mostly to prevent having to call generateMeme twice.
        let snapShotMeme = generateMeme()
        
        // Push the image to the activity view so when the user shares,
        // the correct image is used.
        let controller = UIActivityViewController(activityItems:
            [snapShotMeme], applicationActivities: nil)
        presentViewController(controller, animated: true, completion: nil)
        
        // This method is called when the image sending is completed.
        controller.completionWithItemsHandler = { (type, completed,
            returnedItems, error) -> Void in
            // If the action was completed successfully and the user did not hit
            // the cancel button then we save the meme.
            if (completed && type != "nil") {
                self.save(snapShotMeme)
            }
        }
    }
    
    // Defines a function that is invoked when the cancel button is pressed.
    @IBAction func cancelButtonPress(sender: AnyObject) {
        performSegueWithIdentifier("cancelPressSegue", sender: nil)
    }
    
    //# MARK: Image picker functions.
    
    // Defines a function that is called when the user picks an image.
    // If the image is good set it to the image view and enable the share
    // button. Dismiss the view either way.
    func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
            if let selectedImage : UIImage = image {
                memeImage.image = selectedImage
                memeImage.contentMode = .ScaleAspectFill
                activityButton.enabled = true
            }
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Defines a function that is called when the user cancels the pick.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Returns the received meme array before any modification.
    func getCompleteMemeArray() -> Array <Meme>! {
        return receivedMemeArray
    }
    
    //# MARK: Segues
    
    // Defines a function that is invoked when the cancel button is pressed.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // If the user has successfully picked an image then pass the data.
        // If we dont check this here the app will crash.
        if (segue.identifier == "cancelPressSegue" && memeImage.image != nil)
        {
            let tabBarController = segue.destinationViewController as! UITabBarController
            let navigationController = tabBarController.viewControllers![0] as! UINavigationController
            let destView = navigationController.viewControllers[0] as! SentMemesViewControllerTable
            destView.receivedMemeArray = newSentMemeArray
        }
        else if (segue.identifier == "cancelPressSegue") {
            let tabBarController = segue.destinationViewController as! UITabBarController
            let navigationController = tabBarController.viewControllers![0] as! UINavigationController
            let destView = navigationController.viewControllers[0] as! SentMemesViewControllerTable
            destView.receivedMemeArray = getCompleteMemeArray()
        }
    }
}