//
//  MessagesViewController.swift
//  Extension
//
//  Created by German Pereyra on 9/22/16.
//  Copyright © 2016 German Pereyra. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func presentViewControllerForPresentationStyle(style: MSMessagesAppPresentationStyle) {
        let controller: UIViewController
        
        if style == .Compact {
            // Show a list of previously created ice creams.
            controller = self.initializeCompactStikerCollectionViewController()
        }
        else {
            controller = self.initializeExpandedDrawableViewController()
        }
        
        for child in childViewControllers {
            child.willMoveToParentViewController(nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        // Embed the new controller.
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        controller.view.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        controller.view.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        controller.view.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        
        controller.didMoveToParentViewController(self)
        

    }
    
    func initializeCompactStikerCollectionViewController()  -> UIViewController {
        let controller = MyDrawsViewController()
        controller.delegate = self
        return controller
    }
    
    func initializeExpandedDrawableViewController() -> UIViewController {
        let controller = DrawerViewController()
        controller.delegate = self
        return controller
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActiveWithConversation(conversation: MSConversation) {
        
        self.presentViewControllerForPresentationStyle(presentationStyle)
    }
    
    override func didResignActiveWithConversation(conversation: MSConversation) {

        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceiveMessage(message: MSMessage, conversation: MSConversation) {

        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSendingMessage(message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransitionToPresentationStyle(presentationStyle: MSMessagesAppPresentationStyle) {
        self.presentViewControllerForPresentationStyle(presentationStyle)
    }
    
    override func didTransitionToPresentationStyle(presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}

extension MessagesViewController: MessageExpandableDelegate {
    func expandConveration() {
        self.requestPresentationStyle(.Expanded)
    }
}

extension MessagesViewController: MessageSenderDelegate {
    func composeMessage(image: UIImage) {

        let components = NSURLComponents()
        components.queryItems = [NSURLQueryItem(name: "test", value: "testContent")]

        let layout = MSMessageTemplateLayout()
        layout.caption = "cap"
        layout.image = image

        let message = MSMessage()
        message.URL = components.URL
        message.layout = layout
        self.activeConversation?.insertMessage(message, completionHandler: { (error) in
            print(error)
        })

        
        self.dismiss()
    }
}
