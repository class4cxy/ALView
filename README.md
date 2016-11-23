# ALView
ALView is not just an autolayout framework, but also provide a fastest way to layout like html's flow layout.

### \# You can use flowlayout by use block & inline
####[demo1] - flow layout
----
```objective-c
// new a block view as a body view
ALView * body = [[ALView alloc] init];
body.marginTop = 20;
[body addTo: self.view];

// a block view always break in a new line
ALView * blockArticle = [[ALView alloc] init];
// if you did not set `display`, default is ALDisplayBlock
// blockArticle.display = ALDisplayBlock;
blockArticle.height = 50;
blockArticle.width = 200;
blockArticle.backgroundColor = [UIColor yellowColor];
[blockArticle addTo:body];

ALView * blockArticle2 = [[ALView alloc] init];
blockArticle2.height = 100;
// if you did not set `width`, default is parent's width
blockArticle2.backgroundColor = [UIColor blueColor];
[blockArticle2 addTo:body];

// if previous view is inline view, a new inline view will layout next to previous in same line
// if previous view is block view, a new inline view will layout next to previous view and break in a new line
ALView * inlineTx1 = [[ALView alloc] init];
inlineTx1.display = ALDisplayInline;
inlineTx1.height = 40;
inlineTx1.width = 150;
inlineTx1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
[inlineTx1 addTo:body];

ALView * inlineTx2 = [[ALView alloc] init];
inlineTx2.display = ALDisplayInline;
inlineTx2.height = 40;
inlineTx2.width = 60;
inlineTx2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
[inlineTx2 addTo:body];

ALView * inlineTx3 = [[ALView alloc] init];
inlineTx3.display = ALDisplayInline;
inlineTx3.height = 40;
// will break in new line if need
inlineTx3.width = 200;
inlineTx3.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
[inlineTx3 addTo:body];
```
####[result]
------
![block and inline demo1](resource/block_inline_demo1.png)

####[demo2] - auto height & auto width
```objective-c
ALView * body = [[ALView alloc] init];
body.marginTop = 20;
[body addTo: self.view];

ALView * blockArticle = [[ALView alloc] init];
// if you did not set `height` property, it will auto update height by subview's total height
// which feature is also fit to inline view
// blockArticle.height = 50;
blockArticle.backgroundColor = [UIColor yellowColor];
[blockArticle addTo:body];

// create an inline view addto blockArticle
[[self createInlineViewWidth: 150 height:40 alpha:0.2] addTo: blockArticle];
[[self createInlineViewWidth: 60 height:40 alpha:0.5] addTo: blockArticle];
[[self createInlineViewWidth: 200 height:40 alpha:0.7] addTo: blockArticle];

ALView * inlineArticle = [[ALView alloc] init];
inlineArticle.display = ALDisplayInline;
// If you did not set `width` property on inline view
// It will auto update width by subview's total width, max width is parent's width
// inlineArticle.width = 320;
// inlineArticle.height = 50;
inlineArticle.backgroundColor = [UIColor redColor];
[inlineArticle addTo:body];

[[self createInlineViewWidth: 150 height:40 alpha:0.2] addTo: inlineArticle];
[[self createInlineViewWidth: 100 height:40 alpha:0.3] addTo: inlineArticle];
[[self createInlineViewWidth: 60 height:40 alpha:0.5] addTo: inlineArticle];
[[self createInlineViewWidth: 200 height:40 alpha:0.7] addTo: inlineArticle];

```
####[result]
------
![block and inline demo2](resource/block_inline_demo2.png)
### \# you can layout with marginTop, marginLeft, marginRight, marginBottom
####[demo1]
```objective-c
ALView * body = [[ALView alloc] init];
body.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
[body addTo:self.view];

ALView * article2 = [[ALView alloc] init];
article2.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.5];
article2.marginTop = 50;
article2.marginLeft = 20;
article2.marginRight = 20;
[article2 addTo:body];

[[self createInlineBox1:0.1] addTo:article2];
[[self createInlineBox1:0.2] addTo:article2];
[[self createInlineBox1:0.3] addTo:article2];
[[self createInlineBox1:0.4] addTo:article2];
[[self createInlineBox1:0.5] addTo:article2];
[[self createInlineBox1:0.6] addTo:article2];
[[self createInlineBox1:0.7] addTo:article2];
[[self createInlineBox1:0.8] addTo:article2];
[[self createInlineBox1:0.9] addTo:article2];
[[self createInlineBox1:1.0] addTo:article2];

[[self createInlineBox1:0.1] addTo:body];
[[self createInlineBox1:0.2] addTo:body];
[[self createInlineBox1:0.3] addTo:body];
[[self createInlineBox1:0.4] addTo:body];
[[self createInlineBox1:0.5] addTo:body];
[[self createInlineBox1:0.6] addTo:body];
[[self createInlineBox1:0.7] addTo:body];
[[self createInlineBox1:0.8] addTo:body];
[[self createInlineBox1:0.9] addTo:body];

- (ALView *) createInlineBox1: (CGFloat) alpha
{
    ALView * subInline = [[ALView alloc] init];
    subInline.height = 50;
    subInline.width = 40;
    subInline.marginTop = 10;
    subInline.marginLeft = 10;
    subInline.marginRight = 10;
    subInline.marginBottom = 10;
    subInline.display = ALDisplayInline;
    subInline.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    return subInline;
}
```
####[result]
------
![margin demo1](resource/margin_demo1.png)
### \# you also can layout by use position:relative & position:absolute

// todo
### \# layout with contentAlign:left/center/right is so nice

// todo
### \# we have `ALLabel` make things more easer

// todo