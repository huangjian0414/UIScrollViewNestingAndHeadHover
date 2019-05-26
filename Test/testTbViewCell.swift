//
//  testTbViewCell.swift
//  Test
//
//  Created by huangjian on 2019/4/30.
//  Copyright © 2019 huangjian. All rights reserved.
//

import Foundation
import UIKit

typealias Blockkk = (_ scroll:UIScrollView?)->()
typealias Blockkk2 = (_ isSuperEnable:Bool)->()

class testTbViewCell: UITableViewCell ,UIScrollViewDelegate{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard scrollView == scroll else {return}
        let index = scroll.contentOffset.x/scroll.bounds.size.width
        let vc = viewControllers[Int(index)]
        vc.view.frame=CGRect.init(x: scroll.contentOffset.x, y: 0, width: scroll.bounds.width, height: scroll.bounds.height)
        vc.view.tag = Int(index) + 1000
        if (scroll.viewWithTag(Int(index) + 1000) == nil) {
            scroll.addSubview(vc.view)
        }
        guard vc.test_scrollView != nil else {
            self.didScroll!(nil)
            return
        }
        vc.test_scrollView?.scrollHandle = {(sc) in
            guard sc != self.scroll else {return}
            if self.didScroll != nil {
                self.didScroll!(sc)
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == scroll else {
            return
        }
        scrollViewDidEndScrollingAnimation(scrollView)
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.width)
        scrollView.setContentOffset(CGPoint.init(x: CGFloat(index)*scrollView.bounds.width, y: 0), animated: true)

    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if self.didScroll2 != nil {
            self.didScroll2!(false)
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.didScroll2 != nil {
            self.didScroll2!(true)
        }
    }
    
    var didScroll : Blockkk?
    var didScroll2 : Blockkk2?
    var titleView : testPageTitleView!
    var viewControllers : [UIViewController] = {
        return [firstViewController(),secondViewController(),thirtyViewController()]
    }()
    
    var scroll : UIScrollView!
    var titleHeight : CGFloat = 30.0
    
    private var titles : [String] = {
        return ["hehe","haha","enen"]
    }()
    
    private var count = 0 ;
    override func layoutSubviews() {
        super.layoutSubviews()
        if count == 0 {
            scroll.frame=bounds
            scroll.contentSize=CGSize.init(width: bounds.width*CGFloat(titles.count), height: 0)
            titleView.frame=CGRect.init(x: 0, y: 0, width: bounds.width, height: titleHeight)
            count += 1
            scrollViewDidEndScrollingAnimation(scroll)
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
