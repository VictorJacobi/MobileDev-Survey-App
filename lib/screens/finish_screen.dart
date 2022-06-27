import 'package:flutter/material.dart';
import 'package:survey/constants.dart';
import 'package:survey/screens/result_screen.dart';
import 'package:survey/models/results.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({Key? key,this.results}) : super(key: key);
  final List<ResultData>? results;

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  int _calculateResult(){
    int score = 0;
    for(var value in widget.results!){
      if(value.isCorrect()){
        score++;
      }
    }
    return score;
  }
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://cdn.dribbble.com/users/1771704/screenshots/15410121/media/7975e833edb0208b88b05933508b3c21.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.play();
    _controller.setLooping(true);

  }
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResultScreen()));
        }, label: const Text('Check result'),backgroundColor: kDesignColor,),
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Congratulations 👏',style: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.w700),),
                    SizedBox(height: 20.h,),
                    Text('You just completed the survey.',style: TextStyle(fontSize: 20.sp),),
                    SizedBox(height: 5.h,),
                    Text('Your score is: ${_calculateResult()}'),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child:  _controller.value.isInitialized
                  ? SizedBox(width: MediaQuery.of(context).size.width,height: 280.h,child: VideoPlayer(_controller),)
                  : SizedBox(width: MediaQuery.of(context).size.width,height: 280.h,child: const Center(child: CircularProgressIndicator()),),
            ),
          ],
        ),
      ),
    );
  }
}
