[![锋客网](http://www.phonekr.com/wp-content/uploads/2012/11/Top-2013-W-1200px.png)](http://www.phonekr.com "锋客网")


Android Design in Action —— 编与集
==================================

2013 年十月 25 日由 **[NovaDNG](http://www.phonekr.com/author/novadng/ "由NovaDNG发布")** 发布 | 类别: [Android Design 研究会](http://www.phonekr.com/category/adia/ "查看Android Design 研究会中的全部文章") | Tags: [ADiA](http://www.phonekr.com/tag/adia-2/), [列表](http://www.phonekr.com/tag/%e5%88%97%e8%a1%a8/), [布局](http://www.phonekr.com/tag/%e5%b8%83%e5%b1%80/), [框格](http://www.phonekr.com/tag/%e6%a1%86%e6%a0%bc/), [视图](http://www.phonekr.com/tag/%e8%a7%86%e5%9b%be/)

[![slides.001](http://www.phonekr.com/wp-content/uploads/2013/10/slides.001-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.001.png)

> 大家好, 这是久违了的 Android Design in Action 栏目. 本期 Android Design in Action 介绍的是如何更好的, 合理的展现一个集合 (Collection).

 

[![slides.003](http://www.phonekr.com/wp-content/uploads/2013/10/slides.003-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.003.png)

首先, 我们明确一下概念: [什么是集合](https://www.google.com/search?hl=en&newwindow=1&esrch=Agad%3A%3APublic&output=search&sclient=psy-ab&q=define+collection&btnG=&oq=&gs_l=&pbx=1 "define collection")? 集合就是一组物体. 对于 Android 应用而言, 基本上集合就意味着一个列表的项目, 比如最常见的书单和购物清单, 等等.

 

[![slides.004](http://www.phonekr.com/wp-content/uploads/2013/10/slides.004-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.004.png)

说道集合, 我想大家都应该对上面的三种表现方法不陌生吧, 他们分别代表了最常见的基本布局 —— 列表, 网格与 viewpager. 这期 Android Design 我们将着重研究前两种.

 

[![slides.005](http://www.phonekr.com/wp-content/uploads/2013/10/slides.005-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.005.png)

我们将从两个方面入手进行讨论 —— 集合的使用与集合的变更. 其中, 集合的使用又包含了提纯内容与响应式布局, 变更包括了添加/消除, 重排序与物件操作.

### 集合的使用

#### 提纯内容

[![slides.007](http://www.phonekr.com/wp-content/uploads/2013/10/slides.007-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.007.png)

对于一个集合而言, 这些操作是非常重要的: 快速卷动, 首标, 改变视图与排序:

在左边的联系人应用中, 每个字母都被归纳为一个分段, 每个分段都有一个置顶首标. 带有首字母索引的快速卷动与置顶首标可以帮助用户更快的进行模糊的范围查看. 而在卷动时, 首标保持在列表的顶端, 同时 Indexed Scroll 也会提示当前的首字母;

中间的图库应用中, 为了让用户方便的以不同方式查看缩略图, 图库在 Action Bar 上提供了一个切换视图的下拉菜单. 另外, 你可以注意到, 在当前文件夹的名字下方, 用小一号的字体标识了当前的视图模式, 这也是一种不错的提示方式;

右边的第三方应用中, 它采用了一个 Action Bar 图标附加下拉菜单提供了变更排序方式的功能. 对于 Android 而言, 这些都是很基本而常见的提纯内容的方式与行为.

 

[![slides.008](http://www.phonekr.com/wp-content/uploads/2013/10/slides.008-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.008.png)

接下来要讲到的操作, 就是真正的”提纯”操作了. 这些提纯操作直接影响到项目, 会使屏幕中显示的项目减少, 精炼. 他们更像是过滤器.

最常见的项目提纯操作就是标准的搜索功能了. 他能直接显示出与用户输入相符的项目. 比如在联系人中, 搜索能直接显示出你搜索的联系人. 当你有很大的项目总量时, 搜索能提供非常不错的效果;

第二种项目提纯操作是集合过滤器. 作为例子的 Pocket 提供了这样的过滤功能, 它能让列表中只剩下某种类型的项目, 比如文章, 视频或者图片. 值得注意的是, 过滤器作为一个”操作”被放置在 Action Bar 中, 但是它同时又提供了下拉菜单, 所以具有一个 Spinner 的标识符 (右下箭头) (就像图库等应用的分享操作一样);

最后一种, 也是我最喜欢的一种, 是过滤器 Drawer. 当你采用了左侧 Drawer 来提供应用内导航的时候, 有没有思考一下, 右侧是不是也能放一个 Drawer, 这个 Drawer 又能干些什么呢? 对于一个集合而言, 右侧 Drawer 作为过滤器的好处是显而易见的. 这个过滤器能够让用户在设置过滤阈值的时候实时预览到结果, 对于用户体验而言是很大的改进. 另外, Drawer 也可以通过从右侧边缘划入的手势展开, 非常便利. 有一个需要注意的地方是, 如果你要在 Drawer 中使用示意图中那样的滑块选择器, 请一定要小心不要让左右拉动滑块的操作和对 Drawer 的操作产生冲突 —— 如果你用过 Feedly (版本 17) 的那个脑残 Drawer, 你就会明白为什么我要特地强调这一点了.

关于右侧 Drawer 还有一点需要注意的是, 在 Android Design 中, 导航用的 Drawer 是放在左边的. 不要把导航 Drawer 放在右侧. 右侧 Drawer 的定制性更强, 可以变成你需要的任何东西.

### 响应式布局

当我们谈论集合的时候, 我们很难想象一个集合会以某一种固定的形式出现在你的面前. 各式各样的集合会以不同的大小不同的形状显示在不同的设别上. 就以列表做例子, 列表在小屏幕上是个不错的选择, 但是当你在一台大屏幕设备上横屏查看一个被放大的列表, 那么体验就必然是很差劲的了 —— 空间被浪费了, 信息显示也太多了.

于是, 怎么解决这个问题呢?

[![slides.010](http://www.phonekr.com/wp-content/uploads/2013/10/slides.010-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.010.png)

最简单的办法就是, 把列表变成一个框格. 对于开发而言, 列表和框格都不是很有难度的东西. 只要为不同的屏幕提供不同的布局, 就可以很轻松的解决很多问题. 尤其好用的场景是, 当你的列表是由图片和标题文字组成的时候.

 

[![slides.011](http://www.phonekr.com/wp-content/uploads/2013/10/slides.011-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.011.png)

第二个方法就是把框格中的内容交错排布. 我们称之为错落集合. 这就比单纯的从列表变为框格要来得更高级了. 这么做会让你的集合变得更漂亮. 同时, 你也可以给不同的项目以不同的权重, 让用户注意到这些项目中更值得注意的东西.

 

[![slides.012](http://www.phonekr.com/wp-content/uploads/2013/10/slides.012-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.012.png)

如果你巧妙的将列表, 框格和错落集合搭配使用, 你就既能得到更多的展示空间, 又能拥有极佳的排版效果. 这方面的例子就是 [Pocket](https://play.google.com/store/apps/details?id=com.ideashower.readitlater.pro "Pocket - Android Apps on Google Play"). Pocket 在不同的屏幕上采用了不同的布局方式: 在小屏幕上采用常规的带图列表, 7″ 平板上使用框格布局, 更大的平板上则采用错落集合. 通过这种方式, 他们避免了很多应用在平板上有过大的留白的问题 (以前的 ADiA 上反而是建议留白… [Pattrn](http://www.phonekr.com/pattrn/ "另类的壁纸应用 — Pattrn") 就是采用了留白的例子).

 

[![slides.013](http://www.phonekr.com/wp-content/uploads/2013/10/slides.013-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.013.png)

当你考虑”在不同的设备上显示内容”这么个问题的时候, 不妨跳出以往的框架, 考虑响应式布局. 最简单的办法, 就是在大屏幕上采用”列表|详细”布局. 这样, 你就可以依然采用小屏幕上采用的列表布局, 同时能够在大屏幕上取得不错的显示效果.

 

[![slides.014](http://www.phonekr.com/wp-content/uploads/2013/10/slides.014-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.014.png)

当你需要不同大小的图片的时候, 中心裁切会帮你大忙. 在牺牲掉一部分图片的前提下保持原图片的比例, 中心裁切可以帮助你很容易的制作框格视图和错落布局中使用的图片. 关于图片的详情, 我们会在以后的文章中介绍.

 

[![slides.015](http://www.phonekr.com/wp-content/uploads/2013/10/slides.015-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.015.png)

提到排版布局, 不得不提到最近非常流行的一种设计风格, Google 将其称之为”由内而外式设计”. 所谓的由内而外的设计, 就是把内容放在最优先, 把你想要展示的内容放在最显眼的位置, 而不是从一个空白画布和网格开始, 生硬的往里面填东西. 而这种设计风格的最直观的体现, 就是卡片 —— 内容块.

[![slides.016](http://www.phonekr.com/wp-content/uploads/2013/10/slides.016-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.016.png)

[![slides.017](http://www.phonekr.com/wp-content/uploads/2013/10/slides.017-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.017.png)

[![slides.018](http://www.phonekr.com/wp-content/uploads/2013/10/slides.018-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.018.png)

当我们开始考虑展示内容的时候, 我们会注意到内容有不同的形式. 相应的, 我们也应该选择不同的展示方式. 就卡片而言, 我们可以采用大卡片, 中卡片或者小卡片, 竖排的卡片或者横排的卡片. 这些卡片都代表着不同的内容. 当你确定了你将要采用哪些卡片 (展示方式) 之后, 你就可以开始把这些卡片放到屏幕上了 —— 在 Photoshop 中新建画布, 开始工作.

[![slides.019](http://www.phonekr.com/wp-content/uploads/2013/10/slides.019-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.019.png)

[![slides.020](http://www.phonekr.com/wp-content/uploads/2013/10/slides.020-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.020.png)

多放几个这样的卡片, 你就做出了一个最基本的集簇.

[![slides.021](http://www.phonekr.com/wp-content/uploads/2013/10/slides.021-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.021.png)

[![slides.022](http://www.phonekr.com/wp-content/uploads/2013/10/slides.022-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.022.png)

在你做出了一个基本集簇之后, 你就可以在这个基本集簇上进行扩展了. 刚才做的不同大小的卡片这时候便派上了用场, 利用不同大小或者横竖的卡片来替换原本全部是大号的卡片, 能够起到区分优先级与合理利用空间的作用.

[![slides.023](http://www.phonekr.com/wp-content/uploads/2013/10/slides.023-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.023.png)

当这些集簇在设备上显示的时候, 你就需要意识到, 不是每个设备都能完整的显示一个集簇. 而集簇的排布方式同时也应该顺应页面的卷动方式 —— 假设这里采用的是纵向卷动, 那么也许使用更多横向的卡片会更加合适.

[![slides.024](http://www.phonekr.com/wp-content/uploads/2013/10/slides.024-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.024.png)

在更大的设备上, 集簇能够被完整的显示, 这时候更重要的就是如何排布他们才能制造更佳的视觉效果了.

综上, 所谓的从内而外式设计, 就是从最小的控件开始, 以展示信息为优先, 一步步向外扩展, 最后构建出一个合理的框架, 而不是先搭建框架, 然后再一步步向里面填入内容.

[![slides.025](http://www.phonekr.com/wp-content/uploads/2013/10/slides.025-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.025.png)

举个例子, 这是 Play Store 中的电影卡片. 对于一部电影, 最重要的展示信息就是海报, 标题, 价格与简介. 于是我们制作了三种不同尺寸的卡片, 每一种都能充分的展示前述的四种信息.

[![slides.026](http://www.phonekr.com/wp-content/uploads/2013/10/slides.026-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.026.png)

之后需要做的, 就是在不同的设备上显示合适尺寸的卡片了. 当然, 也许你会希望一次性显示很多个项目, 那么只要合理的将卡片整理组合成集簇即可.

 

### 合集的变更

有的时候, 用户可以向集合中添加项目, 也可以删除它们; 这些项目或许可以被移动, 被操作. 那么如何使这些集合上的变更行为变得更为友好呢?

#### 增删项目

对于一个可以被用户变更集合而言, 添加和移除项目是最为基础的操作.

[![slides.028](http://www.phonekr.com/wp-content/uploads/2013/10/slides.028-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.028.png)

往集合中添加项目的方法有很多, 一般情况下, 最常见的方式就是在 Action Bar 上提供一个”新建/添加”功能键. 比如说, 在上图左的联系人应用中, 这样的按钮让用户创建一个新的联系人/联系人组;

不过这么简单粗暴的添加新项目方式显然不是我们所推荐的. 很多时候, 我们都被一种想法束缚: 添加作为一个动作/操作, 应该位于 Action Bar 中. 不过, 我认为不妨换个思路来看看. 比起用一个专门的按钮来提供新增功能, 不如试试行内式/嵌入式的新建方式. 比如, 图中的 Play Music 在电台列表的顶端提供了新建电台的按钮, 而 Keep 则做的更好, 它在列表的末尾提供了一个颜色略浅一些的”新建项目”来告诉用户”这并不是一个项目, 而是类似幽灵的存在”, 而当用户点击这个项目的时候, 就相当于激活了这个项目, 让它从幽灵变成实体. 可以看出, 行内式/嵌入式的添加功能可以更好的与已有项目融为一体;

还有一种不错的添加方式是空白状态. 当用户第一次安装/开启应用时, 他们面对的很有可能是一个空白的页面. 那么, 比起冷冰冰的告诉用户”这里没有内容”, 为什么不利用空白状态, 提示用户自己创建内容以作为新建项目的指示呢? 在图中的 Keep 中, 内容区域的那个 Create a reminder 就是一个巨大的按钮, 用户触摸这个区域, 就会进入新建提醒的界面. 这个方式对于大部分用户自建内容的列表都适用.

[![slides.029](http://www.phonekr.com/wp-content/uploads/2013/10/slides.029-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.029.png)

当你没法在 Android Design 给出的标准图标中找到你需要的图标时, 那么就得考虑自己制作新图标了. 制作 Action Bar 图标有一种普遍的规则, 就像制造一个新的单词一样. 我们把图标本身视为词根 —— 比如添加群组中的群组 (三个小人) —— 把操作视为后缀 —— 比如添加群组中的添加 (加号) —— 这么一来, 一个图标就做完了\~

[![ic\_action\_new\_account](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_account.png)](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_account.png) [![ic\_action\_new\_label](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_label.png)](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_label.png) [![ic\_action\_new\_attachment](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_attachment.png)](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_attachment.png) [![ic\_action\_new\_email](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_email.png)](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_email.png) [![ic\_action\_new\_event](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_event.png)](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_event.png) [![ic\_action\_new\_picture](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_picture.png)](http://www.phonekr.com/wp-content/uploads/2013/10/ic_action_new_picture.png)

就像这样, 很简单吧? 这些图标, 基本上都能让人一看便明白他们的含义 (除了倒数第二个… 我可不觉得倒数第二个能够一眼看懂… ).

[![slides.030](http://www.phonekr.com/wp-content/uploads/2013/10/slides.030-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.030.png)

用户既然能够添加项目, 那么自然也要能移除他们.

首先要提到的是位于项目上的项目 Action Overflow. 这三个小点里可以放下各种针对单个项目的操作. 有一点需要注意的是, 这三个小点虽然看起来非常小, 但是他们的触发区域依然要有 48dp x 48dp 大, 甚至可以做得更大, 让整个项目的右下角都成为可触发区域. 当用户点击这三个点之后, 一个 Overflow 菜单就会出现. 在 Play Music 中, 当你点击三个小点的时候, 就会出现删除操作的选项;

另外一种比较传统的方式就是采用 Contextual Action Bar. 举个例子, 在图库应用中, 当你长按选中某张图片的时候,  Contextual Action Bar 便会出现, 提供了全选, 分享和删除等操作. 不过, 还记得我在[上一篇文章](http://www.phonekr.com/android-design-cons/ "Android Design 的缺陷")里是怎么说 Contextual Action Bar 的吗? 可见性不足. Contextual Action Bar 需要通过长按来唤出, 很多时候存在着可见性不足的问题. 所以在你打算采用这种方法之前, 最好再考虑考虑;

第三种移除项目的方式, 就是随着 Android 4.0 一起亮相 (实际上 webOS 啥上早就有了…) 的滑动删除/滑动忽略. 这种方案在纵向/横向列表上的效果最佳. 当用户开始向左/右或上/下 (取决于列表卷动方向) 滑动某个项目时, 项目会变成半透明并且渐隐. 而且, 这个手势还可以和滑入/下滑动画结合使用 —— 当用户滑动消除某一项目之后, 原本在项目前后/左右的项目滑动填补到它原本的位置上, 以消除生硬感, 同时传递出这个项目已经从列表中移除的信息.

在这里我必须再强调一遍, 虽然我们很喜欢滑动消除这个手势, 但是这个手势的可见性太低了. 请务必提供可以通过单击完成的移除操作以提高可见性. 正面例子可以参考 Gmail (单击头像选取信息, 出现 Contextual Action Bar). 另外, 为了让用户意识到滑动删除的存在, 你可以在列表上使用”滑入”的动画.

#### 重排项目

除了增删项目, 用户也许还会希望自己重新排列表单的顺序. 这对于用户的个性化需求而言是十分重要的. 举个最简单的例子, 用户非常需要对一系列的”任务”进行重新排序.

[![slides.032](http://www.phonekr.com/wp-content/uploads/2013/10/slides.032-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.032.png)

最简单直接的方式就是提供一个拖动把手. Android 上标准的拖动把手是三道短横线 (实际上 Roman Nurik 也说这三道短横线就是缩小版的 Drawer 提示… 所以我们也叫它 Slider 滑块),

[![slides.033](http://www.phonekr.com/wp-content/uploads/2013/10/slides.033-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.033.png)

当然, 你也可以使用自己的样式, 比如两列小方块之类的, 让人觉得摩擦力很大的图示. 右边的 [DashClock](http://www.phonekr.com/dashclock-standalone/ "万能锁屏——DashClock(及其他)")中采用的图示就是一种被称为”轮辙”的指示, 算是一种前段时间广为流传的指示方式;

在左边两个图示里, Google Keep 和 Play Music 都采用了标准的把手. 当用户按下这个把手的时候, 当前的项目便会略微浮起和/或高亮, 给用户以”这个项目被提起来了”的反馈. 很重要的一点是, 当你的应用中, 列表页左侧是 Drawer 触发区时, 如何才能确定触发 Drawer 和移动项目的操作不冲突? 这个时候, 你应该先想想, 在这个地方, 究竟是重排项目更为重要, 还是导航 Drawer 更为重要? 如果是重排项目更重要, 那么你大可以把拖动把手放在项目的右侧, 或者告诉用户”按住图片可以拖动项目”, 或者采用之后介绍的长按拖动方式. 另外, 这个把手虽然看起来很小, 但是它的实际操作区域必须大于 48dp —— 甚至我建议开发者们应该把操作区域扩展到整个列表项那么高, 只留 8dp 上下间距;

在 Google Keep 中, 我们还是用了另外一种方式来移动项目, 那就是长按拖动. 实际上, 在 Android 系统原本的逻辑中, 重排就是通过长按后拖动来进行的, 比如主屏图标的重排. 当你在 Keep 中拖动一个项目的时候, 你会看到项目变成半透明状跟随你的手指移动, 而在框格中则有一个和项目一样大的方框提示了当你松开手指之后项目会落下的区域. 同时, 其他项目也会随着当前项目位置的变化而改变位置. 但是这种排序方式的坏处依然是可见性不足. 这点很难通过直观的方式提示, 除了在用户第一次使用的时候进行文字提示.

另外, 很重要的一点是, 请务对用户的拖放操作进行恰当的**反馈**. 就像前面提到的, 让项目”飞离”原先的高度, 高亮项目, 或者让项目变成虚影, 都是很好的提示方式. 还记得 Android Design 的精髓么? [拟真](http://www.phonekr.com/android-design-is-not-just-holo/ "Holo Theme 大行其道, Android Design 无人知晓?"). 在现实中, 我们重排东西的时候, 都会把一个东西拿起, 移动到需要的位置之后, 放下. 请把同样的操作反馈在应用中显示出来.

#### 项目操作

我想我在上一篇文章中似乎已经吐槽过 Android 这[混乱的上下文菜单](http://www.phonekr.com/android-design-cons/ "Android Design 的缺陷 4")了. 通常情况下, 点击项目本身会带你进入项目详情的界面, 或者执行一级操作. 那么如果这个项目还附有次级操作呢?

[![slides.035](http://www.phonekr.com/wp-content/uploads/2013/10/slides.0351-810x455.png)](http://www.phonekr.com/wp-content/uploads/2013/10/slides.0351.png)

首先依然是项目 Action Overflow. 这个菜单里能放的东西很多, 不单单是删除, 在 Play Store 里你还可以直接安装一个应用;

其次依然是 Contextual Action Bar. 和 上下文 Action Overflow 一样, 在 Contextual Action Bar 中可以放各种各样的操作. 甚至很多需要进入详情界面才能执行的操作都可以放在 Contextual Action Bar 上. 当然, Contextual Action Bar 还有一个好处就是他能够同时操作多个项目. 换句话说, 如果你想让用户同时操作多个项目, 那就只能选择 Contextual Action Bar 了. 批量操作的效率是绝对高过另外两种方式的;

还有一种很普遍的方式是在项目的右侧放一个 Borderless Button 以提供**一个最重要的**次级操作. 这种方式的好处就是它是行内/嵌入式的, 关联性最高, 可见性也很强. 不足之处就是只能放一个操作, 而且不能批量操作. 需要注意的是, 如果你需要采用这种形式的按钮, 请务必添加分隔线让用户明白, 这个项目上有两个不同的操作区域. 另外, 这个按钮整列都是可触摸的区域. 另外需要注意的就是触摸反馈. 理论上来说, 触摸项目的话, 应该让整行都发光, 而触摸右侧按钮时应该只让按钮区域发光. 这里有个很好的例子, 就是在联系人应用中的电话号码项目. 每个号码的右侧都有一个短信图标, 这就是电话号码的次级操作了.

 

> 看到这里, 关于集合的内容就都讲完了. 再次大力感谢 Android Developers Relation Team 的 [+Roman Nurik](https://plus.google.com/u/0/113735310430199015092), 和 [+Nick Butcher](https://plus.google.com/u/0/118292708268361843293)的 [Android Design in Action](http://www.youtube.com/watch?v=r6jMnYwjftk "Android Design in Action: Collection") 活动. 另外, 这期的题图依然是又结画的, 再次感谢\~ 不久之后的下期节目再见\~
