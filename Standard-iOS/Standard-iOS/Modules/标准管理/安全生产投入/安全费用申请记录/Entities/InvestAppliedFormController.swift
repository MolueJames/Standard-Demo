//
//  InvestAppliedFormController.swift
//  
//
//  Created by MolueJames on 2020/3/12.
//

import UIKit
import Eureka

class InvestAppliedFormController: BaseFormController {

    public var currentItem: InvestAppliedEntity?
    
    lazy var submitBarItem: UIBarButtonItem = {
        let selector: Selector = #selector(submitBarItemClicked)
        return UIBarButtonItem(title: "提交", style: .plain, target: self, action: selector)
    }()
    
    lazy var deleteBarItem: UIBarButtonItem = {
        let selector: Selector = #selector(deleteBarItemClicked)
        return UIBarButtonItem(title: "删除", style: .plain, target: self, action: selector)
    }()
    
    @IBAction func deleteBarItemClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "您确定要删除该条数据吗?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .destructive) { [unowned self] (action) in
            self.validateDeleteItem(with: self.currentItem)
        })
        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func submitBarItemClicked(_ sender: UIBarButtonItem) {
        if form.isValidateFailed() == true {
            let message = form.validate().first?.msg
            self.showFailureHUD(text: message ?? "")
        } else if let currentItem = self.currentItem {
            let currentItem = currentItem.update(from: form.values())
            self.doUpdateItemRequest(with: currentItem)
        } else {
            let currentItem = InvestAppliedEntity(from: form.values())
            self.doInsertItemRequest(with: currentItem)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = StandardInvest.applied.queryModuleName()
        
        if self.currentItem.isNone() {
            self.navigationItem.rightBarButtonItem = self.submitBarItem
        } else {
            let barItems = [self.deleteBarItem, self.submitBarItem]
            self.navigationItem.rightBarButtonItems = barItems
        }
    }
}

extension InvestAppliedFormController: ItemCrudRequestProtocol {
    func validateDeleteItem(with item: InvestAppliedEntity?) {
        do {
            try self.doDeleteItemRequest(with: item.unwrap())
        } catch {
            Logger.network.message(error)
        }
    }
    
    func doUpdateItemRequest(with item: InvestAppliedEntity) {
        let request = InvestService.updateApplied(with: item.toJson())
        request.handleSuccessResponse { [weak self] (result) in
            do {
                let notify = InvestAppliedNotification.update
                try self.unwrap().handleSuccess(with: notify)
            } catch {
                Logger.surface.message(error)
            }
        }
        request.handleFailureResponse { (error) in
            let message = error.localizedDescription
            Logger.network.message(message)
        }
        let requestManager = RequestManager(delegate: self)
        requestManager.doResume(with: request)
    }
    
    func doDeleteItemRequest(with item: InvestAppliedEntity) {
        let request = InvestService.deleteApplied(with: item.toJson())
        request.handleSuccessResponse { [weak self] (result) in
            do {
                let notify = InvestAppliedNotification.delete
                try self.unwrap().handleSuccess(with: notify)
            } catch {
                Logger.surface.message(error)
            }
        }
        request.handleFailureResponse { (error) in
            let message = error.localizedDescription
            Logger.network.message(message)
        }
        let requestManager = RequestManager(delegate: self)
        requestManager.doResume(with: request)
    }
    
    func doInsertItemRequest(with item: InvestAppliedEntity) {
        let request = InvestService.insertApplied(with: item.toJson())
        request.handleSuccessResponse { [weak self] (result) in
            do {
                let notify = InvestAppliedNotification.insert
                try self.unwrap().handleSuccess(with: notify)
            } catch {
                Logger.surface.message(error)
            }
        }
        request.handleFailureResponse { (error) in
            Logger.surface.message(error)
        }
        let requestManager = RequestManager(delegate: self)
        requestManager.doResume(with: request)
    }
}

extension InvestAppliedFormController: UserInterfaceProtocol {
    func queryInformationWithNetwork() {
        
    }

    func updateUserInterfaceElements() {
        form +++ PushRow<CollectDepartEntity>("depart") { [unowned self] in
            let optionsProvider = OptionsProvider(delegate: self)
            $0.optionsProvider = .lazy({ (form, completion) in
                optionsProvider.queryCollectDepart(completion)
            })
            let placeholder: String = "请选择申请部门"
            $0.add(rule: RuleRequired(msg: placeholder))
            $0.value = self.currentItem?.depart
            $0.title = "申请部门"
        }
        <<< DateRow("date") { [unowned self] in
            let placeholder: String = "请选择申请日期"
            $0.add(rule: RuleRequired(msg: placeholder))
            let date = self.currentItem?.date
            $0.value = date?.date(withFormat: Format.date)
            $0.title = "申请日期"
        }
        <<< TextRow("name") { [unowned self] in
            let placeholder: String = "请输入项目名称"
            $0.add(rule: RuleRequired(msg: placeholder))
            $0.placeholder = placeholder
            $0.value = self.currentItem?.name
            $0.title = "项目名称"
        }
        <<< PushRow<String>("nature") { [unowned self] in
            $0.options = OptionsProvider.investRange
            let placeholder: String = "请选择项目性质"
            $0.add(rule: RuleRequired(msg: placeholder))
            $0.value = self.currentItem?.nature
            $0.title = "项目性质"
        }
        <<< DecimalRow("invest") { [unowned self] in
            let placeholder: String = "请输入投资总额"
            $0.add(rule: RuleRequired(msg: placeholder))
            $0.placeholder = placeholder
            $0.value = self.currentItem?.invest
            $0.title = "投资总额"
        }
        <<< TextRow("reason") { [unowned self] in
            let placeholder: String = "请输入申请理由及效果"
            $0.add(rule: RuleRequired(msg: placeholder))
            $0.placeholder = placeholder
            $0.value = self.currentItem?.reason
            $0.title = "申请理由及效果"
        }
        <<< TextRow("explain") { [unowned self] in
            let placeholder: String = "请输入工艺及布置说明"
            $0.add(rule: RuleRequired(msg: placeholder))
            $0.placeholder = placeholder
            $0.value = self.currentItem?.explain
            $0.title = "工艺及布置说明"
        }
        <<< TextRow("content") { [unowned self] in
            let placeholder: String = "请输入项目主要内容"
            $0.add(rule: RuleRequired(msg: placeholder))
            $0.placeholder = placeholder
            $0.value = self.currentItem?.content
            $0.title = "项目主要内容"
        }
        <<< IntRow("count") { [unowned self] in
            let placeholder: String = "请输入所需材料数量"
            $0.add(rule: RuleRequired(msg: placeholder))
            $0.placeholder = placeholder
            $0.value = self.currentItem?.count
            $0.title = "所需材料数量"
        }
        <<< DateRow("deadLine") { [unowned self] in
            let placeholder: String = "请选择完成日期"
            $0.add(rule: RuleRequired(msg: placeholder))
            let date = self.currentItem?.deadLine
            $0.value = date?.date(withFormat: Format.date)
            $0.title = "完成日期"
        }
        <<< ActionSheetRow<String>("suggest") { [unowned self] in
            let placeholder: String = "请选择审批意见"
            $0.add(rule: RuleRequired(msg: placeholder))
            $0.options = ["审批通过", "审批失败", "暂未审批"]
            $0.value = self.currentItem?.suggest
            $0.title = "审批意见"
        }
        <<< RemarkRow("remark") { [unowned self] in
            let placeholder: String = "请输入安全申请备注"
            $0.add(rule: RuleRequired(msg: placeholder))
            $0.placeholder = placeholder
            $0.value = self.currentItem?.remark
            $0.title = "安全申请备注"
        }
    }
}
