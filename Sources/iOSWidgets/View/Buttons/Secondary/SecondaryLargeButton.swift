//
//  SecondaryLargeButton.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 18/2/2564 BE.
//

import Foundation
import UIKit

@IBDesignable
final class SecondaryLargeButton: TTBBaseButton {
    
    override func draw(_ rect: CGRect) {
        buttonDesign = .secondary(.large)
        super.draw(rect)
    }

}
