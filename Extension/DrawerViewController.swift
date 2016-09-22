//
//  DrawerViewController.swift
//  WriteAndSendOnMessage
//
//  Created by German Pereyra on 9/22/16.
//  Copyright © 2016 German Pereyra. All rights reserved.
//

import UIKit
import jot

class DrawerViewController: UIViewController {
    
    let myDrawableSpace = JotViewController()
    let changeModeButton = UIButton()
    let addBackgroundImage = UIButton()
    
    var isWritingModeEnabled: Bool = false {
        didSet {
            if isWritingModeEnabled {
                self.myDrawableSpace.state = JotViewState.editingText
            } else {
                self.myDrawableSpace.state = JotViewState.drawing
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        
        self.addChildViewController(self.myDrawableSpace)
        self.view.addSubview(self.myDrawableSpace.view)
        self.myDrawableSpace.didMove(toParentViewController: self)
        self.myDrawableSpace.view.backgroundColor = UIColor.yellow
        self.myDrawableSpace.state = JotViewState.drawing
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.myDrawableSpace.view.frame = self.view.bounds
    }
}
