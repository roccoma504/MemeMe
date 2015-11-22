//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Matthew Rocco on 11/17/15.
//  Copyright © 2015 Matthew Rocco. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // Define the UI elements.
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var activityButton: UIBarButtonItem!
    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    // Variables.
    
    // Defines an image picker for use by the photo picking functions.
    private var imagePicker = UIImagePickerController()
    
    // Defines a memeobject.
    private var memeObject = MemeObject()

    // Define an array of meme objects.
    var receivedMemeArray : Array <MemeObject> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        // Set the delegates.
        imagePicker.delegate = self
        topLabel.delegate = self
        bottomLabel.delegate = self
        
        //TODO Add impact font
        // Define a default label object.
        let defaultLabel = MemeLabelObject(color: UIColor .whiteColor(), alignment: NSTextAlignment .Center, correction: UITextAutocorrectionType .No, font: UIFont (name: "Impact", size: 35)!)
        
        // Set up the defaults for the labels.
        self.topLabel.text = "TOP"
        self.topLabel.textColor = defaultLabel.color
        self.topLabel.textAlignment = defaultLabel.alignment
        self.topLabel.autocorrectionType = defaultLabel.correction
        self.topLabel.font = defaultLabel.font

        self.bottomLabel.text = "BOTTOM"
        self.bottomLabel.textColor = defaultLabel.color
        self.bottomLabel.textAlignment = defaultLabel.alignment
        self.bottomLabel.autocorrectionType = defaultLabel.correction
        self.bottomLabel.font = defaultLabel.font

        // Set the enabled status of the camera button to the
        // availability of the device's camera.
        self.cameraButton.enabled = UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType .Camera)
        
        // Disable the activity button.
        self.activityButton.enabled = false
        
        // Set up UI background color.
        self.view.backgroundColor = UIColor .grayColor()
        
        //Looks for single or multiple taps to dismiss a text field.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        // Remove all observers.
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    //# MARK Text field subprograms.
    
    func dismissKeyboard() {
        // Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Called when the return key is pressed.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if self.bottomLabel.editing {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if self.bottomLabel.editing {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    //#MARK Meme subprograms
    
    // Defines a function that returns UIImage with the
    // UILabels embeded in int.
    func generatememeObject() -> UIImage {
        
        // Hide toolbar and navbar.
        self.navigationController?.navigationBar.hidden = true;
        self.toolbar.hidden = true;
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        
        let snapShotMeme : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        self.toolbar.hidden = false;
        self.navigationController?.navigationBar.hidden = false;
        
        return snapShotMeme
    }
    
    // Save the meme obeject locally and push it to the array.
    func generateMeme() {
        
        memeObject.saveMeme(self.topLabel.text!, bottomText: self.bottomLabel.text!, originalImage: memeImage.image!, memedImage: self.generatememeObject())
        
        let newMeme = memeObject.getMeme()
        
        receivedMemeArray.append(newMeme)
        
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
        
        // Generate the meme.
        generateMeme()
        
        // Push the image to the activity view so when the user shares,
        // the correct image is used.
        let controller = UIActivityViewController(activityItems: [memeObject.getMeme().memeImaged], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    // Defines a function that is invoked when the cancel button is pressed.
    @IBAction func cancelButtonPress(sender: AnyObject) {
            self.performSegueWithIdentifier("cancelPressSegue", sender: nil)
    }
    
    //# MARK: Image picker functions.
    
    // Defines a function that is called when the user picks an image.
    // If the image is good set it to the image view and enable the share
    // button. Dismiss the view either way.
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        if let selectedImage : UIImage = image {
            memeImage.image = selectedImage
            memeImage.contentMode = .ScaleAspectFill
            self.activityButton.enabled = true
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Defines a function that is called when the user cancels the pick.
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
            destView.receivedMemeArray = receivedMemeArray
        }
    }
}