//
//  GhostLargeButton.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 18/2/2564 BE.
//

import UIKit

@IBDesignable
final class GhostLargeButton: TTBBaseButton {
    
    override func draw(_ rect: CGRect) {
        buttonDesign = .ghost(.large, darkMode)
        super.draw(rect)
    }
}
