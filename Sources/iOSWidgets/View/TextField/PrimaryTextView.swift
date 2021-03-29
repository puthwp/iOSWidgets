//
//  PrimaryTextView.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 1/3/2564 BE.
//

import Foundation
import UIKit

@IBDesignable
public class PrimaryTextView: UITextView, PrimaryTextInput {
    
    var titleLabel = UILabel()
    var helpingTextLabel = UILabel()
    var helpingTextIconImageView = UIImageView()
    var titleCenterConstraint = NSLayoutConstraint()
    var titleTopConstraint = NSLayoutConstraint()
    var titleLeftMargin = NSLayoutConstraint()
    var titleRightMargin = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()
    var iconImageView = UIImageView()
    public var actionButton = UIButton()
    public var inputState: PrimaryInputState = .idle
    var tempPlaceholder: String?
    var tempHelpingText: String?
    var layerShape = CAShapeLayer()
    var helpingTextStackView: UIStackView?
    private let placeHolderLabel = UILabel(frame: .zero)
    private var placeholderLeading: NSLayoutConstraint?
    private var placeholderTrailing: NSLayoutConstraint?
    public var descriptionLabel = UILabel()
    var countingLabel = UILabel()
    var borderLine = CAShapeLayer()
    var currentHeight: CGFloat = 0
    var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    
    internal var initialHeight: CGFloat = 0
    
    public var error: PrimaryError? {
        didSet {
            if let error = error {
                inputState = .error
                helpingText = error.description ?? ""
            }else {
                inputState = isFirstResponder ? (hasTextInput ? .typing : .focus) : (hasTextInput ? .typed : .idle)
                if isEnabled.revert {
                    inputState = .disabled
                }
                helpingText = tempHelpingText ?? ""
            }
            updateLayout()
        }
    }
    
    public var isEnabled: Bool = true {
        didSet {
            isEditable = isEnabled
            isSelectable = isEnabled
            switch isEnabled {
            case true:
                inputState = hasTextInput ? .typed : .idle
            case false:
                inputState = .disabled
            }
            layoutSubviews()
        }
    }
    
    public override var text: String! {
        didSet {
            placeHolderLabel.isHidden = text.isNotEmpty
            inputState = hasTextInput ? .typed : .idle
            layoutSubviews()
        }
    }
    
    @IBInspectable public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable var placeholder: String? {
        didSet {
            tempPlaceholder = placeholder
            createPlaceholder(placeholder)
            layoutSubviews()
        }
    }
    
    @IBInspectable var helpingText: String = "" {
        didSet {
            createHelpingText()
            setHelpingText(helpingText)
            heightConstraint.constant = realHeight
        }
    }
    
    @IBInspectable public var helpingTextIcon: UIImage? {
        didSet {
            createHelpingText()
            helpingTextIconImageView.image = helpingTextIcon
            heightConstraint.constant = realHeight
        }
    }
    
    @IBInspectable public var maximumLength = 100
    @IBInspectable public var icon: UIImage? {
        didSet {
            createIconImageView()
            iconImageView.image = icon
            createPlaceholder(placeholder)
        }
    }
    
    @IBInspectable public var actionIcon: UIImage? {
        didSet {
            createActionButton()
            actionButton.setImage(actionIcon, for: .normal)
            createPlaceholder(placeholder)
        }
    }
    
    @IBInspectable public var actionIconSelected: UIImage? {
        didSet {
            createActionButton()
            actionButton.setImage(actionIconSelected, for: .selected)
            createPlaceholder(placeholder)
        }
    }
    
    public var action: ((PrimaryTextView) -> Void)?
    
    @IBInspectable public var inputAccessory: Bool = true {
        didSet{
            self.inputAccessoryView = inputAccessory ? createInputAccessories() : nil
        }
    }
    
    @IBInspectable public var countingCharacter: Bool = false {
        didSet {
            createCountingText()
        }
    }
    @IBInspectable public var descriptionText: String? {
        didSet {
            createDescriptionLabel()
            setDescriptionText(descriptionText)
            heightConstraint.constant = realHeight
        }
    }
    
    var dynamicHeight: CGFloat {
        let textSize = self.sizeThatFits(self.bounds.size).height
        return textSize > initialHeight ? (textSize > maxHeight ? maxHeight: textSize) : currentHeight
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
        setConfiguration()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setConfiguration()
    }
    
    private func setConfiguration(){
        self.isEditable = true
        self.clipsToBounds = false
        self.isSelectable = true
        self.isScrollEnabled = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceVertical = false
        self.alwaysBounceHorizontal = false
        self.textContainer.lineFragmentPadding = 0
        initialHeight = heightConstraint.constant
        currentHeight = heightConstraint.constant
    }
    
    func notifyTextFieldIsEditting(_ notification: Notification) {
        guard notification.object as! NSObject == self else {
            return
        }
        inputState = hasTextInput ? .typing : .focus
        updateCountingCharacter(text: self.text)
        placeHolderLabel.isHidden = self.text.isNotEmpty
        currentHeight = dynamicHeight
        heightConstraint.constant = currentHeight
        updateLayout()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        placeHolderLabel.isHidden = text.isNotEmpty
        if error != nil {
            inputState = .error
        }
        if isEnabled.revert {
            inputState = .disabled
        }
        
        currentHeight = dynamicHeight
        heightConstraint.constant = currentHeight
        updateLayout()
        self.textContainerInset = inputInset
        resizeBound()
        helpingTextStackView?.frame = CGRect(x: 0, y: self.bounds.height - 20, width: self.intrinsicContentSize.width, height: 20)
    }
    
    public override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        guard isEnabled else {
            return false
        }
        guard error == nil else {
            return true
        }
        inputState = hasTextInput ? .typing : .focus
        placeHolderLabel.isHidden = text.isNotEmpty
        updateLayout()
        return true
    }
    
    public override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        guard error == nil else {
            return true
        }
        inputState = hasTextInput ? .typed : .idle
        placeHolderLabel.isHidden = text.isNotEmpty
        return true
    }
    
    private func createPlaceholder(_ input: String?) {
        placeHolderLabel.text = input
        guard placeHolderLabel.superview == nil else {
            placeholderLeading?.constant = inputInset.left
            placeholderTrailing?.constant = inputInset.right
            return
        }
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(placeHolderLabel)
        placeHolderLabel.textColor = TextFieldStateDesign.Normal.contentTextColor
        placeHolderLabel.font = TextFieldStateDesign.Normal.contentFont
        
        
        placeholderLeading = placeHolderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inputInset.left)
        placeholderTrailing = placeHolderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: inputInset.right)
        NSLayoutConstraint.activate([
            placeholderLeading!,
            placeholderTrailing!,
            placeHolderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: inputInset.top)
        ])
    }
    
    @objc func keyboardDoneAction() {
        _ = self.resignFirstResponder()
    }
}
