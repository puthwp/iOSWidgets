//
//  PrimaryTextField.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 18/2/2564 BE.
//

import Foundation
import UIKit

@IBDesignable
public class PrimaryTextField: UITextField, PrimaryTextinput {
    var titleLabel = UILabel()
    var helpingTextLabel = UILabel()
    var helpingTextIconImageView = UIImageView()
    var titleCenterConstraint = NSLayoutConstraint()
    var titleTopConstraint = NSLayoutConstraint()
    var titleLeftMargin = NSLayoutConstraint()
    var titleRightMargin = NSLayoutConstraint()
    public var heightConstraint = NSLayoutConstraint()
    var iconImageView = UIImageView()
    var actionButton = UIButton()
    public var inputState: PrimaryInputState = .idle
    var tempPlaceHolder: String?
    var tempHelpingText: String?
    
    public var error: PrimaryError? {
        didSet {
            if let error = error {
                inputState = .error
                helpingText = error.description ?? ""
            }else {
                inputState = isFirstResponder ? ((text?.isNotEmpty ?? true) ? .typing : .focus) : .typed
                helpingText = tempHelpingText ?? ""
            }
            updateLayout()
        }
    }
    
    @IBInspectable public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable public var helpingText: String = "" {
        didSet {
            createHelpingText()
            setHelpingText(helpingText)
        }
    }
    
    @IBInspectable public var helpingTextIcon: UIImage? {
        didSet {
            createHelpingText()
            helpingTextIconImageView.image = helpingTextIcon
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            switch isEnabled {
            case true:
                inputState = hasTextInput ? .typed : .idle
            case false:
                inputState = .disabled
            }
            updateLayout()
        }
    }
    
    @IBInspectable public var maximumLength = 100
    @IBInspectable public var icon: UIImage? {
        didSet {
            createIconImageView()
            iconImageView.image = icon
        }
    }
    
    @IBInspectable public var actionIcon: UIImage? {
        didSet {
            createActionButton()
            actionButton.setImage(actionIcon, for: .normal)
        }
    }
    
    @IBInspectable public var actionIconSelected: UIImage? {
        didSet {
            createActionButton()
            actionButton.setImage(actionIconSelected, for: .selected)
        }
    }
    
    public var action: ((UITextField) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if error != nil {
            inputState = .error
        }
        if isEnabled.revert {
            inputState = .disabled
        }
        updateLayout()
    }
    
    public override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        inputState = hasTextInput ? .typing : .focus
        return true
    }
    
    public override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        guard inputState != .error else {
            return true
        }
        inputState = hasTextInput ? .typed : .idle
        return true
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: inputInset)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inputInset)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inputInset)
    }
    
    func notifyTextFieldIsEditting(_ notification: Notification) {
        ///
    }
    
}
