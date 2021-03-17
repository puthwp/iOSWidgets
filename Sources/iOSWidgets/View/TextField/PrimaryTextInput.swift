//
//  PrimaryTextInput.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 28/2/2564 BE.
//

import Foundation
import UIKit

protocol PrimaryTextinput: UIView {
    
    var titleLabel: UILabel { get set }
    var helpingTextLabel: UILabel { get set }
    var helpingTextIconImageView: UIImageView { get set }
    var titleCenterConstraint: NSLayoutConstraint { get set }
    var titleTopConstraint: NSLayoutConstraint { get set }
    var titleLeftMargin: NSLayoutConstraint { get set }
    var titleRightMargin: NSLayoutConstraint { get set }
    var heightConstraint: NSLayoutConstraint { get set }
    var iconImageView: UIImageView { get set }
    var actionButton: UIButton { get set }
    var tempPlaceHolder: String?  { get set }
    var tempHelpingText: String? { get set }
    var inputState: PrimaryInputState { get set }
    
    var error: PrimaryError? { get set }
    var action: ((UITextField) -> Void)? { get set }
    var title: String? { get set }
    var helpingText: String { get set }
    var helpingTextIcon: UIImage? { get set }
    var isEnabled: Bool { get set }
    var maximumLength: Int { get set }
    var icon: UIImage? { get set }
    var actionIcon: UIImage? { get set }
    var actionIconSelected: UIImage? { get set }
    var layerShape: CAShapeLayer { get  set }
    var helpingTextStackView: UIStackView? { get set }
    
    func notifyTextFieldIsEditting(_ notification: Notification)
    func notifyTextFieldIsBeginEditting(_ notification: Notification)
    func notifyTextFieldDidEndEdit(_ notification: Notification)
}

extension PrimaryTextinput {
    
    var hasIconImage: Bool {
        return icon != nil
    }
    
    var hasActionButton: Bool {
        return actionIcon != nil
    }
    
    var textField: UITextField? {
        return self as? UITextField
    }
    
    var textView: UITextView? {
        return self as? UITextView
    }
    
    var view: UIView? {
        return textField == nil ? textView : textField
    }
    
    var textInput: String? {
        guard let field = textField else {
            guard let view = textView else {
                return nil
            }
            return view.text
        }
        return field.text
    }
    
    var hasTextInput: Bool {
        return (textInput ?? "").isNotEmpty
    }
    
    var hasPlaceholder: Bool {
        guard let textField = textField else {
            return false
        }
        return textField.placeholder?.isNotEmpty ?? false
    }
    
    var inputState: PrimaryInputState {
        set {
            inputState = newValue
            updateLayout()
        }
        get {
            inputState
        }
    }
    
    var inputInset: UIEdgeInsets {
        var inset = TextFieldStateDesign.inputPadding
        inset.left = hasIconImage ?
            TextFieldStateDesign.inputPadding.left + TextFieldStateDesign.iconSize.width + TextFieldStateDesign.smallGap :
            TextFieldStateDesign.inputPadding.left
        inset.right = hasActionButton ?
            TextFieldStateDesign.inputPadding.right + TextFieldStateDesign.actionButtonSize.width + TextFieldStateDesign.smallGap :
            TextFieldStateDesign.inputPadding.right
        return inset
    }
    
    //MARK: - Initialize
    
    func commonInit() {
        addObservers()
        createTitle()
//        createHelpingText()
        createIconImageView()
        createActionButton()
        setupLayout()
        inputState = hasTextInput ? .typed : .idle
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: UITextField.textDidBeginEditingNotification, object: nil, queue: .main) { (notification) in
            self.notifyTextFieldIsBeginEditting(notification)
        }
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: .main) { (notification) in
            self.notifyTextFieldIsEditting(notification)
        }
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidEndEditingNotification, object: nil, queue: .main) { (notification) in
            self.notifyTextFieldDidEndEdit(notification)
        }
        
        
        //TextView
        NotificationCenter.default.addObserver(forName: UITextView.textDidBeginEditingNotification, object: nil, queue: .main) { (notification) in
            self.notifyTextFieldIsBeginEditting(notification)
        }
        
        NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: nil, queue: .main) { (notification) in
            self.notifyTextFieldIsEditting(notification)
        }
        
        NotificationCenter.default.addObserver(forName: UITextView.textDidEndEditingNotification, object: nil, queue: .main) { (notification) in
            self.notifyTextFieldDidEndEdit(notification)
        }
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
    }
    
    
    func notifyTextFieldIsBeginEditting(_ notification: Notification) {
        guard let field = textField else {
            return
        }
        if let textField = notification.object as? PrimaryTextinput {
            textField.error = nil
            textField.inputState = .typing
            textField.hasActionButton ? {
                textField.action?(field)
            }() : ()
        }
    }
    
    func notifyTextFieldDidEndEdit(_ notification: Notification){
        if let textField = notification.object as? PrimaryTextinput {
            textField.inputState = textField.hasTextInput ? .typed : .idle
            textField.updateLayout()
        }
    }
    
    //MARK: - Creation Part
    
    func createTitle(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.text = title
        titleLabel.font = TextFieldStateDesign.Normal.titleFont
        titleLabel.textColor = TextFieldStateDesign.Normal.titleColor
        self.addSubview(titleLabel)
        
        titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: TextFieldStateDesign.smallGap )
        titleCenterConstraint = titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        titleLeftMargin = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inputInset.left)
        titleRightMargin = self.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: inputInset.right)
        
        titleCenterConstraint.isActive = true
        titleLeftMargin.isActive = true
        titleRightMargin.isActive = true
    }
    
    func createHelpingText() {
        guard helpingText.isNotEmpty, helpingTextLabel.superview == nil else {
            return
        }
        helpingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        helpingTextLabel.numberOfLines = 2
        helpingTextLabel.font = TextOptionalDesign.font
        helpingTextLabel.textColor = TextOptionalDesign.Normal.color
        setHelpingText(helpingText)
        
        
        helpingTextIconImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        helpingTextIconImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        helpingTextIconImageView.image = helpingTextIcon != nil ? helpingTextIcon : UIImage(named: "01Small16PxAlert")
        
        helpingTextStackView = UIStackView(arrangedSubviews: [helpingTextIconImageView, helpingTextLabel])
        helpingTextStackView?.translatesAutoresizingMaskIntoConstraints = false
        helpingTextStackView?.alignment = .fill
        helpingTextStackView?.distribution = .fill
        helpingTextStackView?.axis = .horizontal
        helpingTextStackView?.spacing = 4
    
        self.addSubview(helpingTextStackView!)
        let metrics = ["top": heightConstraint.constant + TextOptionalDesign.topMargin, "height" : TextOptionalDesign.height]
        let views = ["stack": helpingTextStackView!, "self": self]
        let constraintH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stack]-0-|", options: .directionLeftToRight, metrics: metrics, views: views)
        let constraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[stack(>=height)]", options: .directionLeftToRight, metrics: metrics, views: views)
        self.addConstraints(constraintV)
        self.addConstraints(constraintH)
        return
    }
    
    func createIconImageView() {
        guard let image = icon, iconImageView.superview == nil else {
            return
        }
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: TextFieldStateDesign.iconSize.height),
            iconImageView.widthAnchor.constraint(equalToConstant: TextFieldStateDesign.iconSize.width),
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: TextFieldStateDesign.horizentalPadding),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        ])
        iconImageView.image = image
        titleLeftMargin.constant = inputInset.left
    }
    
    func createActionButton() {
        guard let imageIcon = actionIcon, actionButton.superview == nil else {
            return
        }
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        superview?.addSubview(actionButton)
        
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 16).cgPath
        layerShape = CAShapeLayer()
        layerShape.path = path
        layerShape.fillColor = UIColor.clear.cgColor
        self.layer.insertSublayer(layerShape, at: 0)
        
        NSLayoutConstraint.activate([
            actionButton.widthAnchor.constraint(equalToConstant: TextFieldStateDesign.actionButtonSize.width),
            actionButton.heightAnchor.constraint(equalToConstant: TextFieldStateDesign.actionButtonSize.height),
            actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -TextFieldStateDesign.horizentalPadding),
            actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        ])
        
        actionButton.setImage(imageIcon, for: .normal)
        actionButton.setImage(actionIconSelected, for: .selected)
        titleRightMargin.constant = inputInset.right
    }
    
    func setHelpingText(_ text: String) {
        let attrText = NSMutableAttributedString(string: text)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 0
        paragraph.lineBreakMode = .byWordWrapping
        attrText.addAttribute(.paragraphStyle, value: paragraph, range:NSRange(location: 0, length: helpingText.utf16.count ))
        helpingTextLabel.attributedText = attrText
        if inputState != .error {
            tempHelpingText = text
        }
    }
    
    func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        if self.constraints.contains(where: { $0.firstAttribute == .height }) {
            heightConstraint = self.constraints.filter({ $0.firstAttribute == .height }).first!
            
        }else {
            heightConstraint = self.heightAnchor.constraint(equalToConstant: TextFieldStateDesign.height)
            heightConstraint.isActive = true
        }
        self.textField?.borderStyle = .none
        self.backgroundColor = TextFieldStateDesign.Normal.backgroundColor
        self.view?.layer.cornerRadius = TextFieldStateDesign.cornerRadius
        self.view?.layer.borderWidth = TextFieldStateDesign.border
        self.view?.layer.borderColor = TextFieldStateDesign.Normal.borderColor.cgColor
        
        self.textField?.font = TextFieldStateDesign.Normal.contentFont
        self.textField?.textColor = TextFieldStateDesign.Normal.contentTextColor
        
        self.textView?.font = TextFieldStateDesign.Normal.contentFont
        self.textView?.textColor = TextFieldStateDesign.Normal.contentTextColor
    }
    
    //MARK: - Layout update
    
    func updateLayoutByState() {
        switch inputState {
        case .idle:
            titleTopConstraint.isActive = hasPlaceholder
            titleLabel.font = TextFieldStateDesign.Normal.titleFont
            titleLabel.textColor = TextFieldStateDesign.Normal.titleColor
            self.layer.borderColor = TextFieldStateDesign.Normal.borderColor.cgColor
            self.backgroundColor = TextFieldStateDesign.Normal.backgroundColor
            textField?.textColor = TextFieldStateDesign.Normal.contentTextColor
            textView?.textColor = TextFieldStateDesign.Normal.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Normal.color
            helpingTextIconImageView.isHidden = true
        case .focus:
            titleTopConstraint.isActive = true
            titleLabel.font = TextFieldStateDesign.Focus.titleFont
            titleLabel.textColor = TextFieldStateDesign.Focus.titleColor
            self.layer.borderColor = TextFieldStateDesign.Focus.borderColor.cgColor
            self.backgroundColor = TextFieldStateDesign.Focus.backgroundColor
            textField?.textColor = TextFieldStateDesign.Focus.contentTextColor
            textView?.textColor = TextFieldStateDesign.Focus.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Normal.color
            helpingTextIconImageView.isHidden = true
        case .typing:
            titleTopConstraint.isActive = true
            titleLabel.font = TextFieldStateDesign.Typing.titleFont
            titleLabel.textColor = TextFieldStateDesign.Typing.titleColor
            self.layer.borderColor = TextFieldStateDesign.Typing.borderColor.cgColor
            self.backgroundColor = TextFieldStateDesign.Typing.backgroundColor
            textField?.textColor = TextFieldStateDesign.Typing.contentTextColor
            textView?.textColor = TextFieldStateDesign.Typing.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Normal.color
            helpingTextIconImageView.isHidden = true
        case .typed:
            titleTopConstraint.isActive = true
            titleLabel.font = TextFieldStateDesign.Typed.titleFont
            titleLabel.textColor = TextFieldStateDesign.Typed.titleColor
            self.layer.borderColor = TextFieldStateDesign.Typed.borderColor.cgColor
            self.backgroundColor = TextFieldStateDesign.Typed.backgroundColor
            textField?.textColor = TextFieldStateDesign.Typed.contentTextColor
            textView?.textColor = TextFieldStateDesign.Typed.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Normal.color
            helpingTextIconImageView.isHidden = true
        case .disabled:
            titleTopConstraint.isActive = hasTextInput || hasPlaceholder
            titleLabel.font = hasTextInput || hasPlaceholder ? TextFieldStateDesign.Disable.titleSmall : TextFieldStateDesign.Normal.titleFont
            titleLabel.textColor = TextFieldStateDesign.Disable.titleColor
            self.layer.borderColor = TextFieldStateDesign.Disable.borderColor.cgColor
            self.backgroundColor = TextFieldStateDesign.Disable.backgroundColor
            textField?.textColor = TextFieldStateDesign.Disable.contentTextColor
            textView?.textColor = TextFieldStateDesign.Disable.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Disable.color
            helpingTextIconImageView.isHidden = true
        case .error:
            titleTopConstraint.isActive = true
            titleLabel.font = TextFieldStateDesign.Error.titleFont
            titleLabel.textColor = TextFieldStateDesign.Error.titleColor
            self.layer.borderColor = TextFieldStateDesign.Error.borderColor.cgColor
            self.backgroundColor = TextFieldStateDesign.Error.backgroundColor
            textField?.textColor = TextFieldStateDesign.Error.contentTextColor
            textView?.textColor = TextFieldStateDesign.Error.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Error.color
            helpingTextIconImageView.isHidden = false
            
            textField?.placeholder = tempPlaceHolder
        }
        titleCenterConstraint.isActive = titleTopConstraint.isActive.revert
    }
    
    
    func updateLayout() {
        actionButton.isSelected = (inputState == .focus)
        actionButton.alpha = (inputState == .disabled) ? 0.5 : 1
        iconImageView.alpha = (inputState == .disabled) ? 0.5 : 1
        updateLayoutByState()
        
        if self.inputState != .error, let temp = self.tempHelpingText, temp.isNotEmpty {
            if temp.isNotEmpty {
                self.helpingText = temp
            }else {
                self.helpingText = ""
            }
        }
        
        UIView.animate(withDuration: 0.2, delay: 0,
                       options: [.allowUserInteraction, .beginFromCurrentState]) {
            self.layoutIfNeeded()
        } completion: { [weak self] (finished) in
            switch self?.inputState {
            case .idle, .disabled:
                if let holder = self?.textField?.placeholder, holder.isNotEmpty {
                    self?.tempPlaceHolder = holder
                    self?.textField?.placeholder = ""
                }
            default:
                if let holder = self?.tempPlaceHolder, holder.isNotEmpty {
                    self?.textField?.placeholder = holder
                }
            }
        }
    }
    
}

extension Bool {
    public var revert: Bool {
        return !self
    }
}

extension String {
    public var isNotEmpty: Bool {
        return self.isEmpty.revert
    }
}
