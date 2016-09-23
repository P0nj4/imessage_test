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
        self.view.backgroundColor = UIColor.blueColor()
        
        self.addChildViewController(self.myDrawableSpace)
        self.view.addSubview(self.myDrawableSpace.view)
        self.myDrawableSpace.didMoveToParentViewController(self)
        self.myDrawableSpace.view.backgroundColor = UIColor.yellowColor()
        self.myDrawableSpace.state = JotViewState.Drawing
        self.myDrawableSpace.renderImage()


        let buttonName = self.changeMode
        buttonName.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        buttonName.setGMDIcon(GMDType.GMDTextFormat, forState: .Normal)
        buttonName.setTitleColor(UIColor.redColor(), forState: .Normal)
        buttonName.addTarget(self, action: #selector(DrawerViewController.changeModePressed), forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonName)


        self.sendmessage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.sendmessage.setGMDIcon(GMDType.GMDSend, forState: .Normal)
        self.sendmessage.setTitleColor(UIColor.redColor(), forState: .Normal)
        self.sendmessage.addTarget(self, action: #selector(DrawerViewController.sendMessagePressed), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.sendmessage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.myDrawableSpace.view.frame = self.view.bounds
        self.myDrawableSpace.view.setNeedsDisplay()
        self.changeMode.anchorInCorner(.BottomRight, xPad: 10, yPad: 40, width: 40, height: 40)
        self.sendmessage.align(.AboveCentered, relativeTo: self.changeMode, padding: 10, width: 40, height: 40)
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
        self.delegate?.composeMessage(self.myDrawableSpace.renderImage())
    }
}
