//
//  TTBButtonType.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 18/2/2564 BE.
//
import UIKit

enum TTBButtonSize: Int {
    case large = 0
    case medium = 1
    case small = 2
}

enum TTBButtonType {
    case primary(TTBButtonSize)
    case secondary(TTBButtonSize)
    case ghost(TTBButtonSize, Bool)
    
    var design: TTBButtonDesign {
        switch self {
        case let .primary(size):
            return primaryDesign(size)
        case let .secondary(size):
            return secondaryDesign(size)
        case let .ghost(size, darkMode):
            return ghostDesign(size, darkMode: darkMode)
        }
    }
    
    private func primaryDesign(_ size: TTBButtonSize) -> TTBButtonDesign {
        switch size {
            case .large:
                let normalState = TTBButtonStateDesign(font: .buttonBigWhiteCenter,
                                                       color: .primaryHonestWhite,
                                                       background: .primaryRefreshingOrange)
                let focusState = TTBButtonStateDesign(font: .buttonBigWhiteCenter,
                                                      color: .primaryHonestWhite,
                                                      background: .secondaryRefreshingOrange)
                let disableState = TTBButtonStateDesign(font: .buttonBigWhiteCenter,
                                                        color: .primaryHonestWhite,
                                                        background: .secondaryGrey20)
                return TTBButtonDesign(height: 48,
                                       radius: 24,
                                       padding: 32,
                                       normal: normalState,
                                       focus: focusState,
                                       disable: disableState)
            case .medium:
                let normalState = TTBButtonStateDesign(font: .h3WhiteLeft,
                                                       color: .primaryHonestWhite,
                                                       background: .primaryRefreshingOrange)
                let focusState = TTBButtonStateDesign(font: .h3WhiteLeft,
                                                      color: .primaryHonestWhite,
                                                      background: .secondaryRefreshingOrange)
                let disableState = TTBButtonStateDesign(font: .h3WhiteLeft,
                                                        color: .primaryHonestWhite,
                                                        background: .secondaryGrey20)
                return TTBButtonDesign(height: 40,
                                       radius: 20,
                                       padding: 16,
                                       normal: normalState,
                                       focus: focusState,
                                       disable: disableState)
            case .small:
                let normalState = TTBButtonStateDesign(font: .buttonSmallWhiteCenter,
                                                       color: .primaryHonestWhite,
                                                       background: .primaryRefreshingOrange)
                let focusState = TTBButtonStateDesign(font: .buttonSmallWhiteCenter,
                                                      color: .primaryHonestWhite,
                                                      background: .secondaryRefreshingOrange)
                let disableState = TTBButtonStateDesign(font: .buttonSmallWhiteCenter,
                                                        color: .primaryHonestWhite,
                                                        background: .secondaryGrey20)
                return TTBButtonDesign(height: 32,
                                       radius: 16,
                                       padding: 12,
                                       normal: normalState,
                                       focus: focusState,
                                       disable: disableState)
        }
    }
    
    private func secondaryDesign(_ size: TTBButtonSize) -> TTBButtonDesign {
        
        switch size {
            case .large:
                let normalState = TTBButtonStateDesign(font: .buttonBigWhiteCenter,
                                                       color: .primaryRefreshingOrange,
                                                       background: .clear,
                                                       border: 1,
                                                       borderColor: .primaryRefreshingOrange)
                let focusState = TTBButtonStateDesign(font: .buttonBigWhiteCenter,
                                                      color: .secondaryRefreshingOrange,
                                                      background: .clear,
                                                      border: 1,
                                                      borderColor: .secondaryRefreshingOrange)
                let disableState = TTBButtonStateDesign(font: .buttonBigWhiteCenter,
                                                        color: .textFieldPlaceHolder,
                                                        background: .secondaryGrey10,
                                                        border: 1,
                                                        borderColor: .secondaryGrey20)
                return TTBButtonDesign(height: 48,
                                       radius: 24,
                                       padding: 32,
                                       normal: normalState,
                                       focus: focusState,
                                       disable: disableState)
            case .medium:
                let normalState = TTBButtonStateDesign(font: .h3WhiteLeft,
                                                       color: .primaryRefreshingOrange,
                                                       background: .clear,
                                                       border: 1,
                                                       borderColor: .primaryRefreshingOrange)
                let focusState = TTBButtonStateDesign(font: .h3WhiteLeft,
                                                      color: .secondaryRefreshingOrange,
                                                      background: .clear,
                                                      border: 1,
                                                      borderColor: .secondaryRefreshingOrange)
                let disableState = TTBButtonStateDesign(font: .h3WhiteLeft,
                                                        color: .textFieldPlaceHolder,
                                                        background: .secondaryGrey10,
                                                        border: 1,
                                                        borderColor: .secondaryGrey20)
                return TTBButtonDesign(height: 40,
                                       radius: 20,
                                       padding: 16,
                                       normal: normalState,
                                       focus: focusState,
                                       disable: disableState)
            case .small:
                let normalState = TTBButtonStateDesign(font: .buttonSmallWhiteCenter,
                                                       color: .primaryRefreshingOrange,
                                                       background: .clear,
                                                       border: 1,
                                                       borderColor: .primaryRefreshingOrange)
                let focusState = TTBButtonStateDesign(font: .buttonSmallWhiteCenter,
                                                      color: .secondaryRefreshingOrange,
                                                      background: .clear,
                                                      border: 1,
                                                      borderColor: .secondaryRefreshingOrange)
                let disableState = TTBButtonStateDesign(font: .buttonSmallWhiteCenter,
                                                        color: .textFieldPlaceHolder,
                                                        background: .secondaryGrey10,
                                                        border: 1,
                                                        borderColor: .secondaryGrey20)
                return TTBButtonDesign(height: 32,
                                       radius: 16,
                                       padding: 12,
                                       normal: normalState,
                                       focus: focusState,
                                       disable: disableState)
        }
    }
    
    private func ghostDesign(_ size: TTBButtonSize, darkMode: Bool) -> TTBButtonDesign {
        let focusBackground: UIColor = darkMode ? .secondaryGrey100 : .secondaryDarkOrange10
        let focusTextColor: UIColor = darkMode ? .primaryHonestWhite : .primaryRefreshingOrange
        switch size {
        case .large:
            let normalState = TTBButtonStateDesign(font: .buttonBigWhiteCenter,
                                                   color: .primaryRefreshingOrange,
                                                   background: .clear)
            let focusState = TTBButtonStateDesign(font: .buttonBigWhiteCenter,
                                                  color: focusTextColor,
                                                  background: focusBackground)
            let disableState = TTBButtonStateDesign(font: .buttonBigWhiteCenter,
                                                    color: .textFieldPlaceHolder,
                                                    background: .clear)
            return TTBButtonDesign(height: 48,
                                   radius: 24,
                                   padding: 32,
                                   normal: normalState,
                                   focus: focusState,
                                   disable: disableState)
        case .medium:
            let normalState = TTBButtonStateDesign(font: .h3WhiteLeft,
                                                   color: .primaryRefreshingOrange,
                                                   background: .clear)
            let focusState = TTBButtonStateDesign(font: .h3WhiteLeft,
                                                  color: focusTextColor,
                                                  background: focusBackground)
            let disableState = TTBButtonStateDesign(font: .h3WhiteLeft,
                                                    color: .textFieldPlaceHolder,
                                                    background: .clear)
            return TTBButtonDesign(height: 40,
                                   radius: 20,
                                   padding: 16,
                                   normal: normalState,
                                   focus: focusState,
                                   disable: disableState)
        case .small:
            let normalState = TTBButtonStateDesign(font: .buttonSmallWhiteCenter,
                                                   color: .primaryRefreshingOrange,
                                                   background: .clear)
            let focusState = TTBButtonStateDesign(font: .buttonSmallWhiteCenter,
                                                  color: focusTextColor,
                                                  background: focusBackground)
            let disableState = TTBButtonStateDesign(font: .buttonSmallWhiteCenter,
                                                    color: .textFieldPlaceHolder,
                                                    background: .clear)
            return TTBButtonDesign(height: 32,
                                   radius: 16,
                                   padding: 12,
                                   normal: normalState,
                                   focus: focusState,
                                   disable: disableState)
        }
    }
}

struct TTBButtonDesign {
    let cornerRadius: CGFloat
    let letterSpace: CGFloat = 0.4
    let iconSize: CGSize = CGSize(width: 16, height: 16)
    let padding: CGFloat
    let height: CGFloat
    let maxWidth: CGFloat = 335
    let normalState: TTBButtonStateDesign
    let focusState: TTBButtonStateDesign
    let disableState: TTBButtonStateDesign
    let leftIcon: UIImage?
    let rightIcon: UIImage?
    
    init(height: CGFloat, radius: CGFloat, padding: CGFloat, normal: TTBButtonStateDesign, focus: TTBButtonStateDesign, disable: TTBButtonStateDesign, leftIcon: UIImage? = nil, rightIcon: UIImage? = nil) {
        self.height = height
        self.cornerRadius = radius
        self.padding = padding
        self.normalState = normal
        self.focusState = focus
        self.disableState = disable
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
    }
}

struct TTBButtonStateDesign {
    let titleFont: UIFont?
    let titleColor: UIColor
    let borderWidth: CGFloat
    let borderColor: UIColor?
    let backgroundColor: UIColor
    
    init(font: UIFont?, color: UIColor, background: UIColor, border: CGFloat? = 0, borderColor: UIColor? = nil) {
        self.titleFont = font
        self.titleColor = color
        self.backgroundColor = background
        self.borderWidth = border ?? 0
        self.borderColor = borderColor
    }
}
