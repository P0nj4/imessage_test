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

class DrawerViewController: UIViewController {
    
    let myDrawableSpace = JotViewController()
    let changeMode = UIButton()
    let pickBackground = UIButton()
    let background = UIImageView()
    
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
        buttonName.setGMDIcon(GMDType.GMDPublic, forState: .Normal)
        buttonName.setTitleColor(UIColor.redColor(), forState: .Normal)
        self.view.addSubview(buttonName)
        
        //let changeModeImage = UIImage(stackedIcons: [FAKFontAwesome.pencilIcon(withSize: 35)], imageSize: CGSize(width: 60, height: 60))
//        self.changeMode.setImage(changeModeImage, for: .normal)
        //self.view.addSubview(self.changeMode)
        //self.changeMode.addTarget(self, action: #selector(changeModePressed), for: .touchUpInside)
        
//        let pickBackgroundImage = UIImage(stackedIcons: [FAKFontAwesome.imageIcon(withSize: 35)], imageSize: CGSize(width: 60, height: 60))
//        self.pickBackground.setImage(pickBackgroundImage, for: .normal)
        //self.view.addSubview(self.pickBackground)
        //self.pickBackground.addTarget(self, action: #selector(pickAbackgroundPressed), for: .touchUpInside)
        
        //self.view.addSubview(self.background)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.myDrawableSpace.view.frame = self.view.bounds
        //self.pickBackground.anchorInCorner(.bottomLeft, xPad: 10, yPad: 10, width: 60, height: 60)
        self.changeMode.anchorInCorner(.BottomRight, xPad: 10, yPad: 10, width: 40, height: 40)
        //self.background.fillSuperview()
    }
}
