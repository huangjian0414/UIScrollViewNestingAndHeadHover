//
//  testTbViewCell.swift
//  Test
//
//  Created by huangjian on 2019/4/30.
//  Copyright © 2019 huangjian. All rights reserved.
//

import Foundation
import UIKit

typealias Blockkk = (_ scroll:UIScrollView)->()
class testTbViewCell: UITableViewCell ,UIScrollViewDelegate{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView != scroll else {
            return
        }
        if didScroll != nil {
            didScroll!(scrollView)
        }

    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard scrollView == scroll else {
            return
        }
        let index = scrollView.contentOffset.x/scrollView.bounds.size.width
        let vc = viewControllers[Int(index)]
        vc.view.frame=CGRect.init(x: scrollView.contentOffset.x, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
        scrollView.addSubview(vc.view)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == scroll else {
            return
        }
        scrollViewDidEndScrollingAnimation(scrollView)
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        scrollView.setContentOffset(CGPoint.init(x: CGFloat(index)*scrollView.bounds.width, y: 0), animated: true)

    }
    
    var didScroll : Blockkk?
    var titleView : testPageTitleView!
    var viewControllers : [UIViewController] = {
        return [firstViewController(),secondViewController(),thirtyViewController()]
    }()
    
    var scroll : UIScrollView!
    var titleHeight : CGFloat = 30.0
    
    private var titles : [String] = {
        return ["hehe","haha","enen"]
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scroll.frame=bounds
        scroll.contentSize=CGSize.init(width: bounds.width*CGFloat(titles.count), height: 0)
        titleView.frame=CGRect.init(x: 0, y: 0, width: bounds.width, height: titleHeight)
        
        scrollViewDidEndScrollingAnimation(scroll)
        for i in 0..<viewControllers.count {
            let v = viewControllers[i]
            if v.test_scrollView != nil
            {
                if !v.responds(to: #selector(scrollViewDidScroll(_:)))
                {
                    v.test_scrollView?.delegate=self //如果控制器设置了test_scrollView，将代理搞进来，不太好
                }
            }
        }
    }

    private func setUpUI()
    {
        scroll = UIScrollView.init()
        scroll.delegate=self
        scroll.bounces=false
        scroll.isPagingEnabled=true
        scroll.showsVerticalScrollIndicator=false
        contentView.addSubview(scroll)
        
        if #available(iOS 11.0, *) {
            scroll.contentInsetAdjustmentBehavior = .never
        }
        
        titleView = testPageTitleView.init(frame: CGRect.zero, titles: titles)
        titleView.backgroundColor=UIColor.orange
        contentView.addSubview(titleView)

    }
    
}
