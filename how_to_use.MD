# 流体布局的使用

---

## 简介：

iOS原有的排版方式就好比贴纸画一样，这样的方式相对灵活，但往往开发者需要关心每个素材的位置、大小，如果涉及到相对位置排版（比如狮子要在青蛙的右边且距离xx个像素），开发者还需关注哪些素材与哪些素材相关联。
![贴花](resource/tiehua.png =600)

而流体布局就好比积木一样，先有基底才有塔峰；哪些素材排在同一层？哪些素材排在新的一层？这些完全由织梦者去选择不同的素材来决定，你可以选择长一点的木块放到新的一层也可以选择多个短一点的木块凑在同一层；流体布局也一样，从上往下，从左到右的排下来，开发者不需要再关心每一个素材的独立位置，开发者只需定义这个素材的类型（block或者inline），也不需要指定素材与素材直接的相对排版关系。
![积木](resource/jimu.png =600)

## 属性

### position - 布局方式

> 这是用ALEngine第一个需要指定的属性；它定义了view的布局方式，ALEngine提供了`absolute`与`relative`两种方式。

#### 取值：

* **relative - 相对布局 [默认]**：又称流体布局，根据view自身的展示类型（display）以及上一兄弟view的展示类型自动做相对位置的排版
* **absolute - 绝对布局**：绝对布局类似iOS原生的布局但不同于原生的布局，绝对布局最基本的特征就是这类view脱离它们原本所属的流体，不再与流体布局中的view相关联；所以绝对布局的view是需要设置`top` `left` `right` `bottom` `centerX` `centerY`来设置它们的位置，绝对布局自身虽然脱离了它所属的流（所在的父view的流），但它可以包含流体布局的view。

#### DEMO - 1 - 1

##### code
```objective-c
// 定义一个relative方式布局的body
ALView * body = [ALView new];
body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
[body addTo: self.view];

// 定义一个relative方式布局的section1，并将其添加到body中
ALView * section1 = [ALView new];
section1.style.height = 50;
// 设置view的外边距
section1.style.marginTop = 20;
section1.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
[section1 addTo: body];

// 定义一个relative方式布局的section2，并将其添加到body中
ALView * section2 = [ALView new];
section2.style.height = 100;
section2.style.marginTop = 20;
section2.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
[section2 addTo: body];

// 定义一个relative方式布局的section3，并将其添加到body中
ALView * section3 = [ALView new];
section3.style.height = 150;
section3.style.margin = (ALRect) {20, 0, 20, 0};
section3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
[section3 addTo: body];

// 定义一个absolute方式布局的absView，并将其添加到body中
ALView * absView = [ALView newAbsoluteView];
// 设置view的大小
absView.style.size = (CGSize) {80, 80};
// 设置view相对父view垂直水平居中
absView.style.center = (CGPoint) {0, 0};
absView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
[absView addTo: body];
```
##### 效果预览
![demo-1-1](resource/demo-1-1.png =320)

> 大概解释一下代码：
> 1、新建一个`relative`方式布局的body，并将它添加到self.view当中；
> 2、新建三个`relative`方式布局的section，并将它们添加到body当中；
> 3、新建一个`absolute`方式布局的absView，并将它添加到body当中；
> 最终的效果在我的设想内，`relative`方式布局的view会根据自身的展示类型（`display`，下一个属性会讲到）以及上一个view的展示类型来做相对位置的自动排版；而`absolute`方式布局的view则会脱离这套流体的约束，通过指定的位置信息（`top` `left` `right` `bottom` `centerX` `centerY`）来相对父view布局
***
> 注：在上面的demo当中，细心的童鞋应该还可以发现两个点：
> 1、我并没有给body设置高度，但最后body的高度却被relative方式布局的子view撑开了
> 2、我也并没有给section设置宽度，但最后他们的宽度都自动等于父view的宽度
> 这两个特征我会在下一个属性`display`讲到。

#### DEMO - 1 - 2

##### code
```objective-c
// 在上面的代码基础上，动态更改section2的高度
section2.style.height += 5;
// 或者
section2.style.height -= 5;
```

##### 效果预览
![demo-1-2](resource/demo-1-2.gif =320)

> 可以看到当section2的高度发生改变时，有以下相关联的view发生了重排：
> 1、下一个兄弟view section3的位置发生了重排；
> 2、父view body的高度也发生了重排；
> 3、由于父view高度发生了重排导致父view中使用了`absolute`方式布局且是居中定位的子view absView也发生了位置重排。
> 由此看来`absolute`方式排版的view虽然脱离的流体排版的影响，但还保留了动态更新布局的能力（这点是有别与iOS原生的布局）
