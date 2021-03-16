//
//  GhostSmallButton.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 18/2/2564 BE.
//

import UIKit

@IBDesignable
final class GhostSmallButton: TTBBaseButton {
    
    override func draw(_ rect: CGRect) {
        buttonDesign = .ghost(.small, darkMode)
        super.draw(rect)
    }
}
