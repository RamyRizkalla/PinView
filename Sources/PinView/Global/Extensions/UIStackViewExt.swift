//  Copyright © 2020 Ramy Rizkalla. All rights reserved.

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func removeArrangedSubviews(_ views: [UIView]) {
        views.forEach { removeArrangedSubview($0) }
    }
}
