//
//  TabBarController.swift
//  YunZhouFoundation
//
//  Created by James on 2018/4/17.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import UIKit

open class TabBarController: UITabBarController {

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        get {
           return self.selectedViewController
        }
    }
}
