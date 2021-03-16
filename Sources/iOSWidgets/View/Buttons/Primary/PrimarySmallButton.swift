//
//  PrimarySmallButton.swift
//  OneAppWidget
//
//  Created by SIDDHANT-TCS on 16/2/2564 BE.
//

import UIKit

@IBDesignable
final class PrimarySmallButton: TTBBaseButton {
    override func draw(_ rect: CGRect) {
        buttonDesign = .primary(.small)
        super.draw(rect)
    }
}
