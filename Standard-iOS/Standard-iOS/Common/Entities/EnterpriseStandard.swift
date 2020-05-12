//
//  EnterpriseModuleEntity.swift
//  Standard-iOS
//
//  Created by 程成 on 2019/7/30.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import UIKit

public protocol EnterpriseModuleProtocol {
    
    func targetController() -> UIViewController
    
    func queryModuleName() -> String
}

public enum EnterpriseStandard: EnterpriseModuleProtocol, CaseIterable {
    public func queryModuleName() -> String {
        switch self {
        case .collect: return "企业汇总数据"
        case .target: return "企业安全目标"
        case .depart: return "组织机构与职责"
        case .invest: return "安全生产投入"
        case .legals: return "法规与制度管理"
        case .trains: return "安全教育培训"
        case .device: return "生产设备设施"
        case .operate: return "生产作业安全"
        case .danger: return "隐患排查和治理"
        case .monitor: return "重大危险源监控"
        case .health: return "企业职业健康"
        case .rescue: return "企业应急救援"
        case .report: return "事故报告调查和处理"
        case .update: return "绩效评定和持续改进"
        }
    }
    
    public func targetController() -> UIViewController {
        return UIViewController()
    }
    
    func querySubmodule() -> [EnterpriseModuleProtocol] {
        switch self {
        case .collect: return StandardCollect.allCases
        case .target: return StandardTarget.allCases
        case .depart: return StandardDepart.allCases
        case .invest: return StandardInvest.allCases
        case .legals: return StandardLegals.allCases
        case .trains: return StandardTrains.allCases
        case .device: return StandardDevice.allCases
        case .operate: return StandardOperate.allCases
        case .danger: return StandardDanger.allCases
        case .monitor: return StandardMonitor.allCases
        case .health: return StandardHealth.allCases
        case .rescue: return StandardRescue.allCases
        case .report: return StandardReport.allCases
        case .update: return StandardImprove.allCases
        }
    }
    case collect
    case target
    case depart
    case invest
    case device
    case legals
    case trains
    case operate
    case danger
    case monitor
    case health
    case rescue
    case report
    case update
}

public enum StandardCollect: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .depart:
            return UIViewController()
        case .employ:
            return UIViewController()
        case .plants:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .depart: return "企业组织架构"
        case .employ: return "企业员工信息"
        case .plants: return "企业厂区概况"
        }
    }
    case depart
    case employ
    case plants
}

public enum StandardTarget: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .meeting:
            return UIViewController()
        case .resolve:
            return UIViewController()
        case .assess:
            return UIViewController()
        case .system:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .meeting: return "安全会议记录"
        case .resolve: return "生产目标分解"
        case .system: return "安全目标制度"
        case .assess: return "安全目标考核"
        }
    }
    case system
    case meeting
    case resolve
    case assess
}

public enum StandardDepart: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .execute:
            return UIViewController()
        case .system:
            return UIViewController()
        case .update:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .system: return "生产责任管理制度"
        case .update: return "责任评审更新"
        case .execute: return "部门执行情况"
        }
    }
    case system
    
    case execute

    case update
    
}

public enum StandardInvest: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case.system:
            return UIViewController()
        case .history:
            return UIViewController()
        case .planned:
            return UIViewController()
        case .applied:
            return UIViewController()
        case .reward:
            return UIViewController()
        case .punish:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .system: return "安全费用管理制度"
        case .history: return "安全生产费用记录"
        case .planned: return "安全费用投入计划"
        case .applied: return "安全费用申请记录"
        case .reward: return "安全生产奖励记录"
        case .punish: return "安全生产处罚记录"
        }
    }
    
    case system
    case applied
    case history
    case planned
    case punish
    case reward
}

public enum StandardLegals: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .operate:
            return UIViewController()
        case .system:
            return UIViewController()
        case .manage:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .operate: return "操作规程评估修订"
        case .system: return "法规与制度管理"
        case .manage: return "管理制度评估修订"
        }
    }
    
    case system
    case operate
    case manage
}

public enum StandardTrains: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .special:
            return UIViewController()
        case .history:
            return UIViewController()
        case .operate:
            return UIViewController()
        case .system:
            return UIViewController()
        case .safety:
            return UIViewController()
        case .manage:
            return UIViewController()
        case .induct:
            return UIViewController()
        case .newpost:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .system: return "教育培训制度"
        case .special: return "特种人员培训"
        case .history: return "安全培训记录"
        case .safety: return "安全人员培训"
        case .operate: return "操作规程培训"
        case .manage: return "安全责任培训"
        case .induct: return "入职员工培训"  //TODO: need complete
        case .newpost: return "转岗复工培训" //TODO: need complete
        }
    }
    case system
    case history
    case special
    case safety
    case operate
    case newpost
    case manage
    case induct
    
}

public enum StandardDevice: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .special:
            return UIViewController()
        case .system:
            return UIViewController()
        case .normal:
            return UIViewController()
        case .unfire:
            return UIViewController()
        case .detect:
            return UIViewController()
        case .repair:
            return UIViewController()
        case .keeped:
            return UIViewController()
        case .history:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .special: return "特种设备管理"
        case .normal: return "设备设施管理"
        case .system: return "设备管理制度"
        case .unfire: return "消防器材管理"
        case .detect: return "安全设备管理"
        case .repair: return "设备维修计划"
        case .keeped: return "设备保养计划"
        case .history: return "特种设备维保"
        }
    }
    case system
    case special
    case normal
    case unfire
    case detect
    case repair
    case keeped
    case history
}

public enum StandardOperate: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .system:
            return UIViewController()
        case .provide:
            return UIViewController()
        case .procure:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .system: return "生产作业安全制度"
        case .provide: return "防护用品配备标准"
        case .procure: return "防护用品采购记录" //TODO: Test
        }
    }
    case system
    case provide
    case procure
}

public enum StandardDanger: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .system:
            return UIViewController()
        case .invest:
            return UIViewController()
        case .plan:
            return UIViewController()
        case .task:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .invest: return "隐患排查清单"
        case .system: return "排查治理制度"
        case .plan: return "风险检查计划"
        case .task: return "风险检查任务"
        }
    }
    
    case system
    case invest
    case plan
    case task
}

public enum StandardMonitor: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .system:
            return UIViewController()
        case .result:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .result: return "重大危险源监控"
        case .system: return "危险源监控制度"
        }
    }
    case system
    case result
}

public enum StandardHealth: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .system:
            return UIViewController()
        case .manage:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .system: return "职业健康管理制度"
        case .manage: return "职业病危害管理" //TODO need complete
        }
    }
    case system
    case manage
}

public enum StandardRescue: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .system:
            return UIViewController()
        case .history:
            return UIViewController()
        case .summary:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .system: return "应急救援管理制度"
        case .history: return "应急预案演练记录" //TODO: need
        case .summary: return "应急演练总结报告" //TODO: need
        }
    }
    
    case system
    case history
    case summary
}

public enum StandardReport: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .system:
            return UIViewController()
        case .history:
            return UIViewController()
        case .summary:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .system: return "安全事故管理制度"
        case .history: return "生产安全事故记录" //TODO: need
        case .summary: return "生产安全事故总结" //TODO: need
        }
    }
    case system
    case history
    case summary
}

public enum StandardImprove: EnterpriseModuleProtocol, CaseIterable {
    public func targetController() -> UIViewController {
        switch self {
        case .system:
            return UIViewController()
        }
    }
    
    public func queryModuleName() -> String {
        switch self {
        case .system: return "评定和改进管理制度"
        }
    }
    case system
}

