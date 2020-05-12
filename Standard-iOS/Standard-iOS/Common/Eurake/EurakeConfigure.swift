//
//  EurakeConfigure.swift
//  Standard-iOS
//
//  Created by James on 2019/9/21.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Eureka

public struct EurakeConfigure {
    
    public static func setDefault() {
        self.defaultRowInitial()
        self.defaultCellUpdate()
        self.GenericCellUpdate()
    }
    
    private static func defaultRowInitial() {
        let formatter = DateFormatter()
        let locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .long
        formatter.locale = locale
        DateRow.defaultCellSetup = { cell, row in
            cell.datePicker.locale = locale
        }
        DateRow.defaultRowInitializer = {
            $0.dateFormatter = formatter
        }
    }
    
    private static func GenericCellUpdate() {
        
        self.GenericRowUpdate(String.self)
    }
    
    private static func defaultCellUpdate() {
        DecimalRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
        RemarkRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
        TextRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
        IntRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
        DateRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
    }

    private static func GenericRowUpdate<T: Hashable>(_ Target: T.Type) {
        MultipleSelectorRow<T>.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
        PushRow<T>.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
        ActionSheetRow<T>.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.textLabel?.textColor = .red
            }
        }
    }
}

extension FormViewController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return .lightContent }
    }
    open override var prefersStatusBarHidden: Bool {
        get { return false }
    }
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        get { return .slide }
    }
}

extension Form {
    func isValidateFailed(includeHidden: Bool = false) -> Bool {
        return self.validate(includeHidden: includeHidden).count > 0
    }
}
