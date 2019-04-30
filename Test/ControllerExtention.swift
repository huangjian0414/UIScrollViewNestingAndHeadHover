//
//  ControllerExtention.swift
//  Test
//
//  Created by huangjian on 2019/4/30.
//  Copyright © 2019 huangjian. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    private struct testVCKey {
        static var sKey = "test_scrollViewKey"
    }
    
    @objc public var test_scrollView: UIScrollView? {
        get { return objc_getAssociatedObject(self, &testVCKey.sKey) as? UIScrollView }
        set { objc_setAssociatedObject(self, &testVCKey.sKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}
