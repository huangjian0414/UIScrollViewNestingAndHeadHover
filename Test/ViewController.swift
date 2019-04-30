//
//  ViewController.swift
//  Test
//
//  Created by huangjian on 2019/4/29.
//  Copyright © 2019 huangjian. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navi = UIView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.width, height: 88))
        navi.backgroundColor=UIColor.blue
        view.addSubview(navi)
        setUpUI()
    }
    private func setUpUI(){
        let table = testView.init(frame: CGRect.init(x: 0, y: 88, width: view.bounds.width, height: UIScreen.main.bounds.height-88))
        view.addSubview(table)
    }

}

