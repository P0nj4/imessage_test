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
        
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        // Embed the new controller.
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = false
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = false
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = false
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = false
        
        controller.didMove(toParentViewController: self)

    }


}

