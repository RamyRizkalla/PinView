//
//  ViewController.swift
//  PinViewDemo
//
//  Created by Ramy Rizkalla on 5/29/20.
//  Copyright © 2020 Ramy Rizkalla. All rights reserved.
//

import UIKit
import PinView

class ViewController: UIViewController {
    @IBOutlet private weak var pinView: PinView!

    override func viewDidLoad() {
        super.viewDidLoad()
        pinView.font = UIFont.systemFont(ofSize: 25)
    }
}

