//
//  PrimaryPillCategory.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 22/2/2564 BE.
//

import Foundation
import UIKit

@objc public protocol PillCategorySourceProtocol: class {
    func createPill() -> [String]?
    @objc optional func sizeForItem(at index: Int) -> CGSize
    func didSelected(item: String, index: Int)
    func didDeselected(item: String, index: Int)
}

@IBDesignable
public class PrimaryPillCategory: UIView {
    
    private enum Design {
        static let height: CGFloat = 32
        static let spacing: CGFloat = 8
    }
    
    private let scrollview = UIScrollView(frame: .zero)
    private let wrapper = UIStackView(frame: .zero)
    private var allItems: [String]?
    private var buttonItems: [PrimaryPillItems] = []
    
    @IBInspectable public var categories: String? {
        didSet {
            setupLayout()
        }
    }
    
    public weak var inoutSource: PillCategorySourceProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    
    private func setupLayout() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        
        self.clipsToBounds = false
        wrapper.clipsToBounds = false
        scrollview.clipsToBounds = false
        
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        
        self.backgroundColor = .clear
        scrollview.backgroundColor = .clear
        wrapper.backgroundColor = .clear
        
        wrapper.axis = .horizontal
        wrapper.alignment = .fill
        wrapper.distribution = .fill
        wrapper.spacing = Design.spacing

        
        var categoryArray: [String] = categories?.split(separator: ",").compactMap { String($0) } ?? []
        if let input = inoutSource?.createPill(), input.count > 0 {
            categoryArray = input
        }
        createPills(items: categoryArray)
        
        scrollview.addSubview(wrapper)
        NSLayoutConstraint.activate([
            wrapper.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor, constant: 0),
            wrapper.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor, constant: 0),
            wrapper.topAnchor.constraint(equalTo: scrollview.topAnchor, constant: 0),
            wrapper.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor, constant: 0),
            wrapper.heightAnchor.constraint(equalToConstant: Design.height)
        ])
        
        self.addSubview(scrollview)
        NSLayoutConstraint.activate([
            scrollview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            scrollview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            scrollview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            scrollview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            scrollview.heightAnchor.constraint(equalToConstant: Design.height),
            self.heightAnchor.constraint(equalToConstant: Design.height)
        ])
        
        layoutIfNeeded()
        
    }
    
    private func clearPills() {
        buttonItems.removeAll()
        wrapper.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    private func createPills(items: [String]?) {
        guard let items = items else {
            let button = PrimaryPillItems(title: "xxxitemxxx")
            wrapper.addArrangedSubview(button)
            button.showAnimatedSkeleton()
            return
        }
        clearPills()
        for (index,item) in items.enumerated() {
            let button = PrimaryPillItems(title: item)
            let size = inoutSource?.sizeForItem?(at: index)
            button.setItemSize(size: size)
            if #available(iOS 14.0, *) {
                button.addAction(UIAction(handler: { [weak self] action in
                    let button = action.sender as? UIButton
                    self?.didSelected(button: button!)
                }), for: .touchUpInside)
            } else {
                // Fallback on earlier versions
                button.addTarget(self, action: #selector(didSelected(button:)), for: .touchUpInside)
            }
            button.tag = index
            buttonItems.append(button)
            wrapper.addArrangedSubview(button)
        }
    }
    
    @objc func didSelected(button: UIButton) {
        let index = button.tag
        if button.isSelected {
            button.isSelected = false
            inoutSource?.didDeselected(item: allItems?[index] ?? "", index: index)
            return
        }
        
        self.buttonItems.forEach {
            $0.isSelected = false
        }
        
        button.isSelected = true
        
        inoutSource?.didSelected(item: allItems?[index] ?? "", index: index)
    }
    
    public func reloadItems() {
        clearPills()
        createPills(items: inoutSource?.createPill())
    }
}

class PrimaryPillItems: UIButton {
    
    private enum Design {
        static let height: CGFloat = 32
        static let font = UIFont.subtitleGreyLeft
        static let padding: CGFloat = 12
        
        enum Normal {
            static let backgroundColor = UIColor.primaryHonestWhite
            static let textColor = UIColor.helpingTextDefault
            static let borderColor = UIColor.secondaryGrey20
        }
        
        enum Selected {
            static let backgroundColor = UIColor.primaryTrustedNavy
            static let textColor = UIColor.primaryHonestWhite
            static let borderColor = UIColor.primaryTrustedNavy
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        setupLayout()
    }
    
    init(title: String, size: CGSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        setupLayout()
        setItemSize(size: size)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        self.layer.borderColor = (isSelected ? Design.Selected.borderColor : Design.Normal.borderColor).cgColor
        self.titleLabel?.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        self.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    private func setupLayout() {
        self.clipsToBounds = true
        self.layer.cornerRadius = Design.height / 2
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setBackgroundImage(UIImage(color: Design.Normal.backgroundColor), for: .normal)
        self.setBackgroundImage(UIImage(color: Design.Normal.backgroundColor), for: .highlighted)
        self.setBackgroundImage(UIImage(color: Design.Selected.backgroundColor), for: .selected)
        
        self.setTitleColor(Design.Normal.textColor, for: .normal)
        self.setTitleColor(Design.Selected.textColor, for: .selected)
        
        
        self.titleLabel?.font = Design.font
        self.titleLabel?.sizeToFit()
    }
    
    public func setItemSize(size: CGSize?) {
        var width = (self.titleLabel?.bounds.width ?? 0) + (Design.padding * 2)
        var height = Design.height
        if let size = size {
            width = size.width
            height = size.height
        }
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: width),
            self.widthAnchor.constraint(equalToConstant: height)
        ])
    }
}
