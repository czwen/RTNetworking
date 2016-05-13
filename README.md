# FlexibleAIFNetworking
[FlexibleAIFNetworking](https://github.com/czwen/RTNetworking) 是一个基于[AIFNetworking](https://github.com/casatwy/RTNetworking) ~~胡乱~~改造而成的网络框架。


`AIFNetworking` 和 `FlexibleAIFNetworking`比较

|| AIFNetworking | FlexibleAIFNetworking
---|---|---|---
灵活性|☹️|🙂
依赖|AFNetworking 2|AFNetworking 3

github https://github.com/czwen/RTNetworking
> 欢迎发PR，共同维护

## Quick Start
1. 添加 `pod 'FlexibleAIFNetworking'` 到你的Podfile，然后`pod install`

2. 创建一个AIFService类型的对象。

	==命名很重要==，例如`AIFServiceMyShop`，`AIFServiceTaobao`之类的。规则就是以`AIFService`为前缀，后面随意。
	
	必须 Conforms `<AIFServiceProtocal>` protocal。如果还涉及参数签名的还可以添加`<AIFSignatureProtocol>`

	一般来说，一个`AIFService`代表一个API 服务。所以无需创建多个。

3. 创建RTAPIBaseManager对象。名字随意。例如`XSProductDetailAPIManager`。

	Conforms `<RTAPIManager>`。
	
	提供`<RTAPIManagerValidator>` 用于验证参数与返回数据的正确性。

4. 在使用的地方（ViewController）创建一个`XSProductDetailAPIManager`对象。
	
	```
	_productDetailApiManager.paramSource = self;
	_productDetailApiManager.delegate = self;
	...
	[_productDetailApiManager loadData];
	```
	这样就完成一次请求了。

## Delegate & Protocal
```
RTAPIManagerParamSourceDelegate // 多用在ViewController上，用于处理请求参数
RTAPIManagerApiCallBackDelegate // 多用在ViewController上，用于处理响应

RTAPIManager					// 多用在RTAPIManager上，基础
RTAPIManagerValidator		// 多用在RTAPIManager上，用于检验数据，让使用者知道这个接口需要什么参数


AIFServiceProtocal			// 多用在AIFService上，基础
AIFSignatureProtocol		// 多用在AIFService上，用于签名
```
   
## Show Me The Code
`class AIFServiceMyShop`

```
//
//  AIFServiceMyShop.h
//

@interface AIFServiceMyShop : AIFService <AIFServiceProtocal>

@end


//
//  AIFServiceMyShop.m
//

@implementation AIFServiceMyShop

#pragma mark - AIFServiceProtocal

- (BOOL)isOnline
{
    return YES;
}

- (NSString *)onlineApiBaseUrl
{
    return @"baseUrl";
}

- (NSString *)onlineApiVersion
{
    return @"api/v1";
}

- (NSString *)onlinePrivateKey
{
    return @"PrivateKey";
}

- (NSString *)onlinePublicKey
{
    return @"PublicKey";
}

- (NSString *)offlineApiBaseUrl
{
    return self.onlineApiBaseUrl;
}

- (NSString *)offlineApiVersion
{
    return self.onlineApiVersion;
}

- (NSString *)offlinePrivateKey
{
    return self.onlinePrivateKey;
}

- (NSString *)offlinePublicKey
{
    return self.onlinePublicKey;
}

- (BOOL)onlineIsSingtureAllParamters
{
    return YES;
}

- (BOOL)offlineIsSingtureAllParamters
{
    return YES;
}

- (NSDictionary *)serviceHeadersDictionary
{
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    [headerDic setValue:@"application/json" forKey:@"Accept"];
    [headerDic setValue:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
    NSDictionary *loginResult = [[NSUserDefaults standardUserDefaults] objectForKey:@"______"];
    if (loginResult[@"token"]) {
        [headerDic setValue:loginResult[@"token"] forKey:@"token"];
    }
    return headerDic;
}

- (NSDictionary *)serviceCommonParamsDictionary
{
    return @{
    			// 例如手机版本之类的信息
             };
}

@end
```

`class XSProductDetailAPIManager`

```
//
//  XSProductDetailAPIManager.h
//

@interface XSProductDetailAPIManager : RTAPIBaseManager<RTAPIManager,RTAPIManagerValidator>

@end


//
//  XSProductDetailAPIManager.m
//

@interface XSProductDetailAPIManager()
@property (nonatomic, strong) NSString *gid;
@end

@implementation XSProductDetailAPIManager

- (instancetype)init{
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

- (NSString *)serviceType
{
	// 上面说到定义Service名字的重要性在于
	// 每个APIManager 都要有一个所归属的Service
    return @"MyShop";
}

- (NSString *)methodName
{
    return [NSString stringWithFormat:@"goods/%@",self.gid];
}

- (RTAPIManagerRequestType)requestType
{
    return RTAPIManagerRequestTypeGet; // 支持GET POST PUT DEL
}

- (BOOL)manager:(RTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
	// 用于校验参数的正确性
    return YES;
}

- (BOOL)manager:(RTAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data{
 	// 用于校验响应数据的正确性

    return YES;
}

- (NSDictionary *)reformParams:(NSDictionary *)params{
	// 处理ParamsSorce的参数。
	// 请求前都会先到这里。
	// 由于这个接口是采用 url+id 方式。
	// 本身AIFNetworking 也没有这么情况。所以我就采取一些小技巧来实现了。
	
	// reform 之后的参数 依然会调用
	// - (BOOL)manager:(RTAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;
	
    self.gid = params[kProductDetailID];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
    [dic removeObjectForKey:kProductDetailID];
    return dic;
}

#pragma mark
#pragma mark - public method

// 能获取到APIManager 对象的地方就能调用 loadData 方法。
//	参数永远从 <RTAPIManagerParamSourceDelegate> 里获取。
//	所以每个请求的地方都不用关心参数的问题。
// 返回值是一个request ID。可以通过request ID取消某一个请求。
// 注意 APIManager 不是只有一个请求，同一 APIManager 可以产生很多请求。

- (NSInteger)loadData;

```

`class ViewController`

```
//
//  ViewController.m
//

@interface ViewController()
<
    RTAPIManagerParamSourceDelegate,
    RTAPIManagerApiCallBackDelegate,
>
>
@property (nonatomic, strong) XSProductDetailAPIManager *productDetailApiManager;
@end

@implementation XSProductDetailViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.productDetailApiManager loadData]; // 发起请求
}

- (XSProductDetailAPIManager *)productDetailApiManager
{
    if (!_productDetailApiManager) {
        _productDetailApiManager = [[XSProductDetailAPIManager alloc] init];
        _productDetailApiManager.paramSource = self;
        _productDetailApiManager.delegate = self;
    }
    return _productDetailApiManager;
}

#pragma mark
#pragma mark - RTAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(RTAPIBaseManager *)manager{
    return @{
             @"good_id":self.goodsId
             };
}

#pragma mark
#pragma mark - RTAPIManagerParamSourceDelegate

- (void)managerCallAPIDidSuccess:(RTAPIBaseManager *)manager{
	// success callback    
    [manager fetchDataWithReformer:self.bottomView];
    
}

- (void)managerCallAPIDidFailed:(RTAPIBaseManager *)manager{
 	// failed callback    

}

@end
```

####至此，你已经能用`FlexibleAIFNetworking` 发起请求了。 

## More Feature
####  实现API 接口的分页功能
通过使用下面3个方法在APIManager实现分页。

`- (void)beforePerformSuccessWithResponse:(AIFURLResponse *)response` 

`- (void)beforePerformFailWithResponse:(AIFURLResponse *)response`

`- (NSDictionary *)reformParams:(NSDictionary *)params` 


```
- (void)beforePerformSuccessWithResponse:(AIFURLResponse *)response
{
    self.totalPage = [response.content[@"data"][@"pagination"][@"total"] integerValue];
    self.nextPage = self.requestPage+1;
    if (self.nextPage >= self.totalPage) {
        self.isLoadedLastPage = YES;
    }
}

- (void)beforePerformFailWithResponse:(AIFURLResponse *)response
{
    // 如果没有使用一个变量 requestPage 来记录请求的页数，直接在self.nextPage 上增加
   	 // 失败时需要恢复 self.nextPage--
}


- (NSDictionary *)reformParams:(NSDictionary *)params
{
    NSMutableDictionary *p = [NSMutableDictionary dictionaryWithDictionary:params];
    [p addEntriesFromDictionary:@{
                                  @"page":@(self.requestPage).stringValue
                                  }];
    return p;
}

// 自己定义的方法
- (NSInteger)loadFirstPage
{
    if (self.isLoading) {
        [self cancelAllRequests];
    }
    
    self.isLoadedLastPage = NO;
    self.requestPage = 1;
    
    return [self loadData];
}

- (NSInteger)loadNextPage
{
    if (self.isLoading || self.isLoadedLastPage) {
        return NSNotFound;
    }
    self.requestPage = self.nextPage;
    
    return [self loadData];

}

```
## What's More

`<RTAPIManagerCallbackDataReformer>` 将数据交给使用者处理，由使用者自己选择需要什么样的数据。或者不适用于大部分项目。另外还涉及到`去Model化`。

如果以上内容未能满足你，可以到原作者 https://github.com/casatwy/RTNetworking 页面clone下来，上面有keynote，介绍这个框架的设计……之类的干货。
