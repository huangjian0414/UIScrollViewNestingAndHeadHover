//
//  testTbView.swift
//  Test
//
//  Created by huangjian on 2019/4/30.
//  Copyright © 2019 huangjian. All rights reserved.
//

import Foundation
import UIKit
class testTbView:  UITableView ,UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
}

class testView: UIView ,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    
    private var hjTbView : testTbView?
    private var headerHeight : CGFloat = 0.0
    
    var headerView : UIView? {
        didSet{
            headerHeight = headerView?.bounds.height ?? 0.0
            hjTbView?.tableHeaderView=headerView
        }
    }
    var viewControllers : [UIViewController] = {
        return [firstViewController(),secondViewController(),thirtyViewController()]
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpUI(){
        let table = testTbView.init(frame: bounds, style: .grouped)
        table.delegate=self
        table.dataSource=self
        table.register(testTbViewCell.self, forCellReuseIdentifier: "haha")
        table.tableHeaderView=UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.0001))
        table.showsVerticalScrollIndicator=false
        addSubview(table)
        hjTbView=table
        
    }
    private var canScroll : Bool = true
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !canScroll {
            scrollView.contentOffset = CGPoint(x: 0.0, y: headerHeight)
        }
        if scrollView.contentOffset.y > headerHeight && headerHeight != 0 {
            scrollView.contentOffset = CGPoint(x: 0.0, y: headerHeight)
        }
        if scrollView.contentOffset.y < headerHeight {
            for vc in viewControllers
            {
                if vc.test_scrollView != nil{
                    vc.test_scrollView?.contentOffset = CGPoint(x: 0, y: 0)//内容scroll重置到顶部
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "haha") as! testTbViewCell
        cell.selectionStyle = .none
        cell.viewControllers = viewControllers;
        cell.didScroll = {(sc) in
            guard sc != nil else {
                self.canScroll = true
                return
            }
            if sc!.contentOffset.y <= 0 {
                self.canScroll = true
                sc?.contentOffset = .zero
            }else
            {
                let rec = cell.titleView?.convert(cell.titleView!.bounds, to: self)
                if self.canScroll && rec!.origin.y > 0
                {
                    sc?.contentOffset = .zero
                    self.canScroll=true
                }else
                {
                    self.canScroll=false
                }
            }
        }
        cell.didScroll2 = {(isSuperEnable) in
            self.hjTbView?.isScrollEnabled = isSuperEnable
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return frame.height 
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
