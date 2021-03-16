//
//  PrimaryLargeButton.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 17/2/2564 BE.
//

import UIKit

@IBDesignable
final class PrimaryLargeButton: TTBBaseButton {
    
    override func draw(_ rect: CGRect) {
        buttonDesign = .primary(.large)
        super.draw(rect)
    }
}
