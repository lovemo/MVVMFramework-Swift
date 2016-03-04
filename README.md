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
	* [Controller - 负责View和ViewModel之间的绑定，另一方面也负责常规的UI逻辑处理。](#JSON_Model)
	* [View - 用来呈现用户界面](#JSONString_Model)
	* [Model - 用来呈现数据](#Model_contains_model)
	* [ViewModel - 存放各种业务逻辑和网络请求](#Model_contains_model_array)


---

### <a id="结构分析"></a> 结构分析

* [Handler中BQViewModel抽象出的类集合](#Handler)
	* [BaseViewModel 声明了一些基本的方法,负责处理一些系统业务逻辑](#BaseViewModel)
	* [XTableDataDelegate 遵守并实现了部分tableView的delegate和dataSource中的一些协议方法](#XTableDataDelegate)
	* [XTCollectionDataDeleagte 遵守并实现了部分collectionView的delegate和dataSource中的一些协议方法](#XTCollectionDataDeleagte)

---

## <a id="代码分析"></a> 代码分析
### <a id="BaseViewModel"></a> BaseViewModel中代码实现

```swift
// ViewModel基类
class BQBaseViewModel: NSObject {
    weak var viewController: UIViewController?
    /**
     *  懒加载存放请求到的数据数组
     */
    lazy var dataArrayList:NSMutableArray = {
        return NSMutableArray()
    }()
    required override init() {

    }

    /**
     *  返回指定indexPath的item
     */
    func modelAtIndexPath(indexPath: NSIndexPath) -> AnyObject? {
        return nil
    }
    /**
     *  显示多少组 (当tableView为Group类型时设置可用)
     */
    func numberOfSections() -> Int {
        return 1
    }
    /**
     *  每组中显示多少行 (用于tableView)
     */
    func numberOfRowsInSection(section: Int) -> Int {
        return 0
    }
    /**
     *  每组中显示多少个 (用于collectionView)
     */
    func numberOfItemsInSection(section: Int) -> Int {
        return 0
    }
    /**
     *  分离加载首页控制器内容 (内部使用)
     */
    func getDataList(url: String!, params: [NSObject : AnyObject]!, success: (([AnyObject]!) -> Void)!, failure: ((NSError!) -> Void)!) {
        
    }
    /**
     *  用来判断是否加载成功,方便外部根据不同需求处理 (外部使用)
     */
    func getDataListSuccess(success: Void -> Void, failure: Void -> Void) {

    }
}
extension BQBaseViewModel {
    class func modelWithViewController(viewController: UIViewController) -> Self? {
        let model = self.init()
        model.viewController = viewController
        return model
    }
}

```
       
### <a id="XTableDataDelegate"></a> XTableDataDelegate中部分代码实现
         
```swift
/**
 *  选中UITableViewCell的Block
 */
typealias DidSelectTableCellBlock = (NSIndexPath, AnyObject) -> Void
```

### <a id="XTCollectionDataDeleagte"></a> XTCollectionDataDeleagte中部分代码实现

```swift
/**
 *  选中UICollectionViewCell的Block
 */
typealias DidSelectCollectionCellBlock = (NSIndexPath, AnyObject) -> Void
/**
 *  设置UICollectionViewCell大小的Block
 */
typealias CellItemSize = ( ) -> CGSize
/**
 *  获取UICollectionViewCell间隔Margin的Block
 */
typealias CellItemMargin = ( ) -> UIEdgeInsets

```

## <a id="现在的创建tableView代码"></a>现在的创建tableView代码
由于用到了UITableView+FDTemplateLayoutCell，现在创建的cell自动计算高度，满足日常开发需求。

```swift
 /**
    *  tableView的一些初始化工作
    */
    func setupTableView() {
        self.table.separatorStyle = .None;

        self.tableHander = XTableDataDelegate.init(viewModel: BQViewModel(), cellIdentifier: MyCellIdentifier, didSelectBlock: {   [weak self] (indexPath, item) -> Void in
            
            if let strongSelf = self {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewControllerWithIdentifier("ViewController2ID")
                strongSelf.presentViewController(vc, animated: true, completion: nil)
                print("click row : \((indexPath.row))")
            }
 
        })
        // 设置UITableView的delegate和dataSourse为collectionHander
        self.tableHander?.handleTableViewDatasourceAndDelegate(self.table)

    }

```

## <a id="现在的创建collectionView代码"></a>现在的创建collectionView代码

```swift
  /**
    *  collectionView的一些初始化工作
    */
    func setupCollectionView()
    {
    
        // 设置点击collectionView的每个item做的一些工作
        let selectedBlock: DidSelectCollectionCellBlock  = {(indexPath, item) -> Void in
            print("click row : \((indexPath.row))")
           self.dismissViewControllerAnimated(true, completion: nil)
        } ;
        // 配置collectionView的每个item的size
        let cellItemSizeBlock: CellItemSize  = {
            return CGSizeMake(110, 120)
        };
        // 配置collectionView的每个item的margin
        let cellItemMarginBlock: CellItemMargin  = {
            return UIEdgeInsetsMake(0, 20, 0, 20)
        };
        // 将上述block设置给collectionHander
        self.collectionHander = XTCollectionDataDelegate.init(viewModel: BQViewModel2(),
                                                                                    cellIdentifier: MyCellIdentifier2,
                                                                                    collectionViewLayout:UICollectionViewFlowLayout(), // 可用自定义UICollectionViewLayout
                                                                                    cellItemSizeBlock: cellItemSizeBlock,
                                                                                    cellItemMarginBlock: cellItemMarginBlock,
                                                                                    didSelectBlock: selectedBlock)
        // 设置UICollectionView的delegate和dataSourse为collectionHander
        self.collectionHander?.handleCollectionViewDatasourceAndDelegate(self.collectionView)
    
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
* [写给iOS小白的MVVM教程(序)](http://www.ios122.com/2015/10/mvvm_start/)
* [多方位全面解析：如何正确地写好一个界面](http://ios.jobbole.com/83657/)
* [iOS应用架构谈 view层的组织和调用方案](http://www.cocoachina.com/ios/20150525/11919.html)
* [用Model-View-ViewModel构建iOS App](http://www.cocoachina.com/ios/20140716/9152.html)
* [浅谈iOS中MVVM的架构设计与团队协作](http://www.cocoachina.com/ios/20150122/10987.html)
* [一次简单的 ViewModel 实践](http://bifidy.net/index.php/407)
* [不要把ViewController变成处理tableView的"垃圾桶"](http://www.cocoachina.com/ios/20151218/14743.html)
* [实践干货！猿题库 iOS 客户端架构设计](http://www.cocoachina.com/ios/20160108/14911.html)
