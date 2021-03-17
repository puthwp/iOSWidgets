//
//  PrimaryButton.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 17/2/2564 BE.
//

import Foundation
import UIKit

public class TTBBaseButton: UIButton {
    
    @IBInspectable var darkMode: Bool = false
    @IBInspectable var leftIcon: Bool = true
    
    var buttonDesign: TTBButtonType = .primary(.large)
    
    public override func draw(_ rect: CGRect) {
        self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        
        self.layer.cornerRadius = buttonDesign.design.cornerRadius
        self.titleLabel?.font = buttonDesign.design.normalState.titleFont
        
        self.setBackgroundImage(UIImage(color: buttonDesign.design.normalState.backgroundColor), for: .normal)
        self.setBackgroundImage(UIImage(color: buttonDesign.design.focusState.backgroundColor), for: .highlighted)
        self.setBackgroundImage(UIImage(color: buttonDesign.design.disableState.backgroundColor), for: .disabled)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        heightAnchor.constraint(equalToConstant: buttonDesign.design.height).isActive = true
        switch state {
        case .normal:
            self.titleLabel?.textColor = buttonDesign.design.normalState.titleColor
            self.layer.borderWidth = buttonDesign.design.normalState.borderWidth
            self.layer.borderColor = buttonDesign.design.normalState.borderColor?.cgColor
        case .highlighted:
            self.titleLabel?.textColor = buttonDesign.design.focusState.titleColor
            self.layer.borderWidth = buttonDesign.design.focusState.borderWidth
            self.layer.borderColor = buttonDesign.design.focusState.borderColor?.cgColor
        case .disabled:
            self.titleLabel?.textColor = buttonDesign.design.disableState.titleColor
            self.layer.borderWidth = buttonDesign.design.disableState.borderWidth
            self.layer.borderColor = buttonDesign.design.disableState.borderColor?.cgColor
        default:
            ()
        }
        
        guard let _ = self.currentImage else {
            return
        }
        self.semanticContentAttribute = leftIcon ? .forceLeftToRight : .forceRightToLeft
        if leftIcon {
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        }else {
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.sizeToFit()
        self.titleLabel?.lineBreakMode = .byTruncatingTail
    }
    
    public override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let labelMaxWidth = buttonDesign.design.maxWidth - (buttonDesign.design.padding * 2)
        var rect = super.titleRect(forContentRect: contentRect)
        rect.origin.x = buttonDesign.design.padding
        if contentRect.width > buttonDesign.design.maxWidth {
            rect.origin.x = (contentRect.width / 2) - (rect.width / 2)
        }
        rect.size.width = rect.width < labelMaxWidth ? rect.width : labelMaxWidth
        return rect
    }

    public override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var rect = super.imageRect(forContentRect: contentRect)
        rect.origin.x = buttonDesign.design.padding
        rect.origin.y = (rect.height / 2) - (buttonDesign.design.iconSize.height / 2)
        rect.size = buttonDesign.design.iconSize

        return rect
    }
    
    public override var intrinsicContentSize: CGSize {
        let rect = self.titleRect(forContentRect: self.bounds)
        var contentWidth = rect.width + (buttonDesign.design.padding * 2)
        if currentImage != nil {
            let imageRect = self.imageRect(forContentRect: self.bounds)
            contentWidth += imageRect.width
        }
        return CGSize(width: contentWidth, height: buttonDesign.design.height)
    }
    
}
