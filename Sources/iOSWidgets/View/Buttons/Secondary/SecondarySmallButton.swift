//
//  SecondarySmallButton.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 18/2/2564 BE.
//

import UIKit

@IBDesignable
final class SecondarySmallButton: TTBBaseButton {
    
    override func draw(_ rect: CGRect) {
        buttonDesign = .secondary(.small)
        super.draw(rect)
    }
}
