//
//  PrimaryPillCategory.swift
//  ComponentTest
//
//  Created by Sitthorn Ch on 22/2/2564 BE.
//

import Foundation
import UIKit

public protocol PrimaryPillCategorySourceProtocol: class {
    typealias Pills = UIView
    func createPill(source: Pills) -> [String]?
    func sizeForItem(source: Pills, at index: Int) -> CGSize?
    func didSelected(source: Pills, item: String, index: Int)
    func didDeselected(source: Pills, item: String, index: Int)
}

@IBDesignable
public class PrimaryPillCategory: UIView {
    
    private enum Design {
        static let height: CGFloat = 32
        static let width: CGFloat = UIScreen.main.bounds.width
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
    
    public weak var source: PrimaryPillCategorySourceProtocol?
    @IBInspectable public var spacing: CGFloat = Design.spacing {
        didSet {
            wrapper.spacing = spacing
        }
    }
    @IBInspectable public var font: UIFont? = UIFont.subtitleGreyLeft
    @IBInspectable public var deselectable: Bool = true
    
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
        wrapper.spacing = spacing

        
        var categoryArray: [String] = categories?.split(separator: ",").compactMap { String($0) } ?? []
        if let input = source?.createPill(source: self), input.count > 0 {
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
        
        let itemSize = source?.sizeForItem(source: self, at: 0) ?? CGSize(width: Design.width, height: Design.height)
        let height = self.intrinsicContentSize.height > itemSize.height ? self.intrinsicContentSize.height : itemSize.height
//        let width = self.intrinsicContentSize.width
        NSLayoutConstraint.activate([
            scrollview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            scrollview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            scrollview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            scrollview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
//            scrollview.heightAnchor.constraint(equalToConstant: height),
//            self.heightAnchor.constraint(equalToConstant: height)
        ])
        
        layoutIfNeeded()
        
    }
    
    public override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        let heightConstraint = self.constraints.filter { $0.firstAttribute == .height }.first
//        let widthConstraint = self.constraints.filter { $0.firstAttribute == .width}.first
        let itemSize = source?.sizeForItem(source: self, at: 0) ?? CGSize(width: Design.width, height: Design.height)
        if let height = heightConstraint, height.constant > Design.height {
            size.height = height.constant
        }else {
            size.height = itemSize.height
        }
//        if let width = widthConstraint, width.constant > 0 {
//            size.width = width.constant
//        }else {
//            size.width = itemSize.width
//        }
////        print("xxx\(self)Contensize : \(size)")
        return size
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
            let size = source?.sizeForItem(source: self, at: index) ?? .zero
            let button = PrimaryPillItems(title: item,font: self.font, size: size)
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
        if button.isSelected && self.deselectable{
            button.isSelected = false
            source?.didDeselected(source: self, item: allItems?[index] ?? "", index: index)
            return
        }
        
        self.buttonItems.forEach {
            $0.isSelected = false
        }
        
        button.isSelected = true
        
        source?.didSelected(source: self, item: allItems?[index] ?? "", index: index)
    }
    
    public func reloadItems() {
        clearPills()
        createPills(items: source?.createPill(source: self))
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
    
    public var buttonFont: UIFont? = Design.font
    var size: CGSize = CGSize(width: 200, height: Design.height) {
        didSet {
            setItemSize(inputSize: size)
        }
    }
    var dynamicWidth: CGFloat {
        return (self.titleLabel?.bounds.width ?? 0) + (Design.padding * 2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    init(title: String, font: UIFont?, size: CGSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.buttonFont = font
        if size != .zero {
            self.size = size
            print("xxxSetSize:\(size)")
        }
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        self.layer.borderColor = (isSelected ? Design.Selected.borderColor : Design.Normal.borderColor).cgColor
        self.titleLabel?.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        self.setItemSize(inputSize: self.size)
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
        
        
        self.titleLabel?.font = self.buttonFont
        self.titleLabel?.sizeToFit()
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        let width = dynamicWidth > self.size.width ? dynamicWidth : self.size.width
        let height = self.size.height
        self.size = CGSize(width: width, height: height)
        setItemSize(inputSize: CGSize(width: width, height: height))
    }
    
    public func setItemSize(inputSize: CGSize?) {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: self.size.height),
            self.widthAnchor.constraint(equalToConstant: self.size.width)
        ])
    }
}
