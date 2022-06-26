import'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:survey/provider_data.dart';
import 'package:survey/question_screen.dart';
import'view_page.dart';
import'constants.dart';

class InstructionScreen extends StatelessWidget {
  InstructionScreen({Key? key}) : super(key: key);
  final PageController _pageController = PageController();
  final List<ViewPage> viewPage = const [
    ViewPage('images/surveyImage1.png','Thanks for participating in the survey, it\'s nice to have you here 😊','Welcome',),
    ViewPage('images/welcomeScreenImage.png', 'Please tick the right box option for each question. Each question has a total point of and the survey itself has a total point of 20.', 'Instruction to the survey'),
    ViewPage('images/surveyImage2.png', 'See whether patients are following through with their care plan and intervene in emergencies.', 'Let\'s get started'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Stack(
              children: [
                PageView(
                  onPageChanged: (index){
                    Provider.of<ProviderData>(context,listen: false).changeIndex(index);
                  },
                  controller: _pageController,
                  children: viewPage,
                ),
                Positioned(
                  top: 550.h,
                  left: MediaQuery.of(context).size.width/2-20.w,
                  child: SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: 3,
                    effect: SwapEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: kDesignColor,
                      dotColor: Color(0xFFC4C4C4),
                    ), // your preferred effect
                    onDotClicked: (index) {
                      _pageController.jumpToPage(index);
                    },
                  ),
                ),
               
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    switch (Provider.of<ProviderData>(context,listen: false).index) {
                      case 0:
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionScreen()));
                        break;
                      default:
                        _pageController.jumpToPage(Provider.of<ProviderData>(context,listen: false).index-1);
                        break;
                    }
                  },
                  child: Text(
                    Provider.of<ProviderData>(context,listen: true).index==0?'Skip':'Previous' ,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Messina Sans',
                        color: Colors.black
                    ),
                  ),
                ),
                MaterialButton(
                  color: kDesignColor,
                  height: 50,
                  minWidth: 119,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  onPressed: () {
                    switch (Provider.of<ProviderData>(context,listen: false).index) {
                      case 2:
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionScreen()));
                        break;
                      default:
                        _pageController.jumpToPage(Provider.of<ProviderData>(context,listen: false).index+1);
                        break;
                    }
                  },
                  child: Text(
                    Provider.of<ProviderData>(context,listen: true).index==2? 'Start survey':'Next',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
