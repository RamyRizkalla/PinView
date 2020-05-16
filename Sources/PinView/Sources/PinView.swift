//  Copyright © 2020 Ramy Rizkalla. All rights reserved.

import Foundation
import UIKit

public class PinView: UIStackView {
    private var textFields: [PinTextField] = [PinTextField]()
    
    public var enteredPinCode: String {
        let x = textFields.map { $0.text! }
        return x.joined()
    }
    
    var hidOnTyping: Bool = true
    var numberPfPins: Int = 4
    
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            textFields.forEach { $0.layer.borderWidth = borderWidth }
        }
    }

    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            textFields.forEach { $0.layer.borderColor = borderColor.cgColor }
        }
    }

    @IBInspectable var textFieldsbackgroundColor: UIColor = .white {
        didSet {
            textFields.forEach { $0.backgroundColor = textFieldsbackgroundColor }
        }
    }

    @IBInspectable var size: CGFloat = 25.0 {
        didSet {
            textFields.forEach {
                $0.backgroundColor = textFieldsbackgroundColor
                $0.frameSizeConstraint?.constant = size
            }
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            textFields.forEach {
                $0.layer.cornerRadius = cornerRadius
            }
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
        for i in 1...4 {
            let textField = PinTextField()
            textField.tag = i
            textFields.append(textField)
        }

        textFields.forEach {
            $0.clipsToBounds = true
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            $0.pinTextFielddelegate = self
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
            if hidOnTyping {
                pinField.hideBackground()
            }
        }

        pinField.resignFirstResponder()
    }
}

extension PinView: PinTextFieldDelegate {
    func textFieldWillDelete(_ textField: UITextField) {
        guard let pinField = textFields.first(where: { $0 == textField }) else { return }
        
        if pinField.text == "" {
            let previousPinField = textFields.first { $0.tag == pinField.tag - 1 }
            previousPinField?.text = ""
            previousPinField?.becomeFirstResponder()
            if hidOnTyping {
                previousPinField?.showBackground(borderWidth: borderWidth, borderColor: borderColor, background: textFieldsbackgroundColor)
            }
        } else {
            textFields.first { $0.tag == pinField.tag - 1 }?.becomeFirstResponder()
            if hidOnTyping {
                pinField.showBackground(borderWidth: borderWidth, borderColor: borderColor, background: textFieldsbackgroundColor)
            }
        }
    }
}
