//
//  SecondaryMediumButton.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 18/2/2564 BE.
//

import UIKit

@IBDesignable
final class SecondaryMediumButton: TTBBaseButton {
    
    override func draw(_ rect: CGRect) {
        buttonDesign = .secondary(.medium)
        super.draw(rect)
    }
}
