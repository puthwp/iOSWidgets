//
//  PrimaryTextInput.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 28/2/2564 BE.
//

import Foundation
import UIKit

protocol PrimaryTextInput: UIView {
    
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
    var tempPlaceholder: String?  { get set }
    var tempHelpingText: String? { get set }
    var inputState: PrimaryInputState { get set }
    var countingCharacter: Bool { get set }
    var descriptionText: String? { get set }
    
    var error: PrimaryError? { get set }
    var title: String? { get set }
    var helpingText: String { get set }
    var helpingTextIcon: UIImage? { get set }
    var isEnabled: Bool { get set }
    var maximumLength: Int { get set }
    var icon: UIImage? { get set }
    var actionIcon: UIImage? { get set }
    var actionIconSelected: UIImage? { get set }
    var layerShape: CAShapeLayer { get  set }
    var borderLine: CAShapeLayer { get set }
    var helpingTextStackView: UIStackView? { get set }
    var descriptionLabel: UILabel { get set }
    var countingLabel: UILabel { get set }
    var initialHeight: CGFloat { get set }
    
    func notifyTextFieldIsEditting(_ notification: Notification)
    func notifyTextFieldIsBeginEditting(_ notification: Notification)
    func notifyTextFieldDidEndEdit(_ notification: Notification)
}

extension PrimaryTextInput {
    
    var hasIconImage: Bool {
        return icon != nil
    }
    
    var hasActionButton: Bool {
        return actionIcon != nil
    }
    
    var textField: PrimaryTextField? {
        return self as? PrimaryTextField
    }
    
    var textView: PrimaryTextView? {
        return self as? PrimaryTextView
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
        return textField?.placeholder?.isNotEmpty ?? false || textView?.placeholder?.isNotEmpty ?? false
    }
    
    var hasTextUnder: Bool {
        return error != nil || helpingText.isNotEmpty || descriptionText?.isNotEmpty ?? false
    }
    
    
    var inputInset: UIEdgeInsets {
        var inset = TextFieldStateDesign.inputPadding
        inset.left = hasIconImage ?
            TextFieldStateDesign.inputPadding.left + TextFieldStateDesign.iconSize.width + TextFieldStateDesign.smallGap :
            TextFieldStateDesign.inputPadding.left
        inset.right = hasActionButton ?
            TextFieldStateDesign.inputPadding.right + TextFieldStateDesign.actionButtonSize.width + TextFieldStateDesign.smallGap :
            TextFieldStateDesign.inputPadding.right
        inset.bottom = hasTextUnder ? TextOptionalDesign.height + TextOptionalDesign.topMargin + TextFieldStateDesign.inputPadding.bottom : TextFieldStateDesign.inputPadding.bottom
        return inset
    }
    
    var newCenter: CGFloat {
        return hasTextUnder ? -( max(helpingTextLabel.bounds.maxY, (TextOptionalDesign.height + TextOptionalDesign.topMargin)) / 2) : 0
    }
    
    //MARK: - Initialize
    
    func commonInit() {
        addObservers()
        createTitle()
        createIconImageView()
        createActionButton()
        setupLayout()
        createCountingText()
        createHelpingText()
        createDescriptionLabel()
        createBorder()
        tempPlaceholder = textField?.placeholder
        setPlaceHolder(input: tempPlaceholder)
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
        if let textField = notification.object as? PrimaryTextInput, textField == self {
            guard self.isEnabled else {
                return 
            }
            guard error == nil else {
                return
            }
            textField.inputState = .typing
            
            textField.updateCountingCharacter(text: textField.textField?.text ?? textField.textView?.text)
            textField.hasActionButton ? {
                if let field = textField as? PrimaryTextField {
                    field.action?(field)
                }
                if let view = textField as? PrimaryTextView {
                    view.action?(view)
                }
            }() : ()
        }
    }
    
    func notifyTextFieldDidEndEdit(_ notification: Notification){
        if let textField = notification.object as? PrimaryTextInput, textField == self {
            guard error == nil else {
                textField.updateLayout()
                return
            }
            textField.inputState = textField.hasTextInput ? .typed : .idle
            textField.countingLabel.isHidden = true
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
        titleCenterConstraint = titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: newCenter)
        titleLeftMargin = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inputInset.left)
        titleRightMargin = self.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: inputInset.right)
        
        titleCenterConstraint.isActive = true
        titleLeftMargin.isActive = true
        titleRightMargin.isActive = true
    }
    
    func createHelpingText() {
        guard helpingTextLabel.superview == nil else {
            return
        }
        helpingTextLabel.translatesAutoresizingMaskIntoConstraints = false
        helpingTextLabel.numberOfLines = 2
        helpingTextLabel.font = TextOptionalDesign.font
        helpingTextLabel.textColor = TextOptionalDesign.Normal.color
        setHelpingText(helpingText)
        
        
        helpingTextIconImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        helpingTextIconImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        helpingTextIconImageView.image = helpingTextIcon != nil ? helpingTextIcon : UIImage(named: "01Small16PxAlert", in: .module, compatibleWith: .none)
        
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
        let constraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:[stack(>=height)]-0-|", options: .directionLeftToRight, metrics: metrics, views: views)
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
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: newCenter)
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
        
//        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 16).cgPath
//        layerShape = CAShapeLayer()
//        layerShape.path = path
//        layerShape.fillColor = UIColor.clear.cgColor
//        self.layer.insertSublayer(layerShape, at: 0)
        
        NSLayoutConstraint.activate([
            actionButton.widthAnchor.constraint(equalToConstant: TextFieldStateDesign.actionButtonSize.width),
            actionButton.heightAnchor.constraint(equalToConstant: TextFieldStateDesign.actionButtonSize.height),
            actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -TextFieldStateDesign.horizentalPadding),
            actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: newCenter)
        ])
        
        actionButton.setImage(imageIcon, for: .normal)
        actionButton.setImage(actionIconSelected, for: .selected)
        titleRightMargin.constant = inputInset.right
    }
    
    func createDescriptionLabel() {
        guard descriptionLabel.superview == nil else {
            return
        }
        descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 16))
        descriptionLabel.textColor = .primaryTrustedNavy
        descriptionLabel.font = TextCountingDesign.font
        if helpingTextStackView?.superview == nil {
            createHelpingText()
        }
        helpingTextStackView?.addArrangedSubview(descriptionLabel)
    }
    
    func createCountingText() {
        guard countingLabel.superview == nil else {
            return
        }
        countingLabel = UILabel(frame: .zero)
        countingLabel.translatesAutoresizingMaskIntoConstraints = false
        countingLabel.textColor = TextCountingDesign.color
        countingLabel.font = TextCountingDesign.font
        self.addSubview(countingLabel)
        NSLayoutConstraint.activate([
            countingLabel.heightAnchor.constraint(equalToConstant: TextCountingDesign.height),
            countingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -TextCountingDesign.leftMargin),
            countingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: TextCountingDesign.topMargin)
        ])
    }
    
    var borderRect: CGRect {
        let height = hasTextUnder ? (initialHeight - TextOptionalDesign.height + TextOptionalDesign.topMargin) : initialHeight
        return CGRect(x: 0,
                      y: 0,
                      width: self.bounds.width,
                      height: initialHeight)
    }
    
    func createBorder() {
        borderLine = CAShapeLayer()
        borderLine.path = UIBezierPath(roundedRect: borderRect, cornerRadius: TextFieldStateDesign.cornerRadius).cgPath
        borderLine.fillColor = UIColor.primaryHonestWhite.cgColor
        borderLine.lineWidth = 1
        borderLine.strokeColor = UIColor.red.cgColor
        self.layer.insertSublayer(borderLine, at: 1)
    }
    
    func resizeBound() {
        borderLine.path = UIBezierPath(roundedRect: borderRect, cornerRadius: TextFieldStateDesign.cornerRadius).cgPath
    }
    
    var heightWithTextUnder: CGFloat {
        return initialHeight + TextOptionalDesign.height + TextOptionalDesign.topMargin
    }
    
    var realHeight: CGFloat {
        return hasTextUnder ? heightWithTextUnder : initialHeight
    }
    
    func setHelpingText(_ text: String) {
        heightConstraint.constant = realHeight
        descriptionLabel.isHidden = true
        helpingTextLabel.isHidden = false
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
    
    func setDescriptionText(_ text: String?) {
        heightConstraint.constant = realHeight
        helpingTextLabel.isHidden = true
        descriptionLabel.isHidden = false
        descriptionLabel.textAlignment = .right
        descriptionLabel.text = text
    }
    
    func updateCountingCharacter(text: String?) {
        countingLabel.isHidden = self.countingCharacter.revert
        let count = text?.utf16.count ?? 0
        countingLabel.isHidden = (count == 0)
        guard self.countingCharacter else {
            return
        }
        countingLabel.text = String(format: "%d/%d", count, maximumLength)
        countingLabel.textColor = count <= maximumLength ? TextCountingDesign.color : .red
    }
    
    func setPlaceHolder(input: String?) {
        let attributePlaceholder =  NSAttributedString(string: input ?? "",
                                                       attributes: [
                                                        NSAttributedString.Key.foregroundColor: TextFieldStateDesign.Normal.contentTextColor,
                                                        NSAttributedString.Key.font: self.textField?.font! as Any
                                                       ])
        textField?.attributedPlaceholder = attributePlaceholder
    }
    
    func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        if self.constraints.contains(where: { $0.firstAttribute == .height }) {
            heightConstraint = self.constraints.filter({ $0.firstAttribute == .height }).first!
            
        }else {
            let trueHeight = hasTextUnder ? TextFieldStateDesign.height + TextOptionalDesign.height + TextOptionalDesign.topMargin : TextFieldStateDesign.height
            heightConstraint = self.heightAnchor.constraint(equalToConstant: trueHeight)
            heightConstraint.isActive = true
        }
        initialHeight = heightConstraint.constant
        self.textField?.borderStyle = .none
        self.backgroundColor = .clear
        self.borderLine.fillColor = TextFieldStateDesign.Normal.backgroundColor.cgColor
        self.view?.layer.cornerRadius = TextFieldStateDesign.cornerRadius
        self.borderLine.lineWidth = TextFieldStateDesign.border
        self.borderLine.strokeColor = TextFieldStateDesign.Normal.borderColor.cgColor
        
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
            titleLabel.font = hasPlaceholder ? TextFieldStateDesign.Focus.titleFont : TextFieldStateDesign.Normal.titleFont
            titleLabel.textColor = TextFieldStateDesign.Normal.titleColor
            self.borderLine.strokeColor = TextFieldStateDesign.Normal.borderColor.cgColor
            self.borderLine.fillColor = TextFieldStateDesign.Normal.backgroundColor.cgColor
            textField?.textColor = TextFieldStateDesign.Normal.contentTextColor
            textView?.textColor = TextFieldStateDesign.Normal.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Normal.color
            helpingTextIconImageView.isHidden = true
        case .focus:
            titleTopConstraint.isActive = true
            titleLabel.font = TextFieldStateDesign.Focus.titleFont
            titleLabel.textColor = TextFieldStateDesign.Focus.titleColor
            self.borderLine.strokeColor = TextFieldStateDesign.Focus.borderColor.cgColor
            self.borderLine.fillColor = TextFieldStateDesign.Focus.backgroundColor.cgColor
            textField?.textColor = TextFieldStateDesign.Focus.contentTextColor
            textView?.textColor = TextFieldStateDesign.Focus.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Normal.color
            helpingTextIconImageView.isHidden = true
            textField?.placeholder = tempPlaceholder
        case .typing:
            titleTopConstraint.isActive = true
            titleLabel.font = TextFieldStateDesign.Typing.titleFont
            titleLabel.textColor = TextFieldStateDesign.Typing.titleColor
            self.borderLine.strokeColor = TextFieldStateDesign.Typing.borderColor.cgColor
            self.borderLine.fillColor = TextFieldStateDesign.Typing.backgroundColor.cgColor
            textField?.textColor = TextFieldStateDesign.Typing.contentTextColor
            textView?.textColor = TextFieldStateDesign.Typing.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Normal.color
            helpingTextIconImageView.isHidden = true
            textField?.placeholder = tempPlaceholder
        case .typed:
            titleTopConstraint.isActive = true
            titleLabel.font = TextFieldStateDesign.Typed.titleFont
            titleLabel.textColor = TextFieldStateDesign.Typed.titleColor
            self.borderLine.strokeColor = TextFieldStateDesign.Typed.borderColor.cgColor
            self.borderLine.fillColor = TextFieldStateDesign.Typed.backgroundColor.cgColor
            textField?.textColor = TextFieldStateDesign.Typed.contentTextColor
            textView?.textColor = TextFieldStateDesign.Typed.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Normal.color
            helpingTextIconImageView.isHidden = true
            textField?.placeholder = tempPlaceholder
        case .disabled:
            titleTopConstraint.isActive = hasTextInput || hasPlaceholder
            titleLabel.font = hasTextInput || hasPlaceholder ? TextFieldStateDesign.Disable.titleSmall : TextFieldStateDesign.Normal.titleFont
            titleLabel.textColor = TextFieldStateDesign.Disable.titleColor
            self.borderLine.strokeColor = TextFieldStateDesign.Disable.borderColor.cgColor
            self.borderLine.fillColor = TextFieldStateDesign.Disable.backgroundColor.cgColor
            textField?.textColor = TextFieldStateDesign.Disable.contentTextColor
            textView?.textColor = TextFieldStateDesign.Disable.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Disable.color
            helpingTextIconImageView.isHidden = true
            textField?.placeholder = tempPlaceholder
        case .error:
            titleTopConstraint.isActive = true
            titleLabel.font = TextFieldStateDesign.Error.titleFont
            titleLabel.textColor = TextFieldStateDesign.Error.titleColor
            self.borderLine.strokeColor = TextFieldStateDesign.Error.borderColor.cgColor
            self.borderLine.fillColor = TextFieldStateDesign.Error.backgroundColor.cgColor
            textField?.textColor = TextFieldStateDesign.Error.contentTextColor
            textView?.textColor = TextFieldStateDesign.Error.contentTextColor
            
            helpingTextLabel.textColor = TextOptionalDesign.Error.color
            helpingTextIconImageView.isHidden = false
            
            textField?.placeholder = tempPlaceholder
        }
        titleCenterConstraint.isActive = titleTopConstraint.isActive.revert
    }
    
    
    func updateLayout() {
        actionButton.isSelected = (inputState == .focus)
        actionButton.alpha = (inputState == .disabled) ? 0.5 : 1
        iconImageView.alpha = (inputState == .disabled) ? 0.5 : 1
        
        titleCenterConstraint.constant = newCenter
        
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
        } completion: { _ in

        }
    }
    
    func createInputAccessories() -> UIView {
        let wrapper = UIView(frame: AccessoryView.wrapperSize)
        wrapper.backgroundColor = .secondaryGrey20
        
        let doneButton = GhostSmallButton(frame: AccessoryView.doneButtonSize)
        doneButton.setTitle("DONE", for: .normal)
        if #available(iOS 14.0, *) {
            let doneAction = UIAction { action in
                ///
                self.resignFirstResponder()
            }
            doneButton.addAction(doneAction, for: .touchUpInside)
        } else {
            // Fallback on earlier versions
            doneButton.addTarget(self, action: #selector(resignFirstResponder), for: .touchUpInside)
        }
        let stackWrapper = UIStackView(arrangedSubviews: [
                                        doneButton
        ])
        stackWrapper.axis = .vertical
        stackWrapper.distribution = .fill
        stackWrapper.alignment = .trailing
        stackWrapper.frame = wrapper.bounds
        stackWrapper.isLayoutMarginsRelativeArrangement = true
        stackWrapper.layoutMargins = AccessoryView.wrapperInset
        
        wrapper.addSubview(stackWrapper)
        return wrapper
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
