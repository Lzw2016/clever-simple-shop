create database if not exists `clever-simple-shop` default character set = utf8mb4;
use `clever-simple-shop`;



/*


--------------------------------------- 用户相关
管理员
nideshop_admin
用户
nideshop_user
用户足迹
nideshop_footprint

--------------------------------------- 搜索相关
搜索提示关键字
nideshop_keywords

搜索历史(用于搜索统计)
nideshop_search_history

--------------------------------------- 商品相关
产品信息
nideshop_product

商品属性
nideshop_attribute

商品属性类别
nideshop_attribute_category

品牌信息
nideshop_brand

商品类别
nideshop_category

商品通道
nideshop_channel

商品收藏
nideshop_collect

商品信息
nideshop_goods
商品属性
nideshop_goods_attribute
商品展示图片
nideshop_goods_gallery
用户商品提问
nideshop_goods_issue
商品规格
nideshop_goods_specification

相关商品
nideshop_related_goods

规格
nideshop_specification


--------------------------------------- 购物车相关
购物车
nideshop_cart

--------------------------------------- 订单相关
订单信息
nideshop_order
订单商品信息
nideshop_order_goods

收货地址
nideshop_address

评论
nideshop_comment
评论图片
nideshop_comment_picture

订单物流
nideshop_order_express


--------------------------------------- 营销相关
广告
nideshop_ad
广告位置
nideshop_ad_position

用户级别
nideshop_user_level

优惠卷
nideshop_coupon

主题
nideshop_topic
主题类别
nideshop_topic_category
用户优惠卷
nideshop_user_coupon

--------------------------------------- 客服相关
用户提问反馈
nideshop_feedback


--------------------------------------- 其他
地区
nideshop_region
快递公司
nideshop_shipper








  IndexUrl: ApiRootUrl + 'index/index', //首页数据接口
  CatalogList: ApiRootUrl + 'catalog/index',  //分类目录全部分类数据接口
  CatalogCurrent: ApiRootUrl + 'catalog/current',  //分类目录当前分类数据接口

  AuthLoginByWeixin: ApiRootUrl + 'auth/loginByWeixin', //微信登录

  GoodsCount: ApiRootUrl + 'goods/count',  //统计商品总数
  GoodsList: ApiRootUrl + 'goods/list',  //获得商品列表
  GoodsCategory: ApiRootUrl + 'goods/category',  //获得分类数据
  GoodsDetail: ApiRootUrl + 'goods/detail',  //获得商品的详情
  GoodsNew: ApiRootUrl + 'goods/new',  //新品
  GoodsHot: ApiRootUrl + 'goods/hot',  //热门
  GoodsRelated: ApiRootUrl + 'goods/related',  //商品详情页的关联商品（大家都在看）

  BrandList: ApiRootUrl + 'brand/list',  //品牌列表
  BrandDetail: ApiRootUrl + 'brand/detail',  //品牌详情

  CartList: ApiRootUrl + 'cart/index', //获取购物车的数据
  CartAdd: ApiRootUrl + 'cart/add', // 添加商品到购物车
  CartUpdate: ApiRootUrl + 'cart/update', // 更新购物车的商品
  CartDelete: ApiRootUrl + 'cart/delete', // 删除购物车的商品
  CartChecked: ApiRootUrl + 'cart/checked', // 选择或取消选择商品
  CartGoodsCount: ApiRootUrl + 'cart/goodscount', // 获取购物车商品件数
  CartCheckout: ApiRootUrl + 'cart/checkout', // 下单前信息确认

  OrderSubmit: ApiRootUrl + 'order/submit', // 提交订单
  PayPrepayId: ApiRootUrl + 'pay/prepay', //获取微信统一下单prepay_id

  CollectList: ApiRootUrl + 'collect/list',  //收藏列表
  CollectAddOrDelete: ApiRootUrl + 'collect/addordelete',  //添加或取消收藏

  CommentList: ApiRootUrl + 'comment/list',  //评论列表
  CommentCount: ApiRootUrl + 'comment/count',  //评论总数
  CommentPost: ApiRootUrl + 'comment/post',   //发表评论

  TopicList: ApiRootUrl + 'topic/list',  //专题列表
  TopicDetail: ApiRootUrl + 'topic/detail',  //专题详情
  TopicRelated: ApiRootUrl + 'topic/related',  //相关专题

  SearchIndex: ApiRootUrl + 'search/index',  //搜索页面数据
  SearchResult: ApiRootUrl + 'search/result',  //搜索数据
  SearchHelper: ApiRootUrl + 'search/helper',  //搜索帮助
  SearchClearHistory: ApiRootUrl + 'search/clearhistory',  //搜索帮助

  AddressList: ApiRootUrl + 'address/list',  //收货地址列表
  AddressDetail: ApiRootUrl + 'address/detail',  //收货地址详情
  AddressSave: ApiRootUrl + 'address/save',  //保存收货地址
  AddressDelete: ApiRootUrl + 'address/delete',  //保存收货地址

  RegionList: ApiRootUrl + 'region/list',  //获取区域列表

  OrderList: ApiRootUrl + 'order/list',  //订单列表
  OrderDetail: ApiRootUrl + 'order/detail',  //订单详情
  OrderCancel: ApiRootUrl + 'order/cancel',  //取消订单
  OrderExpress: ApiRootUrl + 'order/express', //物流详情

  FootprintList: ApiRootUrl + 'footprint/list',  //足迹列表
  FootprintDelete: ApiRootUrl + 'footprint/delete',  //删除足迹
*/


























