OTPageScrollView
================

OTPageScrollView

![Output gif](https://github.com/yechunxiao19/OTPageScrollView/blob/master/OTPageView.gif)

Installation
======
If you want to install manually, copy the OTPageScrollView .h .m and OTPageView .h .m file to the project director.

Usage
======
	- (void)viewDidLoad
	{
	    [super viewDidLoad];
	    // Do any additional setup after loading the view.
	    
	    OTPageView *PScrollView = [[OTPageView alloc] initWithFrame:CGRectMake(0, 60, [[UIScreen mainScreen] bounds].size.width, 200)];
	    PScrollView.pageScrollView.dataSource = self;
	    PScrollView.pageScrollView.delegate = self;
	    PScrollView.pageScrollView.padding =50;
	    PScrollView.pageScrollView.leftRightOffset = 0;
	    PScrollView.pageScrollView.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width -150)/2, 60, 150, 100);
	    PScrollView.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:79.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
	    _dataArray = [NSArray arrayWithObjects:
	                          @"0 Google",
	                          @"1 Yahoo",
	                          @"2 Facebook",
	                          @"3 Twitter",
	                          @"4 Amazon",
	                          @"5 microsoft",
	                          @"6 evernote",
	                          @"7 MSN",
	                          @"8 abc",
	                          @"9 123",nil];
	     [PScrollView.pageScrollView reloadData];
	     [self.view addSubview:PScrollView];
	    UIView *arrowView = [[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2-2, 260, 4, 10)];
	    arrowView.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:79.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
	    [self.view addSubview:arrowView];
	}

	- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
	    return [_dataArray count];
	}
	
	- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
	    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	    cell.backgroundColor = [UIColor whiteColor];
	    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, cell.frame.size.width-40, cell.frame.size.height - 40)];
	    label.text = _dataArray[index];
	    [cell addSubview:label];
	    return cell;
	}
	
	- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView
	{
	    return CGSizeMake(100, 100);
	}
	
	- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
	    NSLog(@"click cell at %ld",index);
	}
	
	- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
	{
	    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
	    NSLog(@"click cell at %ld",index);
	}

# LICENSE
see [LICENSE](LICENSE) file.
