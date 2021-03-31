//
//  PrimaryTextInputConstants.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 28/2/2564 BE.
//

import Foundation
import UIKit

public protocol PrimaryError: Error {
    var description: String? { get }
}

public enum PrimaryInputState: String {
    case idle
    case focus //first responder with no text
    case typing //first responder with text
    case typed //resign with text
    case error
    case disabled
}



enum TextOptionalDesign {
    static let font = UIFont.labelGreyLeft
    static let topMargin: CGFloat = 4.0
    static let height: CGFloat = 16.0
    enum Normal {
        static let color = UIColor.helpingTextDefault
    }
    enum Error {
        static let color = UIColor.helpingTextError
    }
    enum Disable {
        static let color = UIColor.textFieldPlaceHolder
    }
}

enum TextCountingDesign {
    static let font = UIFont.labelGreyLeft
    static let topMargin: CGFloat = 8.0
    static let height: CGFloat = 16.0
    static let leftMargin: CGFloat = 12
    static let color = UIColor.textFieldCounting
}

enum TextFieldStateDesign {
    static let height: CGFloat = 60
    static let border: CGFloat = 1
    static let inputPadding = UIEdgeInsets(top: 29, left: 12, bottom: 8, right: 12)
    static let cornerRadius: CGFloat = 12
    static let contentFont = UIFont.paragraphSmallGreyLeft
    static let contentColor = UIColor.primaryTrustedNavy
    static let horizontalPadding: CGFloat = 12
    static let iconSize = CGSize(width: 24, height: 24)
    static let smallGap: CGFloat = 8
    static let actionButtonSize = CGSize(width: 24, height: 24)
    enum Normal {
        static let borderColor = UIColor.secondaryGrey50
        static let titleFont = UIFont.paragraphSmallDisabledLeft
        static let titleColor = UIColor.textFieldPlaceHolder
        static let contentFont = UIFont.paragraphSmallGreyLeft
        static let contentTextColor = UIColor.textFieldPlaceHolder
        static let backgroundColor = UIColor.primaryHonestWhite
        static let displayIcon = false
    }
    enum Focus {
        static let borderColor = UIColor.primaryConfidentBlue
        static let titleFont = UIFont.labelNavyLeft
        static let titleColor = UIColor.primaryTrustedNavy
        static let contentFont = UIFont.paragraphSmallGreyLeft
        static let contentTextColor = UIColor.primaryTrustedNavy
        static let backgroundColor = UIColor.primaryHonestWhite
        static let displayIcon = false
    }
    enum Typing {
        static let borderColor = UIColor.primaryConfidentBlue
        static let titleFont = UIFont.labelNavyLeft
        static let titleColor = UIColor.primaryTrustedNavy
        static let contentFont = UIFont.paragraphSmallGreyLeft
        static let contentTextColor = UIColor.primaryTrustedNavy
        static let backgroundColor = UIColor.primaryHonestWhite
        static let displayIcon = false
    }
    enum Typed {
        static let borderColor = UIColor.secondaryGrey50
        static let titleFont = UIFont.labelGreyLeft
        static let titleColor = UIColor.helpingTextDefault
        static let contentFont = UIFont.paragraphSmallGreyLeft
        static let contentTextColor = UIColor.primaryTrustedNavy
        static let backgroundColor = UIColor.primaryHonestWhite
        static let displayIcon = false
    }
    enum Error {
        static let borderColor = UIColor.utilityRedError70
        static let titleFont = UIFont.labelGreyLeft
        static let titleColor = UIColor.helpingTextDefault
        static let contentFont = UIFont.paragraphSmallGreyLeft
        static let contentTextColor = UIColor.primaryTrustedNavy
        static let backgroundColor = UIColor.primaryHonestWhite
        static let displayIcon = true
    }
    enum Disable {
        static let borderColor = UIColor.secondaryGrey20
        static let titleFont = UIFont.paragraphSmallDisabledLeft
        static let titleSmall = UIFont.labelDisabledLeft
        static let titleColor = UIColor.textFieldPlaceHolder
        static let contentFont = UIFont.paragraphSmallGreyLeft
        static let contentTextColor = UIColor.textFieldPlaceHolder
        static let backgroundColor = UIColor.secondaryGrey10
        static let displayIcon = true
    }
}

enum AccessoryView {
    static let wrapperSize = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
    static let doneButtonSize = CGRect(x: 0, y: 0, width: 100, height: 28)
    static let wrapperInset =  UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
}
