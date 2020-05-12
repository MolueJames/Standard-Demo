//
//  CollectionRow.swift
//  Standard-iOS
//
//  Created by 程成 on 2019/4/26.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import ObjectMapper
import Eureka
import UIKit

class MultipleItemCell<T: Equatable & CustomStringConvertible>: Cell<[T]>, CellType, UITableViewDataSource, UITableViewDelegate {
    
    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.insertInterfaceElement()
        self.updateInterfaceElement()
    }
    
    private func insertInterfaceElement() {
        self.addSubview(self.insertButton)
        self.addSubview(self.tableView)
    }
    
    private func updateInterfaceElement() {
        self.insertButton.snp.makeConstraints { (make) in
            let right = AppConfigure.isPad ? -20 : -15
            make.right.equalTo(right)
            make.height.equalTo(45)
            make.width.equalTo(50)
            make.top.equalTo(0)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(40)
        }
    }
    
    private func updateUserInterface() {
        guard let value = self.row.value else { return }
        self.height = { CGFloat(value.count * 55) + 50 }
        self.height = CGFloat(value.count * 55 + 50 )
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var insertButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(CommonColor.appDefault, for: .normal)
        let selector: Selector = #selector(insertButtonClicked)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("添加", for: .normal)
        return button
    }()
    
    @IBAction func insertButtonClicked(_ sender: Any) {
        do {
            try self.insertClosure.unwrap()()
        } catch {
            Logger.surface.message(error)
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(nibWithCellClass: MultipleItemTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func setup() {
        super.setup()
        self.detailTextLabel?.isHidden = true
        self.selectionStyle = .none
    }
    
    override func update() {
        super.update()
        self.tableView.reloadData()
        self.updateUserInterface()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let left = self.textLabel?.originX ?? 0
        let width = AppConfigure.ScreenWidth - 60
        self.textLabel?.width = width - left
        self.textLabel?.originY = 13
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            let value = try self.row.value.unwrap()
            return value.count
        } catch { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MultipleItemTableViewCell.self)
        do {
            let value = try self.row.value.unwrap()
            let item = value.item(at: indexPath.row)
            let name = try item.unwrap().description
            cell.refreshSubviews(with: name)
        } catch {
            Logger.surface.message(error)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            let value = try self.row.value.unwrap()
            let item = try value.item(at: indexPath.row).unwrap()
            let selectClosure = try self.selectClosure.unwrap()
            selectClosure(item, indexPath.row)
        } catch {
            Logger.surface.message(error)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    public var selectClosure: ((T, Int) -> Void)?

    public var insertClosure: (() -> Void)?
}

final class MultipleItemRow<T: Equatable & CustomStringConvertible>: Row<MultipleItemCell<T>>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<MultipleItemCell<T>>()
    }
}
