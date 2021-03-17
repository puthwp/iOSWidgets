//
//  PrimarySmallButton.swift
//  OneAppWidget
//
//  Created by SIDDHANT-TCS on 16/2/2564 BE.
//

import UIKit

@IBDesignable
public final class PrimarySmallButton: TTBBaseButton {
    public override func draw(_ rect: CGRect) {
        buttonDesign = .primary(.small)
        super.draw(rect)
    }
}
