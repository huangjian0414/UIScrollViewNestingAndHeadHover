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
    
    private var titles : [String] = [String]()
    
    private lazy var slideScrollView : UIScrollView  = {
        let scroll = UIScrollView.init()
        scroll.frame=bounds
        scroll.bounces=false
        return scroll
    }()
    
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        self.titles = titles
        addSubview(slideScrollView)
        for i in 0..<titles.count{
            let btn = UIButton.init(type: .custom)
            btn.setTitle("8979", for: .normal)
            btn.setTitleColor(UIColor.blue, for: .normal)
            btn.frame=CGRect.init(x: CGFloat(i)*(bounds.width/2), y: 0, width: bounds.width/2, height: bounds.height)
            slideScrollView.addSubview(btn)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
