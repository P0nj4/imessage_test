//
//  DrawerViewController.swift
//  WriteAndSendOnMessage
//
//  Created by German Pereyra on 9/22/16.
//  Copyright © 2016 German Pereyra. All rights reserved.
//

import UIKit
import jot
import Neon
import Google_Material_Design_Icons_Swift

protocol MessageSenderDelegate {
    func composeMessage(image: UIImage)
}

class DrawerViewController: UIViewController {
    
    let myDrawableSpace = JotViewController()
    let changeMode = UIButton()
    let sendmessage = UIButton()
    var delegate: MessageSenderDelegate?

    var isWritingModeEnabled: Bool = false {
        didSet {
            if isWritingModeEnabled {
                self.myDrawableSpace.state = JotViewState.EditingText
            } else {
                self.myDrawableSpace.state = JotViewState.Drawing
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.1)
        
        self.addChildViewController(self.myDrawableSpace)
        self.view.addSubview(self.myDrawableSpace.view)
        self.myDrawableSpace.didMoveToParentViewController(self)
        self.myDrawableSpace.view.backgroundColor = UIColor.whiteColor()
        self.myDrawableSpace.textColor = UIColor.blackColor()
        self.myDrawableSpace.state = JotViewState.Drawing
        
        self.changeMode.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.changeMode.titleLabel?.font = UIFont.systemFontOfSize(40)
        self.changeMode.setGMDIcon(GMDType.GMDTextFormat, forState: .Normal)
        self.changeMode.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.changeMode.addTarget(self, action: #selector(DrawerViewController.changeModePressed), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.changeMode)

        self.sendmessage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.sendmessage.titleLabel?.font = UIFont.systemFontOfSize(30)
        self.sendmessage.setGMDIcon(GMDType.GMDSend, forState: .Normal)
        self.sendmessage.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.sendmessage.addTarget(self, action: #selector(DrawerViewController.sendMessagePressed), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.sendmessage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.myDrawableSpace.view.anchorInCenter(width: self.view.width, height: self.view.width)
        self.sendmessage.anchorInCorner(.BottomRight, xPad: 10, yPad: 40, width: 40, height: 40)
        self.changeMode.align(.ToTheLeftCentered, relativeTo: self.sendmessage, padding: 10, width: self.changeMode.width, height: self.changeMode.height)
    }

    func changeModePressed() {
        self.isWritingModeEnabled = !self.isWritingModeEnabled
        if self.isWritingModeEnabled {
            changeMode.setGMDIcon(GMDType.GMDModeEdit, forState: .Normal)
        } else {
            changeMode.setGMDIcon(GMDType.GMDTextFormat, forState: .Normal)
        }
    }

    func sendMessagePressed() {
        
        let image = self.myDrawableSpace.renderImage()
        if let data = UIImagePNGRepresentation(image) {
            if let filename = getDocumentsDirectory().URLByAppendingPathComponent("\(NSDate.timeIntervalSinceReferenceDate()).png") {
                data.writeToURL(filename, atomically: true)
            }
        }
        
        self.delegate?.composeMessage(image)
    }
    
    func getDocumentsDirectory() -> NSURL {
        let paths = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
