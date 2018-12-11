[![锋客网](http://www.phonekr.com/wp-content/uploads/2012/11/Top-2013-W-1200px.png)](http://www.phonekr.com "锋客网")


Android Design in Action —— 十大常见 Android UX 错误
====================================================

2013 年九月 12 日由 **[NovaDNG](http://www.phonekr.com/author/novadng/ "由NovaDNG发布")** 发布 | 类别: [Android Design 研究会](http://www.phonekr.com/category/adia/ "查看Android Design 研究会中的全部文章") | Tags: [ADiA](http://www.phonekr.com/tag/adia-2/), [UX](http://www.phonekr.com/tag/ux/), [错误](http://www.phonekr.com/tag/%e9%94%99%e8%af%af/)

[![slides.001](http://www.phonekr.com/wp-content/uploads/2013/09/slides.001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.001.png)

> 作为一个长期使用 Android 的用户, 我在使用 Android 应用的时候经常遇到各种各样的交互上的问题, 并且早就想整理它们写一篇文章了. 但是,由于懒惰和拖延, 这篇文章一直处于草稿的状态. 正巧, 这期 ADiA 中, Android 开发团队为我们着重强调了当下 Android 应用中很常见的, 应该避免的错误.

Android 开发者关系团队每天都会试用无数的 App 或者受到无数的开发者发来的, 请求评测的 App. 在评测如此之多的应用之后, 他们总结出了一些最常见的错误, 并且在这期节目中为大家呈现出来.

在正式介绍这些错误之前, 我想稍微提一句. 这些错误是非常具有普遍意义的错误, 也就是说, 你用十个应用可能就会碰见这十个错误, 甚至你会在一个应用中碰见全部十个错误. 这种情况在天朝显得更加严峻. 所以, 希望这篇文章能让大家摆脱摸着石头过河的窘境, 直接的避免一些常见的错误.

[![slides.004](http://www.phonekr.com/wp-content/uploads/2013/09/slides.004-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.004.png)

十大用户体验”反模式”, Android 开发者联系团队为你用心呈现\~ 希望大家看 (乖) 得 (乖) 开 (中) 心 (枪)\~

### 第十: 你必须加载完这些东西… 否则!

[![slides.005](http://www.phonekr.com/wp-content/uploads/2013/09/slides.005-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.005.png)

这里的加载, 实际上指的是左图中的那种, 一个圈圈转啊转的对话框. 这种对话框的出现是应该要避免的, 另外, 比起这么一个对话框, 那些不响应 Back 操作的对话框简直是丧心病狂. 超大号哭脸. ヽ(´Д\`；)

解决方案其实也很简单, 采用嵌入式的载入指示即可. 当然, 如果你能做到实现在后台加载好数据那就更棒了.

### 第九: 你摸我不到!

[![slides.006](http://www.phonekr.com/wp-content/uploads/2013/09/slides.006-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.006.png)

首先请无视 Roman Nurik 和 Adam Koch 用来卖萌的 Na-na-na 吧… (Nick Butcher 做无奈状摇头)

首当其冲的问题是过小的触摸区域. [Android Design](https://developer.android.com/design/style/metrics-grids.html#48dp-rhythm "48dp Rythm | Metrics and Grids") 中专门强调过, 所有可触摸的对象都应该有至少 32dp 高, 理想的大小是 48dp, 除非你的目标用户是婴儿等手特小的人.

另一个很糟糕的错误是没有触摸反馈. 有些开发者不想使用标准的按钮控件, 但是标准按钮的好处就是它有提供触摸反馈的视觉效果. 对于用户而言, 摸到没有反馈的按钮会让他们认为你的应用 (比它本身的速度) 慢. 对于用户而言, 感知速度是他们能体会到的, 而真正的载入速度和运行速度反而没有感知速度那么容易被用户体会到. 另外, 亮起的触摸反馈还能指示出实际的触摸区域. 比如说一个列表, 当用户按下某一列表项的时候, 这一项所处的一整行都会亮起, 但是两边会留有 16dp 的空白, 这样便相当于告诉用户, 这个列表项最靠近屏幕边缘的 16dp 不是触摸区域.

### 第八: 设计 ≠ Photoshop

[![slides.007](http://www.phonekr.com/wp-content/uploads/2013/09/slides.007-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.007.png)

首先, 同学们不要学习右边小图上的那个变态… 我知道大家都对 PS 能实现的各种各样的效果很在行/感兴趣, 但是不当的/过度的使用这些效果只会让你的应用看起来显得很过时, 或者更糟糕——很业余.

当你设计你的应用的时候, 请务必将注意力优先放在内容而不是那些高光上. 用户装了你的应用并不是为了看闪闪发光的按钮, 所有的这些视觉设计到最后都应该是为了内容服务, 而不是为了装饰而装饰.

另外, 请务必保证应用内视觉风格的一致性. 没用用户会希望看到一个半 Holo 半草泥马的应用 (NovaDNG: wildebeest = 牛羚, 在这句里把它换成草泥马是一个意思的…). 点名批评一下 Feedly 这种外表光鲜亮丽, 设置却像是侏罗纪时代的应用.另外, 一个应用中不应该有太多的按钮/选框/对话框样式, 一个就够了——直接调用 Android 风格的控件是个简单有效的办法.

还有一些开发者, 对于细节的忽视实在是到了令人发指的地步, 比如说不一致的 度  量/错误的间距, 鬼畜的用色 (NovaDNG:我觉得我的[微信 Redesign](http://www.phonekr.com/adia-wechat-visual-redesign/ "Android Design in Action — 以微信为例") 就这样无端中枪了…), 丧病的字体选择… 这些都是会令用户感到不爽的细节, 作为开发者没有理由忽视他们.

### 第七: 侏罗纪来客

[![slides.008](http://www.phonekr.com/wp-content/uploads/2013/09/slides.008-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.008.png)

如果你的应用是 2009 年的时候做的, 那么你的用户可就要遭殃了… (Adam Koch: 他们竟然跑得起来…)

这里最先要提到的问题就是 Menu 键… 或者说, 菜单按钮的耻辱. 我们现在已经有了 Action Bar 来取代侏罗纪时代的菜单键了不是吗? 需要向下兼容也不是个借口, 因为如果你设置了[适当的参数](https://developer.android.com/design/patterns/compatibility.html#older-hardware "Adapting Android 4.0 to Older Hardware and Apps | Backwards Compatibility"), 那么 Overflow 按钮就不会在有实体菜单键的机器上出现. 当然, 你也可以让有实体菜单键的机器强行显示 Action Overflow 来增加它的可见性. 但是, 无论怎么样, 都不要让菜单键只能通过实体 Menu 键 (在只有虚拟键的机器上就会变成 [Nav Bar 右侧的三个小点](https://developer.android.com/design/media/compatibility_legacy_apps.png "示意图")) 呼出.

虽然说现在 Android 最新的 API 已经到了 [Lv 18](http://developer.android.com/about/versions/android-4.3.html "Android 4.3 APIs"), 但是你并不一定要设置 targetSdkVersion 到 18, 只要是 16 以上就行了. 如果你把 API 设置到 Lv 14 甚至更低, 你的应用就会强制在 Nav Bar 上显示三个小点, 这对于某些设备比如 [HTC One](http://i.imgur.com/U8u09K5.png "苦逼的 HTC One") 的用户而言实在是一件不能更痛苦的事情了…

还有一种情况就是继续沿用 Android 2.3 甚至更古早的视觉风格. 这种 App 有时候看起来还算挺 Holo 的, 但是当你按下按钮或者列表项的时候, Android 2.3 样式的橙色的视觉反馈出现了 (NovaDNG: MIUI 中枪), 或者卷动的时候看到了 2.3 样式的滚动条, 或者载入的时候看到 2.3 样式的圈圈… 这绝对不是用户想要的. 说道载入时的圈圈. Roman Nurik 稍微强调了一下, Holo 样式的载入环其实是两个圈以不同的速度反向同时旋转, 能够制造出比起单圈更为顺滑的动画.

### 第六: ~~纯血的~~杂种 Android

[![slides.009](http://www.phonekr.com/wp-content/uploads/2013/09/slides.009-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.009.png)

啊, 说道我最讨厌的地方了… 这里的原则性问题是, 不要违背”[纯血 Android](https://developer.android.com/design/patterns/pure-android.html "Pure Android")“的规约.

就和标题一样, 这一章的内容是在说, 不要从别的平台上搬运元素到 Android 上. 这个问题我在往期的文章里也提到过很多次, 这里就不展开说了.几个特别要注意也是常见的错误:

> 右箭头. 次级导航在 Android 上是没有水平方向的映射的. 换句话说, **次级导航**和**横向导航**是两码事.
>
> 底部标签栏.  对于 Android 而言, 顶部才是属于标签栏的位置.
>
> 从其他平台”借鉴”视觉样式. Android 用户想要的是 Android 应用 (NovaDNG: 嗯, 某些特殊的天朝用户除外).

### 第五: 导航就是我的品牌

[![slides.010](http://www.phonekr.com/wp-content/uploads/2013/09/slides.010-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.010.png)

不要试着重新发明轮子. 应用中导航在 Android 中已经有了成熟的定义. 把应用名称放在 Action Bar 中间, 或者用 iOS 样式的 Top Bar 都是很愚蠢的行为. 请直接用 [ActionBarCompat](http://android-developers.blogspot.com/ "Android Developers Blog"). 如果有需要在更早的版本上实现 Action Bar, 那么 [Action Bar Sherlock](http://actionbarsherlock.com/ "home") 也不失为一个好的选择.

另外, Drawer 是用来放主要的导航元素的, 像搜索和设置之类的东西放进 Overflow 就行了. 另外, 屏幕内容滑动露出 Drawer 这种方式也是不建议的 (NovaDNG: 其实我不太理解为什么不建议… 照理来说这种滑出方式也有其适用的地方, 不应该禁止的).  实际上我也有专门的介绍过新式的 Drawer, 详情请移步[早先的文章](http://www.phonekr.com/introduce-navigation-drawer/ "Android Design 趋势——Navigation Drawer").

[![slides.011](http://www.phonekr.com/wp-content/uploads/2013/09/slides.011-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.011.png)

既然这篇文章讲的是误区, 那么这里就尤其要强调一下不应该放进 Drawer 的东西. 首先最上面的主页探索购物和个人资料是完全没问题的. 中间的搜索应该放进 Action Bar, 因为这是一个很常见的”**动作**“, 而且不是一个”**导航元素**“ (NovaDNG: 在节目中 Roman Nurik 给出的理由居然是按照平台惯例… \_(:3」∠)\_). 设置, 帮助, 关于和反馈都是应该放进 Action Overflow 的东西. 另外, 广告什么的绝对不要有. 也没有必要在 Drawer 中推广自己的 App. 这些东西放进”关于”里倒是可以的. 至于”我姐妹的朋友有个网站我保证它很有意思请务必去看看”这种东西, 趁早删了为妙…

### 第四: 自制的非 Android 风格的分享

[![slides.012](http://www.phonekr.com/wp-content/uploads/2013/09/slides.012-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.012.png)

首先注意一下, 这里提供的三个截图都是正面的例子. (NovaDNG: 心地善良的 Adam Koch… 想看反例的, 自己打开微信看去)

实际上, 强大的应用间分享一直是 Android 的强项. Android 系统也提供了很方便的分享功能 (ACTION\_SEND). 开发者完全没必要也不应该人为的把分享的目标限定在某几个应用上. 另外, 自制的, 符合 Android Design 的分享功能也是不错的选择, 比如右图的 [Timely](http://www.phonekr.com/the-new-yardstick-for-best-android/ "最佳 Android 应用新准绳 —— Timely 闹钟"), 还有没出现在图片中的 Pocket. 它们针对分享的内容 (文章和应用) 默认列出了几个比较推荐的分享方式, 同时也允许用户点击 More 来选择其它的应用, 免得用户面对一长条的列表不知所措.

### 第三: 利用 WebView 来模仿原生应用

[![slides.013](http://www.phonekr.com/wp-content/uploads/2013/09/slides.013-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.013.png)

如果你上过 YouTube 的话应该不难看出, 左边的应用整个就是源自 YouTube 网页版的 ADiA 播放列表, 只不过加了个 Action Bar 罢了. 而右边则是一个很不错的例子, 一个[第三方的 ADiA 应用](https://play.google.com/store/apps/details?id=com.astuetz.android.adia "ADiA "). 它采用了响应式设计和原生界面, 集成了 Google+ 的评论和话题功能, 提供每期 ADiA 幻灯片的查看功能, 还有节目提醒, 是一个非常棒的应用.

利用 WebView 来模拟原生应用并不是个聪明的选择, 因为实际上他的性质是欺骗用户. 如果你试图用 WebView 来呈现 Android 的核心 UI 控件, 效果不会很好. 而且, 这么做也会造成运行效率的降低, 于用户而言就是不顺滑, 反应慢.

不要仅仅是为了”登陆 Android 平台”而把一个 web app 打包成 APK 发布. Web App 就让它以 web App 的形态存在吧. Android 欢迎 web Apps. 用户可以把 web Apps 以书签的形式固定在桌面, 完全没必要专门发布一个伪装成本地应用的 web App. 实际上, 用户使用浏览器的时间越来越多了, 浏览器的平均性能也在不断提升, 你并不会因为没有发布本地应用就流失用户. 所以完全不必要为此担心.

当然, 并不是说完全的禁止使用 WebView. 举个例子, GMail 就采用了 HTML 来渲染邮件内容并且效果很棒, 四次元之前也一直是采用 WebView 来进行图片浏览.

### 第二: 贫弱的首屏交互

[![slides.015](http://www.phonekr.com/wp-content/uploads/2013/09/slides.015-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.015.png)

无论对于什么样的应用, 首屏的重要性都是不言而喻的. 开门见山的要用户注册, 使用启动画面都是很糟糕的. 用户更希望应用能直接给它带来内容, 而登录和注册都最好留到万不得已的时候再做 (微博这样的东西除外). 另外, 先让用户明白你的应用到底是干嘛的, 然后再要求注册, 是比较合理的.

而正确的做法则是应该整合流行的社交网络登录选项 (NovaDNG: 国外是 Fb 鸟博和 G+, 国内的话… 微博是个不错的选择…), 并且检测用户是否已经安装了它们的客户端, 如果有, 就可以直接通过客户端验证登录, 能够大大减少输入用户名和密码的麻烦. 实际上, 你可以做尽可能多的事情帮助用户快速通过注册和登录, 而不是让他们感到烦躁. 在这方面, 整合 G+ 登录的应用的体验就是极好的, 我只需要按下登录按钮, 选择账户, 许可权限就行了, 比起国内各种应用的输入用户名/邮箱/密码要便捷太多.

另外, 你也可以采用展示动画/图片幻灯来告诉用户你的应用是干什么的. 这方面做得很好的是 [Next Browser](http://www.youtube.com/watch?v=QHDlgoZUpzI "YouTube").

### 第一: Android ≠ 竖屏手机

[![slides.016](http://www.phonekr.com/wp-content/uploads/2013/09/slides.016-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.016.png)

Android 设备千千万, 并不是只有竖屏的手机. 糟糕的平板支持或者横屏支持只会给你的品牌带来负面的影响.

有很多人确实是会横着用手机的, 比如说那些用车载底座/充电底座的用户. (NovaDNG: MIUI 如果我没记错的话, 自带应用都不支持横屏…) 横屏支持的方式有很多, 请挑选最合适的方案. 而且这里的重点其实是, **不要强迫用户只使用某个方向的设备**.

另外, Android 平板的占有率也在不断变多, 虽然手机和平板间的界限越来越模糊, 但这可不是不提供平板支持/优化的接口. Android 设备几乎囊括了从 3″ 到 10″ 间的所有尺寸, 所以合理的利用响应式设计吧, 它能提供更为合理的多屏支持. 仔细考虑留白, 布局和其他设计, 不要忽视那些平板用户. 只要一两个小时的 XML 工作就能让你做到很多东西.

 

[![slides.018](http://www.phonekr.com/wp-content/uploads/2013/09/slides.018-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/09/slides.018.png)

到这里, 十大常见错误就都说完了. 如果你觉得还有什么常见的错误, 请在评论或者[微博评论](http://www.weibo.com/1929609404/A94X9sbVW?mod=weibotime "@NovaDNG")或者 [G+ 评论](https://plus.google.com/u/0/107643109449706960187/posts/DpPm4cVtGug "+Geoffrey.R Hsu (NovaDNG)")中告诉我\~

> 最后, 一如既往的感谢 [+Roman Nurik](https://plus.google.com/u/0/113735310430199015092), [+Nick Butcher](https://plus.google.com/u/0/118292708268361843293) 和 [+Adam Koch](https://plus.google.com/u/0/+AdamKoch) 的 [Android Design in Action](http://www.youtube.com/watch?v=pEGWcMTxs3I&list=WL-obuenZ2I0mzvXqf5b61lfcuA3M8LnBv "Android Design in Action: Common UX Issues") 活动.

