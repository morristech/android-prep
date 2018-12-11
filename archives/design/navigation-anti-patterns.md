[![锋客网](http://www.phonekr.com/wp-content/uploads/2012/11/Top-2013-W-1200px.png)](http://www.phonekr.com "锋客网")

Android Design in Action —— 十大导航错误
========================================

2014 年二月 25 日由 **[NovaDNG](http://www.phonekr.com/author/novadng/ "由NovaDNG发布")** 发布 | 类别: [Android Design 研究会](http://www.phonekr.com/category/adia/ "查看Android Design 研究会中的全部文章") | Tags: [ADiA](http://www.phonekr.com/tag/adia-2/), [UX](http://www.phonekr.com/tag/ux/), [导航](http://www.phonekr.com/tag/%e5%af%bc%e8%88%aa/), [错误](http://www.phonekr.com/tag/%e9%94%99%e8%af%af/)

[![slides.001](http://www.phonekr.com/wp-content/uploads/2014/02/slides.001-820x461.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.001.png)

大家好, 这里是 2014 年第一期正式的 ADiA 教程. 在上一次的[设计错误文章](http://www.phonekr.com/10-common-ux-issues/ "Android Design in Action —— 十大常见 Android UX 错误")里, 我们已经简略的提过了一下导航设计上的错误, 这一次, 我们就这个话题展开, 指出一些大家在设计应用导航时经常被犯下的错误以便警示大家.

 [![slides.002](http://www.phonekr.com/wp-content/uploads/2014/02/slides.002-820x461.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.002.png)

十大导航设计”反模式”, Android 开发者联系团队为你用心呈现\~ 希望大家看 (乖) 得 (乖) 开 (中) 心 (枪)\~

 

### 1. 将导航项放在 Action Overflow 里

[![slides.003](http://www.phonekr.com/wp-content/uploads/2014/02/slides.003-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.003.png)

我应该已经不止一次在各种 App 上看到有人把导航项放在 Action Overflow 中了. 经常被放进 Action Overflow 的导航有”主页 (脑子一定是被保险柜夹了)”, “商店 (有时其实可以理解)”, “我的信息 (微信, twitter 中枪)”, 甚至一些分类. 但是 Action Overflow 真的不是导航项该去的地方, 别忘了这地方是 **Action** Overflow, 是用来放操作的. 还有另一个很重要的原因是, 在很多有着 Menu 按钮的手机上, 应用中是不会显示 Action Overflow 的, 他们得被 Menu 键唤出, 可见性太低了, 而且关于 Menu 键还有一大堆问题 (这里就不展开了).

还有一点很重要的就是, 在现在的 Android 上, 界面 UI 已经逐渐形成了一个规律 —— 导航靠左, 操作靠右. 如果你硬是要把导航放进 Action Overflow, 无形中也会违背这个规律.

 

### 2. 错误的导航层级

[![slides.004](http://www.phonekr.com/wp-content/uploads/2014/02/slides.004-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.004.png)

这个错误也是颇为常见的. 在 Android 中我们有很多常见的导航方式, 比如 Tabs, Spinners 和 Drawer. 这些导航方式当然是可以搭配着使用的, 但是当你搭配使用这些导航方式的时候, 请注意他们之间的层级关系. 当你规划你的导航层级的时候, 一般情况下是要构造一个树状结构, 在一个层级下有其他的子层级, 以此类推. 在 Android 中, 不同层级一般对应着不同的导航方式. 而错误的用法是, 比如上图中那样的, 用 Tab 作为最高导航层, Spinners 作为次层, 而 Drawer 作为最次层. 在 Android 上, 这三个导航方式对应的层级是遵循着比较严格的规定的.

[![slides.005](http://www.phonekr.com/wp-content/uploads/2014/02/slides.005-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.005.png)

上图呢才是一般情况下的正确做法. 通常情况下, Drawer (如果有的话) 代表着最高的导航层级, 然后则是 Spinners, 再次是 Tabs. 如果你有超过三级的导航层级, 我们强烈建议你把最顶端的几个都放在 Drawer 中 (只有 Drawer 能容纳超过一个导航层级, 因为 Drawer 中的项目能够以合理的方式展开), 然后把剩下两个层级分配各 Spinners 和 Tabs. 当然, 实际上作为一个移动应用, 简化层级也是非常重要的, 我们强烈的不推荐你在应用中采用非常深的导航层级, 这只会让用户感到困惑.

还有一点需要注意的是, 虽然在上面的示意图中 Spinner 和 Drawer 共存而且看起来 Spinner 在 Action Bar 上 (Drawer 实际上在 Action Bar 之下), 但是在实际应用中, 当用户划出 Drawer 的时候, 你应该让 Drawer 渐变成另一副模样 —— 只留下在应用中全局通用的操作, 比如搜索, 隐去其他的东西, 比如 Spinners, 换成 App 的名字. 这样的话就不会产生导航层级上的困惑了.

另外, 关于 Drawer, 我们还有另一期专门介绍它的 ADiA: [Android Design 趋势——Navigation Drawer](http://www.phonekr.com/introduce-navigation-drawer/ "Android Design 趋势——Navigation Drawer").

 

### 3. 不能滑动切换的 Tabs.

[![slides.006](http://www.phonekr.com/wp-content/uploads/2014/02/slides.006-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.006.png)

在 Android 中, Tab 几乎是绑定了横向滑动的操作. 用户对 Tabs 的期望就是他们可以被滑动. 如果你在页面上采用了 paginate (ViewPager) 内容, 那么内容上的滑动操作就会和 Tabs 的全局滑动产生混淆. 当然, 如果页面中只有一小部分是可以滑动的内容 —— 比如一个非全屏的图片浏览, 那么这么做是完全没问题的, 只要不与 Tabs 本身的滑动手势冲突即可.

[![slides.007](http://www.phonekr.com/wp-content/uploads/2014/02/slides.007-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.007.png)

正确的做法很简单, 只要把横向的 ViewPager 改为纵向就行了. 当然, 如果你有其他的解决方案也很好, 只要规避与导航的手势冲突就可以了.  

 

### 4.  深层/顽固的 Tabs

[![slides.008](http://www.phonekr.com/wp-content/uploads/2014/02/slides.008-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.008.png)

什么叫做”深层”的 Tabs? 要解释深层, 一般来讲我们用”浅层”来做对比. 在 Android 上, Tabs 应该是浅的. 你用 Tabs 来作为视图更变, 或者分类切换之用, 而不应该在 Tabs 之内再有层级和历史. 通常情况下, Tabs 只应该在导航界面出现. 在上图的例子中, 用户点击一个项目, 理应打开一个全新的页面, 而不是刷新 Tabs 下的内容. 这种持续出现的 Tab 就是我们所说的深层 Tabs, 或者说在 Tabs 之内有历史.

之所以不这么做的原因是, 当你离开了这个 Tab, 比如说滑动到了另一个 Tab 上的时候, 你就把这个 Tab 置于了一种尴尬的境地 —— 现在这个 Tab (对于用户而言不可见) 应该显示什么呢? 当用户从另一个 Tab 回到这个 Tab (无论是点击还是滑动) 时, 他应该保持原来的样子 (显示内容) 呢, 还是显示列表? 在这种情况下, 用户会很容易的感到困惑. 为了避免这种尴尬, 我们建议 Tabs 最好做得浅一些.

另外, 若你的 Tabs 坚持不变的话, 很大程度会影响到 Back 的作用. 当用户切换到不同的 Tab 并且在这个 Tab 中做了一些操作之后, Back 的作用就会变得不甚明确. 如果你非得在同一个视图内显示新内容, 那么我们建议你采用 Drawer, Drawer 才是为全局内容切换而生的.

[![slides.009](http://www.phonekr.com/wp-content/uploads/2014/02/slides.009-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.009.png)

上图显示的才是正确的做法, 打开一个新的, 没有 Tabs, 有 Up 的界面, 而不是继续显示 Tabs.

 

### 5. 溯回 (反向遍历) Tabs

[![slides.010](http://www.phonekr.com/wp-content/uploads/2014/02/slides.010-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.010.png)

前面说的 Tabs 不应该深层, 同样也提到了 Tabs 不应该包含历史. 什么叫做不因该包含历史呢? 就是指, 你在 Tabs **上**的操作不能被 Back 溯回. 同一个导航层级是不应该被溯回的.

 

### 6. 溯回 (反向遍历) Drawer

[![slides.011](http://www.phonekr.com/wp-content/uploads/2014/02/slides.011-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.011.png)

和 Tabs 一样, Drawer 中的导航项也不应该被溯回. 理由同上. 当用户在不同的导航项中切换时, 你应该重置任务状态. 在不同的导航项目中切换就像是切换到不同的应用中一样 (比如说, 在 Google+ 中, Photos Tab 根本就是另一个应用… ). 在用户按下 Back 的时候, 你应该退出应用, 或者回到应用的主界面 —— 这里的主界面是指那个自然状态下的初始界面, 一个你特别希望用户 (同时用户也特别期待能够容易地) 回到的地方.

 

### 7. 深层的 Navigation Drawer

[![slides.012](http://www.phonekr.com/wp-content/uploads/2014/02/slides.012-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.012.png)

前文说过, 一个移动应用不应该有复杂的结构. 如果你需要特别多的导航层级, 那么说明你真正应该做的其实是简化你的应用结构. Drawer 存在的意义是提供一个稳定的导航枢纽, 让用户不需要记住自己在什么地方, 他只要打开 Drawer 就能自然的明白一切. 但是, 如果在 Drawer 里面弹出了一个次级 Drawer 会把很多人逼疯.

Drawer 虽然有能力承载多个导航层级, 但是正确的做法不是这样的.

[![slides.013](http://www.phonekr.com/wp-content/uploads/2014/02/slides.013-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.013.png)

当你需要在 Drawer 中放入多个导航层级的时候, 不应该以新弹出一个 Drawer 的方式, 而是应该以展开/折叠的方式呈现这个子层级. 展开和折叠并不会造成整个控件的剧变, 同时能展示给用户少多一些的项目. 关于 Drawer 上的导航项以及触摸区域的设置, 在 [Android Design](https://developer.android.com/design/patterns/navigation-drawer.html "Navigation Drawer | Android Design") 中另有提及.

[![slides.014 - 2](http://www.phonekr.com/wp-content/uploads/2014/02/slides.014-2-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.014-2.png)

如果你的导航层级真的很深, 你可以单独做出一个次级导航页 展示所有的导航项目. 比如说, 在 Play Music 中, 曲库下的 Tabs (艺人, 专辑, 风格, 曲目) 其实完全可以做成 Drawer 中的次级导航项, 但是把它们分散到 Tabs 中能够更好的优化导航. (上图这样则是有点类似腹肌式的导航方式. 当然, 最好不要只是在上面写着文字, 可以往里面添加点图片啊, 内容预览什么的)

 

### 8. 错误的 Drawer 转场

我们在这里说转场的时候, 是意味着过渡动画和一个有着 Drawer 的界面和没有 Drawer 的界面之间的切换. 下面两个错误都和这个转场有关.

[![slides.015](http://www.phonekr.com/wp-content/uploads/2014/02/slides.015-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.015.png)

当用户打开 Drawer, 按下其中一个项目之后, 他不应该被带去一个有着 Up 箭头的新界面. 所有在 Drawer 中呈现的导航项, 都应该在其界面中显示 Drawer 指示 (比如说, “汉堡”). 而且, 当用户通过 Drawer 从其中一个导航项进入另一个导航项,  他不应该看到标准的视图切换动画 (渐变 + 放大, 常见于进入新界面/新活动时), 而应该是一个细致而迅速的渐隐 + 渐显动画, 伴随着 Drawer 的关闭而完成. 同样的动画也应该应用在 Action Bar 的转变上. 还有一个对于开发者而言常见的讨论是, 应该用 Activity 还是 Fragment? 这个问题并没有标准答案, 也很难回答. 一般来说还是视情况而定 —— 它实现起来难度如何? 对于我的应用而言靠谱吗? 如果你有什么建议的话当然欢迎评论.

[![slides.016](http://www.phonekr.com/wp-content/uploads/2014/02/slides.016-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.016.png)

上图展示的就是正确的做法, 在 Action Bar 上显示 Drawer Indicator.

 

### 9. 不显示 Up 箭头

[![slides.017](http://www.phonekr.com/wp-content/uploads/2014/02/slides.017-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.017.png)

上文说过, 所有出现在 Drawer 中的导航页面都应该显示 Drawer 指示, 这点反过来也是一样成立的 —— 没有显示在 Drawer 中的东西就不应该显示 Drawer 指示. 比如在上图, 当用户进入某个内容的时候, Drawer 指示依然显示. 实际上, 这个内容页已经不是导航页了, 也没有在 Drawer 中显示, 这里是应用更深的层级, 已经不归 Drawer 管了. 这里应该显示的是 Up.

[![slides.018](http://www.phonekr.com/wp-content/uploads/2014/02/slides.018-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.018.png)

在显示 Up 同时, 你也可以允许用户以边缘滑动的方式唤出 Drawer. 你不需要总是显示 Drawer 指示来告诉用户可以唤出 Drawer, 因为在次级界面中唤出 Drawer 是某种意义上的”进阶用户操作”. 有人发现了, 那很好, 没人发现, 不要紧, 通过 Up 他们依然能够找回他们需要的导航. 另外, 你可以看看 Google Play Newsstand 是如何处理在没有 Drawer 指示的地方处理 Drawer 的 —— 渐变动画真的非常重要.

 

### 10. 右侧导航

[![slides.019](http://www.phonekr.com/wp-content/uploads/2014/02/slides.019-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.019.png)

前文说过, Android 上有个规律就是”导航靠左, 操作靠右”. 对于从左向右阅读的用户而言, 左侧导航项能够更好的强调导航层级. 另外, 由于 Spinners 只能出现在左侧, Tabs 也往往将最左侧的一个设为默认, 右侧的 Drawer 与这些操作距离过远. 而且, Drawer 指示放在左边, 操作的时候向左回缩, 如果在右侧使用 Drawer 的话就会遇到视觉隐喻冲突.

[![slides.020](http://www.phonekr.com/wp-content/uploads/2014/02/slides.020-820x615.png)](http://www.phonekr.com/wp-content/uploads/2014/02/slides.020.png)

正确的做法就是如上图所示. 当然, 如果在从右向左的语言环境下 (比如说, 希伯来文什么的, 不过我觉得我们国家的开发者应该不怎么会去做希伯来语适配吧…), 那当然是应该反转这些东西的位置.

 

以上就是本期 ADiA 介绍的全部十个导航设计错误. 如果你有更多的常见/不常见错误, 或者对于上面提出的错误有更好的解决方案, 当然欢迎评论.

> 最后, 一如既往的感谢 [+Roman Nurik](https://plus.google.com/u/0/113735310430199015092) 和 [+Nick Butcher](https://plus.google.com/u/0/118292708268361843293) 的 [Android Design in Action](https://plus.google.com/u/0/118292708268361843293/posts/1jeyV2n1ZpM "Android Design in Action: Navigation anti-patterns") 活动.
