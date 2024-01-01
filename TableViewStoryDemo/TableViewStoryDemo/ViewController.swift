//
//  ViewController.swift
//  TableViewStoryDemo
//
//  Created by 박준영 on 11/16/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let swiftUIController = UIHostingController(rootView: SwiftUIView())
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(swiftUIController)
        
        view.addSubview(swiftUIController.view)
        
        let constraints = [
            swiftUIController.view.topAnchor.constraint(equalTo: view.topAnchor),
            swiftUIController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftUIController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftUIController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }


}

