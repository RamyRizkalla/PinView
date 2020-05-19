//  Copyright © 2020 Ramy Rizkalla. All rights reserved.

import Foundation
import UIKit

public class PinView: UIStackView {
    private var textFields: [PinTextField] = [PinTextField]()
    
    var enteredPinCode: String {
        let x = textFields.map { $0.text! }
        return x.joined()
    }
    
    var hidOnTyping: Bool = true
    var numberPfPins: Int = 4

    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            textFields.forEach { $0.layer.borderColor = borderColor.cgColor }
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            textFields.forEach { $0.layer.borderWidth = borderWidth }
        }
    }

    @IBInspectable var font: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            textFields.forEach { $0.font = font }
        }
    }

    @IBInspectable var textColor: UIColor = .black {
        didSet {
            textFields.forEach { $0.font = font }
        }
    }

    @IBInspectable var selectedBackgroundColor: UIColor = .white {
        didSet {
            textFields.first { $0.isFirstResponder }?.backgroundColor = selectedBackgroundColor
        }
    }

    @IBInspectable var selectedSize: CGFloat = 25.0 {
        didSet {
            textFields.first { $0.isFirstResponder }?.frameSizeConstraint?.constant = selectedSize
        }
    }

    @IBInspectable var selectedCornerRadius: CGFloat = 0.0 {
        didSet {
            textFields.first { $0.isFirstResponder }?.layer.cornerRadius = selectedCornerRadius
        }
    }

    @IBInspectable var unselectedBackgroundColor: UIColor = .white {
        didSet {
            textFields.filter { !$0.isFirstResponder }.forEach { $0.backgroundColor = unselectedBackgroundColor }
        }
    }

    @IBInspectable var unselectedCornerRadius: CGFloat = 0.0 {
        didSet {
            textFields.filter { !$0.isFirstResponder }.forEach { $0.layer.cornerRadius = unselectedCornerRadius }
        }
    }

    @IBInspectable var unselectedSize: CGFloat = 25.0 {
        didSet {
            textFields.filter { !$0.isFirstResponder }.forEach { $0.frameSizeConstraint?.constant = unselectedSize }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextFields()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupTextFields()
    }

    private func setupTextFields() {
        for i in 1...numberPfPins {
            let textField = PinTextField()
            textField.tag = i
            textFields.append(textField)
        }

        textFields.forEach {
            $0.clipsToBounds = true
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0.pinFieldDelegate = self
            $0.delegate = self
        }
        
        configureScrollView()
        addArrangedSubviews(textFields)
        textFields.first?.becomeFirstResponder()
    }
    
    private func configureScrollView() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
    }
    
}

extension PinView: UITextFieldDelegate {
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        guard let pinField = textFields.first(where: { $0 == textField }), let pinText = pinField.text else { return }
        
        if pinText.count == 1 {
            textFields.first { $0.tag == pinField.tag + 1 }?.becomeFirstResponder()
        }

        if textField == textFields.last {
            pinField.resignFirstResponder()
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = selectedBackgroundColor
        (textField as? PinTextField)?.frameSizeConstraint?.constant = selectedSize
        textField.layer.cornerRadius = selectedCornerRadius
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = unselectedBackgroundColor
        (textField as? PinTextField)?.frameSizeConstraint?.constant = unselectedSize
        textField.layer.cornerRadius = unselectedCornerRadius
        if hidOnTyping, textField.text != "" {
            (textField as? PinTextField)?.hideBackground()
        }
    }
}

extension PinView: PinTextFieldDelegate {
    func textFieldWillDelete(_ textField: UITextField) {
        guard let pinField = textFields.first(where: { $0 == textField }) else { return }
        
        if pinField.text == "" {
            let previousPinField = textFields.first { $0.tag == pinField.tag - 1 }
            previousPinField?.text = ""
            if hidOnTyping {
                previousPinField?.showBackground(borderWidth: borderWidth, borderColor: borderColor, background: selectedBackgroundColor)
            }
        } else {
            if hidOnTyping {
                pinField.showBackground(borderWidth: borderWidth, borderColor: borderColor, background: selectedBackgroundColor)
            }
        }
    }

    func textFieldDidDelete(_ textField: UITextField) {
        guard let pinField = textFields.first(where: { $0 == textField }) else { return }

        textFields.first { $0.tag == pinField.tag - 1 }?.becomeFirstResponder()
    }
}
