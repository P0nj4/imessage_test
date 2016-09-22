//
//  DrawerViewController.swift
//  WriteAndSendOnMessage
//
//  Created by German Pereyra on 9/22/16.
//  Copyright © 2016 German Pereyra. All rights reserved.
//

import UIKit
import jot
import FontAwesomeKit
import Neon

class DrawerViewController: UIViewController {
    
    let myDrawableSpace = JotViewController()
    let changeMode = UIButton()
    let pickBackground = UIButton()
    let background = UIImageView()
    
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
        self.myDrawableSpace.view.backgroundColor = UIColor.clear
        self.myDrawableSpace.state = JotViewState.drawing
        self.myDrawableSpace.renderImage()
        
        
        let changeModeImage = UIImage(stackedIcons: [FAKFontAwesome.pencilIcon(withSize: 35)], imageSize: CGSize(width: 60, height: 60))
//        self.changeMode.setImage(changeModeImage, for: .normal)
        self.view.addSubview(self.changeMode)
        self.changeMode.addTarget(self, action: #selector(changeModePressed), for: .touchUpInside)
        
//        let pickBackgroundImage = UIImage(stackedIcons: [FAKFontAwesome.imageIcon(withSize: 35)], imageSize: CGSize(width: 60, height: 60))
//        self.pickBackground.setImage(pickBackgroundImage, for: .normal)
        self.view.addSubview(self.pickBackground)
        self.pickBackground.addTarget(self, action: #selector(pickAbackgroundPressed), for: .touchUpInside)
        
        self.view.addSubview(self.background)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.myDrawableSpace.view.frame = self.view.bounds
        self.pickBackground.anchorInCorner(.bottomLeft, xPad: 10, yPad: 10, width: 60, height: 60)
        self.changeMode.anchorInCorner(.bottomRight, xPad: 10, yPad: 10, width: 60, height: 60)
        self.background.fillSuperview()
    }
    
    //MARK - Actions
    
    func changeModePressed() {
        
//        
//        var size = CGSize(width: 300, height: 300)
//        UIGraphicsBeginImageContext(size)
//        
//        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        bottomImage!.drawInRect(areaSize)
//        
//        topImage!.drawInRect(areaSize, blendMode: kCGBlendModeNormal, alpha: 0.8)
//        
//        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
        
        self.isWritingModeEnabled = !self.isWritingModeEnabled
    }
    
    func pickAbackgroundPressed() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
}

extension DrawerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.background.contentMode = .scaleAspectFit
            self.background.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
