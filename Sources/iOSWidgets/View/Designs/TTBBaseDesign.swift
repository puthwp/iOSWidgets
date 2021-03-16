//
//  TTBBaseDesign.swift
//  ComponentTest
//
//  Created by ONEAPP-IT4IT on 22/2/2564 BE.
//

import Foundation
import UIKit

private enum Design {
    static let halfScreenHeaderBackground = UIImage(imageLiteralResourceName: "heading_background")
    static let halfScreenContentRadius: CGFloat = 24
    static let halfScreenContentFrame = CGRect(x: 0, y: 280, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 280)
}

protocol TTBBaseDesign: UIViewController {
    func setNavigationDesign()
}

extension TTBBaseDesign {
    func setNavigationDesign() {
        if #available(iOS 14.0, *) {
            self.navigationItem.backButtonDisplayMode = .minimal
        } else {
            // Fallback on earlier versions
        }
        self.navigationItem.title = title
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}

protocol TTBBaseBlueDesign: TTBBaseDesign {
    func setTitleNavigation(title: String)
    func setupLayout()
}

extension TTBBaseBlueDesign {
    
    func setTitleNavigation(title: String) {
        setNavigationDesign()
        self.navigationItem.title = title
        
        self.navigationController?.navigationBar.tintColor = .primaryHonestWhite
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.buttonBigWhiteLeft ?? UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.primaryHonestWhite
        ]
    }
    
    func setupLayout() {
        self.view.backgroundColor = UIColor(patternImage: Design.halfScreenHeaderBackground)
    }
}

protocol TTBBaseWhiteDesign: TTBBaseDesign {
    func setTitleNavigation(title: String)
    func setupLayout()
}

extension TTBBaseWhiteDesign {
    
    func setTitleNavigation(title: String) {
        setNavigationDesign()
        self.navigationItem.title = title
        
        self.navigationController?.navigationBar.tintColor = .primaryTrustedNavy
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : UIFont.h2NavyLeft ?? UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.primaryTrustedNavy
        ]
    }
    
    func setupLayout() {
        self.view.backgroundColor = .primaryHonestWhite
    }
}

