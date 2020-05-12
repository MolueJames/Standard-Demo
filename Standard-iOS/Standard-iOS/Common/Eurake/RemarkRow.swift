//
//  AreaRow.swift
//  Standard-iOS
//
//  Created by James on 2019/9/27.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import SnapKit
import Eureka

class RemarkCell: Cell<String>, CellType, AreaCell {
    
    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
    }

    open override func update() {
        super.update()
        do {
            let row: FieldRowConformance = try targetResult(self.row)
            self.label.text = row.placeholder
        } catch {
            Logger.surface.message(error)
        }
        self.textView.text = self.row.value
        let notEmply = !self.textView.text.isEmpty
        self.label.isHidden = notEmply
    }
    
    lazy var textView: UITextView! = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets.zero
        textView.keyboardType = .default
        textView.textColor = .gray
        textView.delegate = self
        return textView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0, alpha: 0.22)
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.isHidden = false
        return label
    }()
    
    override public func setup() {
        super.setup()
        self.height = { 200 }
        self.addSubview(self.textView)
        self.addSubview(self.label)
        self.detailTextLabel?.isHidden = true
        self.selectionStyle = .none
        self.setNeedsUpdateConstraints()
    }
    
    open override func updateConstraints() {
        super.updateConstraints()
        self.textView.snp.makeConstraints { [unowned self] (make) in
            do {
                let label = try self.textLabel.unwrap()
                make.right.equalTo(label.snp_right)
                make.left.equalTo(label.snp_left)
            } catch {
                Logger.surface.message(error)
            }
            make.bottom.equalTo(-5)
            make.top.equalTo(45)
        }
        self.label.snp.makeConstraints { [unowned self] (make) in
            do {
                let label = try self.textLabel.unwrap()
                make.right.equalTo(label.snp_right)
                make.left.equalTo(label.snp_left)
            } catch {
                Logger.surface.message(error)
            }
            make.top.equalTo(45)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let left = self.textLabel?.originX ?? 0
        let width = AppConfigure.ScreenWidth
        self.textLabel?.width = width - 2 * left
        self.textLabel?.originY = 0
        self.textLabel?.height = 45
    }
}

extension RemarkCell: UITextViewDelegate {
    open func textViewDidChange(_ textView: UITextView) {
        self.label.isHidden = !textView.text.isEmpty
        row.value = textView.text
    }
}


open class AreaRow<Cell: CellType>: FormatteableRow<Cell>, FieldRowConformance where Cell: BaseCell, Cell: AreaCell {
    public var placeholderColor: UIColor?
    
    open var placeholder: String?
    /// The percentage of the cell that should be occupied by the remaining space to the left of the textArea. This is equivalent to the space occupied by a title in FieldRow, making the textArea aligned to fieldRows using the same titlePercentage. This behavior works only if the cell does not contain an image, due to its automatically set constraints in the cell.
    open var titlePercentage: CGFloat?

    public required init(tag: String?) {
        super.init(tag: tag)
    }
}


final class RemarkRow: AreaRow<RemarkCell>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<RemarkCell>()
    }
}
