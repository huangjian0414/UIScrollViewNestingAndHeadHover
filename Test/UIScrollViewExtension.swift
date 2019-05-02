//
//  UIScrollViewExtension.swift
//  Test
//
//  Created by huangjian on 2019/4/30.
//  Copyright © 2019 huangjian. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView : SelfAware{
    
    // SwlfAware实现方法
    static func awake() {
        changeFunc()
    }
    
    static func changeFunc() {
        let didScroll = "X25vdGlmeURpZFNjcm9sbA==".base64Decoding()
        let originSelector = Selector((didScroll))
        if let method1 = class_getInstanceMethod(UIScrollView.self, originSelector),
            let method2 = class_getInstanceMethod(UIScrollView.self, #selector(hj_scrollViewDidScroll)) {
            let didAddMethod = class_addMethod(UIScrollView.self, originSelector, method_getImplementation(method2), method_getTypeEncoding(method2))
            if didAddMethod {
                class_replaceMethod(UIScrollView.self, #selector(hj_scrollViewDidScroll), method_getImplementation(method1), method_getTypeEncoding(method1))
            } else {
                method_exchangeImplementations(method1, method2)
            }
        }
    }
    
    @objc dynamic func hj_scrollViewDidScroll() {
        self.hj_scrollViewDidScroll()
        if scrollHandle != nil {
            scrollHandle!(self)
        }
    }
    
    public typealias ScrollHandle = (UIScrollView) -> Void
    
    private struct HandleKey {
        static var key = "scrollHandle"
    }
    public var scrollHandle: ScrollHandle? {
        get { return objc_getAssociatedObject(self, &HandleKey.key) as? ScrollHandle }
        set { objc_setAssociatedObject(self, &HandleKey.key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC) }
    }
}

extension String {
    func base64Decoding() -> String {
        let decodeData = NSData.init(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        if decodeData == nil || decodeData?.length == 0 {
            return "";
        }
        let decodeString = NSString(data: decodeData! as Data, encoding: String.Encoding.utf8.rawValue)
        return decodeString! as String
    }
}
