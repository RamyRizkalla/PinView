//  Copyright © 2020 Ramy Rizkalla. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Step 2. Instantiate UIViewController with Storyboard ID
        let sut = storyboard.instantiateViewController(withIdentifier: "PinViewController") as? PinViewController
        window?.rootViewController = sut
        window?.makeKeyAndVisible()

        return true
    }
}

