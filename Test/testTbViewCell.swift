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
class testTbViewCell: UITableViewCell ,UITableViewDataSource,UITableViewDelegate{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if didScroll != nil {
            didScroll!(scrollView)
        }
    }
    var didScroll : Blockkk?
    var titleView : testPageTitleView?
    var viewControllers : [UIViewController] = [UIViewController]()
    
    
    private func setUpUI()
    {
        let scroll = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 808))
        scroll.contentSize=CGSize.init(width: UIScreen.main.bounds.width*2, height: 0)
        contentView.addSubview(scroll)
        
        let pageTitleView = testPageTitleView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30), titles: ["hehe","haha"])
        
        contentView.addSubview(pageTitleView)
        titleView = pageTitleView

        
        let table = UITableView.init(frame: CGRect.init(x: 0, y: 30, width: UIScreen.main.bounds.width, height: 808-30), style: .plain)
        table.delegate=self
        table.dataSource=self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "999")
        scroll.addSubview(table)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "999")
        cell?.textLabel?.text="第\(indexPath.row+1)行"
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
