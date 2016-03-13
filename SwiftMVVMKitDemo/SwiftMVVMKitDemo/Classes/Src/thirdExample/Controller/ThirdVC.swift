//
//  ThirdVC.swift
//  SwiftMVVMKitDemo
//
//  Created by Mac on 16/3/7.
//  Copyright © 2016年 momo. All rights reserved.
//

import UIKit

class ThirdVC: UIViewController {

    lazy var thirdViewManger = ThirdViewManger()
    lazy var viewModel = ThirdViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MVVM Example"
        thirdViewManger.smk_viewMangerWithSuperView(self.view)
        viewModel.smk_viewModelWithGetDataSuccessHandler(nil)
    }
    
    @IBAction func clickBtnAction(sender: UIButton) {
        self.thirdViewManger.smk_viewMangerWithModel { () -> [NSObject : AnyObject]? in
            return ["model": self.viewModel.getRandomData()!]
        }
    }

}
