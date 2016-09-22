//
//  ViewController.swift
//  WriteAndSendOnMessage
//
//  Created by German Pereyra on 9/22/16.
//  Copyright © 2016 German Pereyra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let controller: UIViewController
        controller = DrawerViewController()
        
        
        // Embed the new controller.
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = false
        controller.view.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = false
        controller.view.topAnchor.constraintEqualToAnchor(view.topAnchor).active = false
        controller.view.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = false
        
        controller.didMoveToParentViewController(self)

    }


}

