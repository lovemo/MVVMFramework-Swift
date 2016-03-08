# MVVMFramework-Swift
###OC版本地址：https://github.com/lovemo/MVVMFramework
####本项目交流群：474292335
####欢迎有兴趣的有好的想法的参与到项目中来
===
再看了几篇博客后，总结整理下一个快速开发MVVM框架(抛砖引玉)，分离控制器代码，降低代码耦合

终于再也不用为ViewController中一坨坨tableView和collectionView的烦人代码忧虑了

代码加入了cell自适应高度代码，配合MJExtension，MJRefresh，AFNetworking等常用开发框架使用更佳，主要用于分离控制器中的代码，降低代码耦合程度，可以根据自己使用习惯调整代码。欢迎来喷，提issues。

##思维流程图示
![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/MVVMFrameWork-Thinking.png)
![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/MVVMFrameWork-Thinking2.jpeg)
##现在的工程代码结构
![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/directory_tree.png)

### <a id="模块构建"></a> 模块构建
  
* [功能模块中的类集合](#Examples)
	* [Controller - 负责ViewManger和ViewModel之间的绑定，另一方面也负责常规的UI逻辑处理。](#JSON_Model)
	* [View - 用来呈现用户界面](#JSONString_Model)
	* [ViewManger - 用来处理View的常规事件](#Model_contains_model_array)
	* [Model - 用来呈现数据](#Model_contains_model)
	* [ViewModel - 存放各种业务逻辑和网络请求](#Model_contains_model_array)


---

### <a id="结构分析"></a> 结构分析
* [MVVM中模块的集合](#MVVM)
	* [Handler 负责处理实现tableView和collectionView的delegate和dataSource中的一些协议方法](#Handler)
	* [Network 实现常用的网络请求代码](#Network)
	* [Base 一些基础模块](#Base)
	* [Extend 扩展系统功能模块](#Extend)
	* [Store 实现常用的数据存储方法](#Store)
	* [ViewModel 声明了一些基本的方法,负责处理一些系统业务逻辑](#ViewModel)
	* [Vender 一些依赖库](#Vender)

---

##部分protocol示例
```swift
@objc public protocol SMKViewMangerProtocolDelegate: NSObjectProtocol {

     /**
     设置Controller的子视图的管理者为self
     
     - parameter superView: 一般指subView所在控制器的view
     
     - returns: return value description
     */
    optional func smk_viewMangerWithSuperView(superView: UIView)
    
     /**
     设置subView的管理者为self
     
     - parameter subView: 管理的subView
     
     - returns: return value description
     */
    optional func smk_viewMangerWithSubView(subView: UIView?)
    
     /**
     设置添加subView的事件
     
     - parameter subView: 管理的subView
     - parameter info:    附带信息，用于区分调用
     
     - returns: return value description
     */
    optional func smk_viewMangerWithHandleOfSubView(subView: UIView, info: String?)
    
     /**
     返回viewManger所管理的视图
     
     - returns: viewManger所管理的视图
     */
    optional func smk_viewMangerOfSubView() -> UIView
    
     /**
     得到其它viewManger所管理的subView，用于自己内部
     
     - parameter viewInfos: 其它的subViews
     
     - returns: return value description
     */
    optional func smk_viewMangerWithOtherSubViews(viewInfos: [NSObject : AnyObject]?)
    
     /**
     需要重新布局subView时，更改subView的frame或者约束
     
     - parameter updateBlock: 更新布局完成的block
     */
    optional func smk_viewMangerWithLayoutSubViews(updateBlock: (( ) -> ( ))?)
    
    /**
     使子视图更新到最新的布局约束或者frame
     */
    optional func smk_viewMangerWithUpdateLayoutSubViews()
}
```

## <a id="代码示例"></a> 代码示例
### viewManger中代码实现

```swift
/class FourthViewManger2: NSObject, SMKViewMangerProtocolDelegate {

    lazy var fourthView2 = FourthView2.loadInstanceFromNib()
    lazy var fourthView = UIView()
    
    func smk_viewMangerWithSuperView(superView: UIView) {
        superView.addSubview(fourthView2)
    }

    // 根据自身需要得到外界的视图view
    func smk_viewMangerWithOtherSubViews(viewInfos: [NSObject : AnyObject]?) {
        
        let view1 = viewInfos!["view1"] as! UIView
        fourthView = view1
        
        fourthView2.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(CGSizeMake(250, 250));
            make.top.equalTo(view1.snp_bottom).offset(20);
            make.left.equalTo(view1);
        }

    }
    
    // 根据外界view或model的变化重新布局自己所管理的字视图的位置
    func smk_viewMangerWithUpdateLayoutSubViews() {
        let  offset = CGFloat(arc4random_uniform(70) + 10)
        let  wh = CGFloat(arc4random_uniform(200) + 50)
        let  size = CGSizeMake(wh, wh)
        
        fourthView2.snp_updateConstraints { (make) -> Void in
            make.top.equalTo(self.fourthView.snp_bottom).offset(offset);
            make.size.equalTo(size);
        }
        
        fourthView2.setNeedsLayout()
        UIView.animateWithDuration(0.5) { () -> Void in
            self.fourthView2.layoutIfNeeded()
        }
    }

}

```
       
### UIViewController中部分代码实现
         
```swift
class FirstVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    /**
     tableView的一些初始化工作
     */
    func setupTableView() {

        self.table.separatorStyle = .None
        table.tableHander = SMKBaseTableViewManger.init(viewModel: BQViewModel(), cellIdentifiers: [MyCellIdentifier], didSelectBlock: { (_, _) -> Void in
            let vc = UIViewController.viewControllerWithStoryboardName("Main", vcIdentifier: "SecondVCID")
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
}

```


### <a id="demo效果"></a> demo效果
- 只需实现加载请求以及配置自定义cell和上述代码，就能轻松实现以下效果，最重要的是代码解耦。

![image](https://github.com/lovemo/MVVMFramework/raw/master/resources/demo.gif)

### <a id="使用方法"></a> 使用方法
- 导入BQViewModel文件，然后在模块代码中新建ViewModel子类，继承BQBaseViewModel类型，实现加载数据等方法。
- 在ViewController中，初始化tableView或者collectionView，根据需要实现block代码，利用XTableDataDelegate或者XTCollectionDataDelegate的初始化方法将block代码和自己实现的ViewModel类型传递到内部，将会自动根据传入的内容去展现数据。
- 利用xib自定义cell，在 override func configure(cell: UITableViewCell, customObj obj: AnyObject, indexPath: NSIndexPath)方法中根据模型Model内容配置cell展示的数据。

## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的代码看看BUG修复没有）
* 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢

## 推荐-几篇不错的MVVM学习文章
* [#1 更轻量的 View Controllers](http://objccn.io/issue-1/)
* [MVVM 介绍](http://objccn.io/issue-13-1/)
* [写给iOS小白的MVVM教程(序)](http://www.ios122.com/2015/10/mvvm_start/)
* [多方位全面解析：如何正确地写好一个界面](http://ios.jobbole.com/83657/)
* [iOS应用架构谈 view层的组织和调用方案](http://www.cocoachina.com/ios/20150525/11919.html)
* [用Model-View-ViewModel构建iOS App](http://www.cocoachina.com/ios/20140716/9152.html)
* [浅谈iOS中MVVM的架构设计与团队协作](http://www.cocoachina.com/ios/20150122/10987.html)
* [一次简单的 ViewModel 实践](http://bifidy.net/index.php/407)
* [不要把ViewController变成处理tableView的"垃圾桶"](http://www.cocoachina.com/ios/20151218/14743.html)
* [实践干货！猿题库 iOS 客户端架构设计](http://www.cocoachina.com/ios/20160108/14911.html)
