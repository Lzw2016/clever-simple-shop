create database if not exists `clever-simple-shop` default character set = utf8mb4;
use `clever-simple-shop`;

/* ====================================================================================================================
    user -- 用户表
==================================================================================================================== */
create table user
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    username            varchar(63)     not null        unique                                  comment '登录名',
    mobile              varchar(31)                     unique                                  comment '用户手机号码',
    email               varchar(63)                     unique                                  comment '邮箱',
    nickname            varchar(63)     not null                                                comment '用户昵称',
    user_level          int(1)          not null        default 0                               comment '用户等级，0 普通用户，1 VIP用户，2 高级VIP用户',
    avatar              varchar(255)                                                            comment '用户头像图片',
    gender              char(1)                                                                 comment '性别，M：男；F：女',
    birthday            date                                                                    comment '生日',
    weixin_openid       varchar(63)                                                             comment '微信登录openid',
    last_login_time     datetime(3)                                                             comment '最近一次登录时间',
    last_login_ip       datetime(3)                                                             comment '最近一次登录IP地址',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '用户表';
create index user_username on user (username);
create index user_mobile on user (mobile);
create index user_email on user (email);
create index user_nickname on user (nickname);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    brand -- 品牌信息
==================================================================================================================== */
create table brand
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    name                varchar(127)    not null        unique                                  comment '品牌称',
    description         varchar(255)                                                            comment '品牌商简介',
    pic_url             varchar(255)    not null                                                comment '品牌商页的品牌商图片',
    sort_order          int             not null        default 1000                            comment '排序',
    floor_price         decimal(10,2)   not null                                                comment '品牌商的商品底价，仅用于页面展示',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '品牌信息';
create index brand_name on user (name);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    goods_category -- 商品分类
==================================================================================================================== */
create table goods_category
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    parent_id           bigint          not null                                                comment '父级编号,根节点的父级编号是：-1',
    full_path           varchar(255)    not null                                                comment '树结构的全路径用“-”隔开,包含自己的id,不包含-1',
    level               int             not null                                                comment '分类层级',
    name                varchar(63)     not null                                                comment '分类名称',
    keywords            varchar(1023)                                                           comment '分类关键字，以json数组格式',
    description         varchar(255)                                                            comment '分类广告语介绍',
    icon_url            varchar(255)                                                            comment '分类图标',
    pic_url             varchar(255)                                                            comment '分类图片',
    sort_order          int             not null        default 1000                            comment '排序',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '商品分类';
create index goods_category_parent_id on user (parent_id);
create index goods_category_full_path on user (full_path);
create index goods_category_name on user (name);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    goods -- 商品基本信息
==================================================================================================================== */
create table goods
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    category_id         bigint          not null                                                comment '所属商品分类ID',
    brand_name          varchar(63)     not null                                                comment '所属品牌名称',
    goods_code          varchar(63)     not null        unique                                  comment '商品编号(SPU)',
    name                varchar(127)    not null                                                comment '商品名称',
    keywords            varchar(1023)                                                           comment '商品关键字，以json数组格式',
    gallery             varchar(2047)   not null                                                comment '商品宣传图片列表，采用json数组格式',
    brief               varchar(255)    not null                                                comment '商品简介',
    sort_order          int             not null        default 1000                            comment '排序',
    pic_url             varchar(255)    not null                                                comment '商品页面商品图片',
    share_url           varchar(255)                                                            comment '商品分享朋友圈图片',
    is_new              int(1)          not null        default 1                               comment '是否新品首发，如果设置则可以在新品首发页面展示',
    is_hot              int(1)          not null        default 1                               comment '是否人气推荐，如果设置则可以在人气推荐页面展示',
    unit                varchar(31)                                                             comment '商品单位，例如件、盒',
    counter_price       decimal(10,2)                                                           comment '专柜价格',
    retail_price        decimal(10,2)                                                           comment '零售价格',
    detail              text                                                                    comment '商品详细介绍，是富文本格式',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '商品基本信息';
create index goods_category_id on user (category_id);
create index goods_brand_name on user (brand_name);
create index goods_goods_code on user (goods_code);
create index goods_name on user (name);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    goods_attribute -- 商品属性(商品属性不可选择，区别于商品规格)
==================================================================================================================== */
create table goods_attribute
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    attribute_name      varchar(63)     not null                                                comment '属性名称',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '商品属性(商品属性不可选择，区别于货品规格)';
create index goods_attribute_attribute_name on user (attribute_name);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    goods_attribute_option -- 商品属性选项值
==================================================================================================================== */
create table goods_attribute_option
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    attribute_id        bigint          not null                                                comment '商品属性ID',
    -- attribute_name      varchar(63)     not null                                                comment '属性名称(只能取product_attribute表)',
    option_value        varchar(63)     not null                                                comment '商品属性选项值',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '商品属性选项值';
create index goods_attribute_option_attribute_id on user (attribute_id);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    goods_specification -- 商品规格(可以选择，区别于商品属性)
==================================================================================================================== */
create table goods_specification
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    specification_name  varchar(63)     not null                                                comment '规格名称',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '商品规格(可以选择，区别于商品属性)';
create index goods_specification_specification_name on user (specification_name);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    goods_specification_option -- 商品规格选项值
==================================================================================================================== */
create table goods_specification_option
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    specification_id    bigint          not null                                                comment '商品规格ID',
    option_value        varchar(63)     not null                                                comment '商品规格选项值',
    -- specification_name  varchar(63)     not null                                                comment '规格名称',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '商品规格选项值';
create index goods_specification_option_specification_id on user (specification_id);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    goods_product -- 货品信息
==================================================================================================================== */
create table goods_product
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    goods_id            bigint          not null                                                comment '商品ID',
    product_code        varchar(63)     not null        unique                                  comment '货品编号(SKU)',
    sale_type           int(1)          not null        default 1                               comment '销售状态（1：草稿；2：上架；3：下架；4：采购中(可以购买)；5：缺货(无法购买)；6：禁销）',
    cost_price          decimal(10,2)   not null                                                comment '成本价',
    original_price      decimal(10,2)   not null                                                comment '原价',
    price               decimal(10,2)   not null                                                comment '销售价格',
    inventory           int             not null        default 0                               comment '货品库存',
    pic_url             varchar(255)    not null                                                comment '货品图片',
    specifications      varchar(2047)   not null                                                comment '货品规格值列表，采用json数组格式',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '货品信息';
create index goods_product_ on user ();
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    product_goods_attribute -- 货品-商品属性关联
==================================================================================================================== */
create table product_goods_attribute
(
    product_id          bigint          not null                                                comment '货品ID',
    attribute_id        bigint          not null                                                comment '商品属性ID',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (goods_id, attribute_id)
) comment = '货品-商品属性关联';
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    product_goods_specification -- 货品-商品规格关联
==================================================================================================================== */
create table product_goods_specification
(
    product_id          bigint          not null                                                comment '货品ID',
    specification_id    bigint          not null                                                comment '商品规格ID',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (product_id, specification_id)
) comment = '货品-商品规格关联';
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    category_goods_attribute -- 商品分类-商品属性关联(只用作辅助提示使用)
==================================================================================================================== */
create table category_goods_attribute
(
    category_id         bigint          not null                                                comment '商品分类ID',
    attribute_id        bigint          not null                                                comment '商品属性ID',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (category_id, attribute_id)
) comment = '商品分类-商品属性关联(只用作辅助提示使用)';
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
   category_goods_specification -- 商品分类-商品规格关联(只用作辅助提示使用)
==================================================================================================================== */
create table category_goods_specification
(
    category_id         bigint          not null                                                comment '商品分类ID',
    specification_id    bigint          not null                                                comment '商品规格ID',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (category_id, specification_id)
) comment = '商品分类-商品规格关联(只用作辅助提示使用)';
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    user_collect -- 用户收藏
==================================================================================================================== */
create table user_collect
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    username            varchar(63)     not null                                                comment '登录名',
    collect_type        int(1)          not null        default 0                               comment '收藏类型，0：商品ID；1：如果type=专题ID',
    collect_id          bigint          not null                                                comment '收藏数据ID',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '用户收藏';
create index user_collect_username on user (username);
create index user_collect_collect_id on user (collect_id);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    related_goods -- 相关商品
==================================================================================================================== */
create table related_goods
(
    goods_id            bigint          not null                                                comment '商品ID',
    related_goods_id    bigint          not null                                                comment '关联商品ID',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (goods_id, related_goods_id)
) comment = '相关商品';
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    shop_cart -- 用户购物车
==================================================================================================================== */
create table shop_cart
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    username            varchar(63)     not null                                                comment '登录名',
    goods_id            bigint          not null                                                comment '商品ID',
    goods_code          varchar(63)     not null                                                comment '商品编号(SPU)',
    goods_name          varchar(127)    not null                                                comment '商品名称',
    product_id          bigint          not null                                                comment '货品ID',
    product_code        varchar(63)     not null                                                comment '货品编号(SKU)',
    attributes          varchar(2047)   not null                                                comment '货品属性值列表，采用json数组格式',
    specifications      varchar(2047)   not null                                                comment '货品规格值列表，采用json数组格式',
    join_price          decimal(10,2)   not null                                                comment '加入购物车时的价格',
    quantity            int             not null                                                comment '购买数量',
    checked             int(1)          not null        default 1                               comment '是否选中，0：未选中；1：选中',
    icon_url            varchar(255)    not null                                                comment '图片',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '用户购物车';
create index shop_cart_username on user (username);
create index shop_cart_goods_id on user (goods_id);
create index shop_cart_goods_code on user (goods_code);
create index shop_cart_product_id on user (product_id);
create index shop_cart_product_code on user (product_code);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    user_order -- 用户订单
==================================================================================================================== */
create table user_order
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    username            varchar(63)     not null                                                comment '登录名',
    order_code          varchar(63)     not null                                                comment '订单编号',
    order_status        int(1)          not null        default 1                               comment '订单状态，0：无效；1有效',
    pay_status          int(1)          not null        default 0                               comment '支付状态，0：待付款；1：支付中；2：支付成功；3：超时；4：；5：；6：',
    consignee           varchar(63)     not null                                                comment '收货人名称',
    mobile              varchar(31)     not null                                                comment '收货人手机号',
    address             varchar(127)    not null                                                comment '收货具体地址',
    message             varchar(255)                                                            comment '用户订单留言',
    goods_price         decimal(10,2)   not null        default 0.00                            comment '商品总费用',
    freight_price       decimal(10,2)   not null        default 0.00                            comment '配送费用',
    coupon_price        decimal(10,2)   not null        default 0.00                            comment '优惠券减免',
    integral_price      decimal(10,2)   not null        default 0.00                            comment '用户积分减免',
    groupon_price       decimal(10,2)   not null        default 0.00                            comment '团购优惠价减免',
    order_price         decimal(10,2)   not null        default 0.00                            comment '订单费用(goods_price + freight_price - coupon_price)',
    actual_price        decimal(10,2)   not null        default 0.00                            comment '实付费用(order_price - integral_price)',
    pay_type            int(1)                                                                  comment '支付类型，1：微信支付；2：支付宝支付；3：...',
    pay_order_code      varchar(63)                                                             comment '支付订单编号',
    pay_time            datetime(3)                                                             comment '支付时间',
    ship_code           varchar(63)                                                             comment '快递订单号',
    ship_channel        varchar(63)                                                             comment '快递公司名称',
    ship_time           datetime(3)                                                             comment '快递发货时间',
    confirm_time        datetime(3)                                                             comment '用户确认收货时间',
    comments            int                                                                     comment '待评价订单货品数量',
    end_time            datetime(3)                                                             comment '订单结束时间',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '用户订单';
create index user_order_username on user (username);
create index user_order_order_code on user (order_code);
create index user_order_pay_order_code on user (pay_order_code);
create index user_order_ship_code on user (ship_code);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    order_goods -- 订单商品信息
==================================================================================================================== */
create table order_goods
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    order_code          varchar(63)     not null                                                comment '订单编号',
    goods_id            bigint          not null                                                comment '商品ID',
    goods_code          varchar(63)     not null                                                comment '商品编号(SPU)',
    goods_name          varchar(127)    not null                                                comment '商品名称',
    product_id          bigint          not null                                                comment '货品ID',
    product_code        varchar(63)     not null                                                comment '货品编号(SKU)',
    attributes          varchar(2047)   not null                                                comment '货品属性值列表，采用json数组格式',
    specifications      varchar(2047)   not null                                                comment '货品规格值列表，采用json数组格式',
    price               decimal(10,2)   not null        default 0.00                            comment '购买价格',
    quantity            int             not null                                                comment '购买数量',
    icon_url            varchar(255)    not null                                                comment '图片',
    can_comment         int(1)          not null        default 1                               comment '是否能够评论，0：不能评论；1：可以评论',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '订单商品信息';
create index order_goods_order_code on user (order_code);
create index order_goods_goods_id on user (goods_id);
create index order_goods_goods_code on user (goods_code);
create index order_goods_product_id on user (product_id);
create index order_goods_product_code on user (product_code);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    user_address -- 用户地址
==================================================================================================================== */
create table user_address
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    username            varchar(63)     not null                                                comment '登录名',
    consignee           varchar(63)     not null                                                comment '收货人名称',
    province            varchar(63)     not null                                                comment '省份',
    city                varchar(63)     not null                                                comment '城市',
    area                varchar(63)                                                             comment '区/县',
    address             varchar(63)     not null                                                comment '具体收货地址',
    mobile              varchar(31)     not null                                                comment '手机号码',
    is_default          int(1)          not null        default 1                               comment '是否默认地址，0：不是；1：是',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '用户地址';
create index user_address_username on user (username);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    user_comment -- 用户评论
==================================================================================================================== */
create table user_comment
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    parent_id           bigint          not null                                                comment '父级编号,根节点的父级编号是：-1',
    full_path           varchar(255)    not null                                                comment '树结构的全路径用“-”隔开,包含自己的id,不包含-1',
    username            varchar(63)     not null                                                comment '登录名',
    comment_type        int(1)          not null                                                comment '评论类型，0：商品评论；1：订单商品评论；2：专题评论',
    target_id           bigint          not null                                                comment '评论目标ID',
    content             varchar(1023)   not null                                                comment '评论内容',
    pic_urls            varchar(2047)                                                           comment '图片地址列表，采用json数组格式',
    goods_star          int(1)          not null                                                comment '商品评分， 1-5',
    service_star        int(1)          not null                                                comment '服务评分， 1-5',
    ship_star           int(1)          not null                                                comment '快递评分， 1-5',
    answer              varchar(1023)   not null                                                comment '商家回复内容',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '用户评论';
create index order_comment_parent_id on user (parent_id);
create index order_comment_full_path on user (full_path);
create index order_comment_username on user (username);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    goods_issue -- 商品问题
==================================================================================================================== */
create table goods_issue
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    username            varchar(63)     not null                                                comment '登录名',
    goods_id            bigint          not null                                                comment '商品ID',
    question_text       varchar(255)    not null                                                comment '问题内容',
    answer_text         varchar(255)    not null                                                comment '回答内容',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = 'goods_issue';
create index goods_issue_username on user (username);
create index goods_issue_goods_id on user (goods_id);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    user_feedback -- 用户反馈
==================================================================================================================== */
create table user_feedback
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    username            varchar(63)     not null                                                comment '登录名',
    nickname            varchar(63)     not null                                                comment '用户昵称',
    mobile              varchar(31)     not null                                                comment '手机号码',
    feed_type           int(1)          not null        default 1                               comment '反馈类型，0：投诉；1：建议',
    content             varchar(1023)   not null                                                comment '反馈内容',
    pic_urls            varchar(2047)                                                           comment '图片地址列表，采用json数组格式',
    status              int(1)          not null        default 1                               comment '反馈状态，1：未处理，2：处理完成',
    answer              varchar(1023)   not null                                                comment '回复内容',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '用户反馈';
create index user_feedback_username on user (username);
create index user_feedback_mobile on user (mobile);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    shipper -- 快递公司
==================================================================================================================== */
create table shipper
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    code                varchar(127)    not null                                                comment '快递公司编码',
    name                varchar(127)    not null                                                comment '快递公司名称',
    status              int(1)          not null        default 1                               comment '是否启用，0：禁用；1：启用',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '快递公司';
create index shipper_code on user (code);
create index shipper_name on user (name);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    ship_order -- 订单物流
==================================================================================================================== */
create table ship_order
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    ship_code           varchar(63)     not null                                                comment '快递订单号',
    shipper_code        varchar(127)    not null                                                comment '快递公司编码',
    shipper_name        varchar(127)    not null                                                comment '快递公司名称',
    ship_content        varchar(127)    not null                                                comment '快递信息内容',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '订单物流';
create index ship_order_ship_code on user (ship_code);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    user_footprint -- 用户足迹
==================================================================================================================== */
create table user_footprint
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    username            varchar(63)     not null                                                comment '登录名',
    goods_id            bigint          not null                                                comment '商品ID',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '用户足迹';
create index user_footprint_username on user (username);
create index user_footprint_goods_id on user (goods_id);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    sales_channel -- 销售通道
==================================================================================================================== */
create table sales_channel
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    name                varchar(63)     not null                                                comment '通道名称',
    url                 varchar(255)    not null                                                comment '销售页面地址',
    pic_urls            varchar(2047)                                                           comment '图片地址列表，采用json数组格式',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '销售通道';
create index sales_channel_name on user (name);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    activity_topic -- 活动主题
==================================================================================================================== */
create table activity_topic
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    title               varchar(255)    not null                                                comment '活动主题',
    subtitle            varchar(255)                                                            comment '子标题',
    content             text                                                                    comment '活动内容',
    pic_urls            varchar(2047)                                                           comment '图片地址列表，采用json数组格式',
    -- 待完善
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '活动主题';
create index activity_topic_title on user (title);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    goods_ad -- 商品广告
==================================================================================================================== */
create table goods_ad
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    title               varchar(127)    not null                                                comment '广告标题',
    link                varchar(255)    not null                                                comment '链接地址',
    pic_urls            varchar(2047)   not null                                                comment '广告宣传图片，采用json数组格式',
    position            int(1)          not null        default 1                               comment '广告位置：1：首页',
    content             varchar(2047)   not null                                                comment '活动内容',
    start_time          datetime(3)     not null                                                comment '广告开始时间',
    end_time            datetime(3)     not null                                                comment '广告结束时间',
    enabled             int(1)          not null        default 1                               comment '是否启用，0：禁用；1：启用',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '商品广告';
create index goods_ad_title on user (title);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    coupon -- 优惠卷
==================================================================================================================== */
create table coupon
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    name                varchar(63)     not null                                                comment '优惠卷名称',
    coupon_type         int(1)          not null                                                comment '优惠卷类型，0：满减；1：无门槛现金劵；2：打折',
    coupon_value        decimal(10,2)   not null                                                comment '优惠卷值',
    stack_user          int(1)          not null        default 0                               comment '能否叠加使用，0：不能；1：可以',
    pic_url             varchar(255)                                                            comment '优惠卷图片',
    content             varchar(2047)   not null                                                comment '活动内容',
    total_quantity      int             not null                                                comment '优惠卷总数量',
    single_quantity     int                                                                     comment '单个用户最多领取数量',
    send_start_date     datetime(3)                                                             comment '优惠卷领取开始时间',
    send_end_date       datetime(3)                                                             comment '优惠卷领取结束时间',
    max_stack_count     int                                                                     comment '使用限制-最大叠加使用数量',
    use_start_date      datetime(3)                                                             comment '使用限制-优惠卷使用开始时间',
    use_end_date        datetime(3)                                                             comment '使用限制-优惠卷使用结束时间',
    min_amount          decimal(10,2)                                                           comment '使用限制-最小优惠金额',
    max_amount          decimal(10,2)                                                           comment '使用限制-最大优惠金额',
    order_min_amount    decimal(10,2)                                                           comment '使用限制-订单最小金额',
    min_transmit_num    int                                                                     comment '使用限制-最少转发次数',
    goods_id            bigint                                                                  comment '使用限制-只能用于特定商品',
    category_id         bigint                                                                  comment '使用限制-只能用于特定商品分类',
    status              int(1)          not null        default 1                               comment '优惠卷状态，0：草稿；1：上线，2：禁止领取，3：禁止使用',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '优惠卷';
create index coupon_name on user (name);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    user_coupon -- 用户优惠卷
==================================================================================================================== */
create table user_coupon
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    username            varchar(63)     not null                                                comment '登录名',
    coupon_id           bigint          not null                                                comment '优惠卷ID',
    coupon_code         varchar(63)     not null        unique                                  comment '优惠卷编码',
    status              int(1)          not null        default 0                               comment '优惠卷使用状态，0：未使用；1：已使用，2：已过期',
    user_order_id       bigint                                                                  comment '使用的订单ID',
    discount_amount     decimal(10,2)                                                           comment '折扣金额',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = 'aaa';
create index user_coupon_username on user (username);
create index user_coupon_coupon_id on user (coupon_id);
create index user_coupon_coupon_code on user (coupon_code);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    search_keyword -- 热搜关键字
==================================================================================================================== */
create table search_keyword
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    keyword             varchar(127)    not null                                                comment '关键字',
    url                 varchar(255)    not null                                                comment '关键字的跳转链接',
    is_hot              int(1)          not null        default 0                               comment '是否是热门关键字，0：不是；1：是',
    is_default          int(1)          not null        default 0                               comment '是否是默认关键字，0：不是；1：是',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '热搜关键字';
create index search_keyword_keyword on user (keyword);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    user_search_history -- 用户搜索历史
==================================================================================================================== */
create table user_search_history
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    username            varchar(63)     not null                                                comment '登录名',
    keyword             varchar(127)    not null                                                comment '关键字',
    source_from         int(1)          not null        default 1                               comment '搜索来源，1：PC；2：H5；3：APP；4：微信小程序',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '用户搜索历史';
create index user_search_history_username on user (username);
create index user_search_history_keyword on user (keyword);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    region -- 行政区域
==================================================================================================================== */
create table region
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    parent_id           bigint          not null                                                comment '父级编号,根节点的父级编号是：-1',
    full_path           varchar(255)    not null                                                comment '树结构的全路径用“-”隔开,包含自己的id,不包含-1',
    region_type         int(1)          not null        default 1                               comment '行政区域类型，1：省；2：市；3：县/区',
    region_name         varchar(63)     not null                                                comment '行政区域名称',
    region_code         varchar(31)     not null                                                comment '行政区域编码',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '行政区域';
create index region_parent_id on user (parent_id);
create index region_full_path on user (full_path);
create index region_region_name on user (region_name);
create index region_region_code on user (region_code);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    dict -- 数据字典
==================================================================================================================== */
create table dict
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    dict_type           varchar(63)     not null        unique                                  comment '字典分类',
    description         varchar(1023)   not null                                                comment '描述',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '数据字典';
create index dict_dict_type on user (dict_type);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    dict_item -- 数据字典数据项
==================================================================================================================== */
create table dict_item
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    dict_type           varchar(63)     not null                                                comment '字典分类',
    dict_label          varchar(127)    not null                                                comment '字典键(显示值)',
    dict_value          varchar(255)    not null                                                comment '字典数据值(隐藏值)',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '数据字典数据项';
create index dict_item_dict_type on user (dict_type);
create index dict_item_dict_label on user (dict_label);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/* ====================================================================================================================
    dict_item -- 数据字典数据项
==================================================================================================================== */
create table dict_item
(
    id                  bigint          not null        auto_increment                          comment '主键id',
    dict_type           varchar(63)     not null                                                comment '字典分类',
    dict_label          varchar(127)    not null                                                comment '字典键(显示值)',
    dict_value          varchar(255)    not null                                                comment '字典数据值(隐藏值)',
    is_show             int(1)          not null        default 1                               comment '是否显示（1：显示；2：隐藏）',
    sort_order          int             not null        default 1000                            comment '排序',
    create_at           datetime(3)     not null        default current_timestamp(3)            comment '创建时间',
    update_at           datetime(3)                     on update current_timestamp(3)          comment '更新时间',
    primary key (id)
) comment = '数据字典数据项';
create index dict_item_dict_type on user (dict_type);
create index dict_item_dict_label on user (dict_label);
/*------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------*/


/*
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








































