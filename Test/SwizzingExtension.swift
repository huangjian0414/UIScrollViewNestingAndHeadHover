//
//  SwizzingExtension.swift
//  Test
//
//  Created by huangjian on 2019/4/30.
//  Copyright © 2019 huangjian. All rights reserved.
//

import Foundation
import UIKit

/// swizzling协议 在需要交换方法的类中遵循此协议，实现方法awake
protocol SelfAware: class {
    static func awake()
}

extension UIApplication {
    private static let runOnce: Void = {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAware.Type)?.awake()
        }
        types.deallocate()
    }()
    
    open override var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}

