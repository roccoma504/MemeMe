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
    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    var combinedImage = UIImage!()
    
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
        let defaultLabel = MemeLabelObject(text: "MEME ME!!", color: UIColor .whiteColor(), font: UIFont (name: "HelveticaNeue", size: 30)!, alignment: NSTextAlignment .Center, correction: UITextAutocorrectionType .No)
        
        // Set up the defaults for the labels.
        self.topLabel.text = defaultLabel.text
        self.topLabel.textColor = defaultLabel.color
        self.topLabel.font = defaultLabel.font
        self.topLabel.textAlignment = defaultLabel.alignment
        self.topLabel.autocorrectionType = defaultLabel.correction
        self.bottomLabel.text = defaultLabel.text
        self.bottomLabel.textColor = defaultLabel.color
        self.bottomLabel.font = defaultLabel.font
        self.bottomLabel.textAlignment = defaultLabel.alignment
        self.bottomLabel.autocorrectionType = defaultLabel.correction
        
        // Set the enabled status of the camera button to the
        // availability of the device's camera.
        self.cameraButton.enabled = UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType .Camera)
        
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
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Called when the return key is pressed.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    
    //#MARK IBActions
    
    // Defines a function that will show the camera view.
    @IBAction func cameraButtonPress(sender: AnyObject) {
    }
    
    // Defines a function that will show the image picker view.
    @IBAction func albumButtonPress(sender: AnyObject) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Define a function that launches the actionview.
    // The actionview is passed the meme to be shared.
    @IBAction func actionButtonPress(sender: AnyObject) {
        let image = UIImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    // Defines a function that is invoked when the cancel button is pressed.
    @IBAction func cancelButtonPress(sender: AnyObject) {
        self.performSegueWithIdentifier("cancelPressSegue", sender: MemeObject(topText: self.topLabel.text!, bottomText: self.bottomLabel.text!, originalImage: self.memeImage.image!, memeImage: memeImage.image!))
    }
    
    //# MARK: Image picker functions.
    
    // Defines a function that is called when the user picks an image.
    // If the image is good set it to the image view. Dismiss either way.
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        if let selectedImage : UIImage = image {
            memeImage.image = selectedImage
            memeImage.contentMode = .ScaleAspectFill
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
        if (segue.identifier == "cancelPressSegue")
        {
            let tabBarController = segue.destinationViewController as! UITabBarController
            let navigationController = tabBarController.viewControllers![0] as! UINavigationController
            let vueFil = navigationController.viewControllers[0] as! SentMemesViewControllerTable
            let data = sender as! MemeObject
            vueFil.receivedMeme = data
        }
    }
}