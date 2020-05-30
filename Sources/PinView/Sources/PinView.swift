//  Copyright © 2020 Ramy Rizkalla. All rights reserved.

import Foundation
import UIKit

public class PinView: UIStackView {
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            textFields.forEach { $0.layer.borderColor = borderColor.cgColor }
        }
    }

    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            textFields.forEach { $0.layer.borderWidth = borderWidth }
        }
    }

    @IBInspectable public var font: UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            textFields.forEach { $0.font = font }
        }
    }

    @IBInspectable public var textColor: UIColor = .black {
        didSet {
            textFields.forEach { $0.font = font }
        }
    }

    @IBInspectable public var selectedBackgroundColor: UIColor = .white {
        didSet {
            textFields.first { $0.isFirstResponder }?.backgroundColor = selectedBackgroundColor
        }
    }

    @IBInspectable public var selectedSize: CGFloat = 25.0 {
        didSet {
            textFields.first { $0.isFirstResponder }?.frameSizeConstraint?.constant = selectedSize
        }
    }

    @IBInspectable public var selectedCornerRadius: CGFloat = 0.0 {
        didSet {
            textFields.first { $0.isFirstResponder }?.layer.cornerRadius = selectedCornerRadius
        }
    }

    @IBInspectable public var unselectedBackgroundColor: UIColor = .white {
        didSet {
            textFields.filter { !$0.isFirstResponder }.forEach { $0.backgroundColor = unselectedBackgroundColor }
        }
    }

    @IBInspectable public var unselectedCornerRadius: CGFloat = 0.0 {
        didSet {
            textFields.filter { !$0.isFirstResponder }.forEach { $0.layer.cornerRadius = unselectedCornerRadius }
        }
    }

    @IBInspectable public var unselectedSize: CGFloat = 25.0 {
        didSet {
            textFields.filter { !$0.isFirstResponder }.forEach { $0.frameSizeConstraint?.constant = unselectedSize }
        }
    }

    public var enteredPinCode: String {
        return textFields.map { $0.text! }.joined()
    }
    
    private var textFields: [PinTextField] = [PinTextField]()
    
    public var showPin: Bool = true
    public var numberOfPINCharacters: Int = 4

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextFields()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupTextFields()
    }

    private func setupTextFields() {
        for i in 1...numberOfPINCharacters {
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
        if showPin, textField.text != "" {
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
            if showPin {
                previousPinField?.showBackground(borderWidth: borderWidth, borderColor: borderColor, background: selectedBackgroundColor)
            }
        } else {
            if showPin {
                pinField.showBackground(borderWidth: borderWidth, borderColor: borderColor, background: selectedBackgroundColor)
            }
        }
    }

    func textFieldDidDelete(_ textField: UITextField) {
        guard let pinField = textFields.first(where: { $0 == textField }) else { return }

        textFields.first { $0.tag == pinField.tag - 1 }?.becomeFirstResponder()
    }
}
