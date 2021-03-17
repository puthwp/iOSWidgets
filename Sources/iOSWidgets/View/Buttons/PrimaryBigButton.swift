//
//  PrimaryBigButton.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 14/3/2564 BE.
//

import Foundation
import UIKit

@IBDesignable
public final class PrimaryBigButton: UIButton {
    
    private enum Design {
        static let buttonSize = CGSize(width: 66, height: 110)
        static let iconSize = CGSize(width: 56, height: 56)
        static let smallGap: CGFloat = 8
        static let iconSizeInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let corner: CGFloat = 16
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    
    public override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var rect = super.titleRect(forContentRect: contentRect)
        rect.origin.x = 0
        rect.origin.y = Design.iconSize.height + Design.smallGap
        rect.size.width = contentRect.width
        return rect
    }

    public override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var rect = super.imageRect(forContentRect: contentRect)
        rect.origin.x = (contentRect.width / 2.0) - (rect.width / 2.0) - 5
        rect.origin.y = 0
        rect.size = Design.iconSize

        return rect.inset(by: Design.iconSizeInset)
    }

    public override var intrinsicContentSize: CGSize {
        return Design.buttonSize
    }
    
    private func setupLayout() {
        setupTitle()
        setupIconFrame()
        clipsToBounds = false
    }
    
    private func setupTitle() {
        let titleAttribute = NSMutableAttributedString(string: title(for: .normal) ?? "")
        let titleStr = title(for: .normal) ?? ""
        let range = NSRange(location: 0, length: titleStr.utf16.count)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 0
        style.alignment = .center
        titleAttribute.addAttribute(.font, value: UIFont.subtitleNavyLeft ?? UIFont.systemFont(ofSize: 14), range: range)
        titleAttribute.addAttribute(.foregroundColor, value: UIColor.primaryTrustedNavy, range: range)
        titleAttribute.addAttribute(.paragraphStyle, value: style, range: range)
        setAttributedTitle(titleAttribute, for: .normal)
        
        titleLabel?.clipsToBounds = false
        titleLabel?.numberOfLines = 2
    }
    
    private func setupIconFrame() {
        let iconBackground = UIView(frame: CGRect(x: 0, y: 0, width: Design.iconSize.width, height: Design.iconSize.height))
        iconBackground.translatesAutoresizingMaskIntoConstraints = false
        iconBackground.clipsToBounds = false
        iconBackground.backgroundColor = .primaryHonestWhite
        iconBackground.layer.borderWidth = 1
        iconBackground.layer.borderColor = UIColor.secondaryGrey20.cgColor
        iconBackground.layer.cornerRadius = Design.corner
        iconBackground.layer.shadowPath = UIBezierPath(roundedRect: iconBackground.bounds, cornerRadius: Design.corner).cgPath
        iconBackground.layer.shadowColor = UIColor.secondaryGrey20.cgColor
        iconBackground.layer.shadowRadius = 4
        iconBackground.layer.shadowOffset = CGSize(width: 0, height: 4)
        iconBackground.layer.shadowOpacity = 1
        insertSubview(iconBackground, belowSubview: imageView ?? UIImageView())
        NSLayoutConstraint.activate([
            iconBackground.heightAnchor.constraint(equalToConstant: Design.iconSize.height),
            iconBackground.widthAnchor.constraint(equalToConstant: Design.iconSize.width),
            iconBackground.centerXAnchor.constraint(equalTo: imageView?.centerXAnchor ?? centerXAnchor),
            iconBackground.centerYAnchor.constraint(equalTo: imageView?.centerYAnchor ?? centerYAnchor)
            
        ])
    }
}


