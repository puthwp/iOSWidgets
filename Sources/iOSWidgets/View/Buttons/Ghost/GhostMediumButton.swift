//
//  GhostMediumButton.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 18/2/2564 BE.
//

import UIKit

@IBDesignable
public final class GhostMediumButton: TTBBaseButton {
    
    public override func draw(_ rect: CGRect) {
        buttonDesign = .ghost(.medium, darkMode)
        super.draw(rect)
    }
}
