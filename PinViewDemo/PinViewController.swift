//  Copyright © 2020 Ramy Rizkalla. All rights reserved.

import UIKit
import PinView

class PinViewController: UIViewController {
    @IBOutlet private var pinView: PinView!

    override func viewDidLoad() {
        super.viewDidLoad()
        pinView.font = UIFont.systemFont(ofSize: 25)
    }
}

