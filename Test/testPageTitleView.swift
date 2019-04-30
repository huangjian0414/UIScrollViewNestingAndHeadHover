//
//  testPageTitleView.swift
//  Test
//
//  Created by huangjian on 2019/4/30.
//  Copyright © 2019 huangjian. All rights reserved.
//

import Foundation
import UIKit
class testPageTitleView:  UIView{
    
    private var btns : [UIButton] = [UIButton]()
    
    private lazy var slideScrollView : UIScrollView  = {
        let scroll = UIScrollView.init()
        scroll.bounces=false
        return scroll
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        slideScrollView.frame=bounds
        for btn in btns {
            btn.frame=CGRect.init(x: CGFloat(btn.tag)*(bounds.width/CGFloat(btns.count)), y: 0, width: bounds.width/CGFloat(btns.count), height: bounds.height)
        }
    }
    
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        addSubview(slideScrollView)
        for i in 0..<titles.count{
            let btn = UIButton.init(type: .custom)
            btn.setTitle(titles[i], for: .normal)
            btn.setTitleColor(UIColor.blue, for: .normal)
            btn.tag=i
            btns.append(btn)
            slideScrollView.addSubview(btn)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
