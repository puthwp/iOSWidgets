//
//  PrimaryTextView.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 1/3/2564 BE.
//

import Foundation
import UIKit

@IBDesignable
public class PrimaryTextView: UITextView, PrimaryTextinput {
    var isEnabled: Bool = true
    var titleLabel = UILabel()
    var helpingTextLabel = UILabel()
    var helpingTextIconImageView = UIImageView()
    var titleCenterConstraint = NSLayoutConstraint()
    var titleTopConstraint = NSLayoutConstraint()
    var titleLeftMargin = NSLayoutConstraint()
    var titleRightMargin = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()
    var iconImageView = UIImageView()
    var actionButton = UIButton()
    var inputState: PrimaryInputState = .idle
    var tempPlaceHolder: String?
    var tempHelpingText: String?
    
    private var initialHeight: CGFloat = 0
    
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
    
    @IBInspectable var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable var helpingText: String = "" {
        didSet {
            createHelpingText()
            setHelpingText(helpingText)
        }
    }
    
    @IBInspectable var helpingTextIcon: UIImage? {
        didSet {
            createHelpingText()
            helpingTextIconImageView.image = helpingTextIcon
        }
    }
    
    @IBInspectable var maximumLength = 100
    @IBInspectable var icon: UIImage? {
        didSet {
            createIconImageView()
            iconImageView.image = icon
        }
    }
    
    @IBInspectable var actionIcon: UIImage? {
        didSet {
            createActionButton()
            actionButton.setImage(actionIcon, for: .normal)
        }
    }
    
    @IBInspectable var actionIconSelected: UIImage? {
        didSet {
            createActionButton()
            actionButton.setImage(actionIconSelected, for: .selected)
        }
    }
    
    var action: ((UITextField) -> Void)?
    
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
        self.isSelectable = true
        self.isScrollEnabled = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceVertical = false
        self.alwaysBounceHorizontal = false
        self.textContainer.lineFragmentPadding = 0
        initialHeight = heightConstraint.constant
    }
    
    func notifyTextFieldIsEditting(_ notification: Notification) {
        inputState = hasTextInput ? .typing : .focus
        guard notification.object as! NSObject == self else {
            return
        }
        let textSize = self.sizeThatFits(self.bounds.size).height
        heightConstraint.constant = textSize > initialHeight ? textSize : initialHeight
        updateLayout()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if error != nil {
            inputState = .error
        }
        updateLayout()
        self.textContainerInset = inputInset
    }
    
    public override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        inputState = hasTextInput ? .typing : .focus
        updateLayout()
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
    
}
