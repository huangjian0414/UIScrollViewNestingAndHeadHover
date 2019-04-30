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

class testView: UIView ,UITableViewDelegate,UITableViewDataSource{
    
    private var hjTbView : testTbView?
    
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
        addSubview(table)
        hjTbView=table
        
    }
    private var canScroll : Bool = true
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !canScroll {
            scrollView.contentOffset = CGPoint(x: 0.0, y: 400)
        }
        if scrollView.contentOffset.y > 400 {
            scrollView.contentOffset = CGPoint(x: 0.0, y: 400)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "haha") as! testTbViewCell
        cell.selectionStyle = .none
        cell.didScroll = {(sc) in
            if sc.contentOffset.y <= 0 {
                self.canScroll = true
                sc.contentOffset = .zero
            }else
            {
                let rec = cell.titleView?.convert(cell.titleView!.bounds, to: self)
                if self.canScroll && rec!.origin.y > 0
                {
                    sc.contentOffset = .zero
                    self.canScroll=true
                }else
                {
                    self.canScroll=false
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return frame.height - 34
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView.init()
        header.backgroundColor=UIColor.purple
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
