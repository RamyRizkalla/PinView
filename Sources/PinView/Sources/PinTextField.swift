//  Copyright © 2020 Ramy Rizkalla. All rights reserved.

import Foundation
import UIKit

protocol PinTextFieldDelegate: AnyObject {
    func textFieldWillDelete(_ textField: UITextField)
    func textFieldDidDelete(_ textField: UITextField)
}

class PinTextField: UITextField {
    var frameSizeConstraint: NSLayoutConstraint?
    weak var pinFieldDelegate: PinTextFieldDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addTarget(self, action: #selector(limitToOneCharacter), for: .editingChanged)
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    
    override func deleteBackward() {
        pinFieldDelegate?.textFieldWillDelete(self)
        super.deleteBackward()
        pinFieldDelegate?.textFieldDidDelete(self)
    }
    
    private func setupView() {
        setTextProperties()
        setupConstraints()
    }
    
    private func setTextProperties() {
        textAlignment = .center
        keyboardType = .numberPad
    }
    
    private func setupConstraints() {
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        frameSizeConstraint = heightAnchor.constraint(equalToConstant: 25)
        frameSizeConstraint?.isActive = true
    }

    @objc
    private func limitToOneCharacter() {
        guard let firstCharacter = text?.prefix(1) else { return }
        text = String(firstCharacter)
    }
    
    func hideBackground() {
        layer.borderWidth = 0.0
        layer.borderColor = UIColor.clear.cgColor
        backgroundColor = .clear
    }
    
    func showBackground(borderWidth: CGFloat, borderColor: UIColor, background: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        backgroundColor = background
    }
}
