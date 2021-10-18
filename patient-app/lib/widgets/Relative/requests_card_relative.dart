import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:treatment_checkup_app/models/requests_relative.dart';
import 'package:treatment_checkup_app/screens/Relative/relative_home.dart';
import 'package:treatment_checkup_app/screens/welcomeBoarding/welcomeBoarding.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
//List<Color> color_list=[Colors.red,Colors.brown,Colors.deepOrangeAccent,Colors.green,Colors.yellow,Colors.blue];
String _defaultPic = "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png";
class RekuestsCardRelative extends StatefulWidget {

  final Function press;
  final List<RExerciseRequest> exercises;
  final RExerciseRequest request;
  const RekuestsCardRelative({
    Key key,
    this.exercises,
    this.request,
    this.press,
  }) : super(key: key);

  @override
  _RekuestsCardRelativeState createState() => _RekuestsCardRelativeState();
}

class _RekuestsCardRelativeState extends State<RekuestsCardRelative> {
 
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),

        child: Container(

          width: constraint.maxWidth / 2 -
              10,
          // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            //border: Border.all(color: kBlueColor),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.press,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(

                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      // child:CircleAvatar(// backgroundColor: color_list[((widget.request.firstName[0]).codeUnitAt(0)%6)],
                      //     child: Text(widget.request.firstName[0]))
                      decoration: BoxDecoration(
                        color: Colors.white ,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                       //  image: DecorationImage(
                       //   image:
                       //
                       //
                       //   NetworkImage(widget.request.profilePic),
                       // //   AssetImage("assets/images/Dylan.jpg"),
                       //    fit: BoxFit.fill,
                       //
                       //  ),
                      ),
                       child:CachedNetworkImage(
                         imageUrl: widget.request.profilePic==''?widget.request.profilePic : _defaultPic,
                         imageBuilder: (context, imageProvider) => Container(
                           height: 140,
                           width: 140,
                           decoration: BoxDecoration(
                               image: DecorationImage(
                                 image: imageProvider,
                                 fit: BoxFit.cover,
                               ),
                               shape: BoxShape.circle
                           ),
                         ),
                         placeholder: (context, url) => CircularProgressIndicator(),
                         errorWidget: (context, url, error) => Icon(Icons.error),
                       )
                       //Image(
                      //   image: AssetImage(widget.request.image),
                      //   fit: BoxFit.fill,
                      //
                      // ),
                      // child: Icon(
                      //   Icons.person,
                      //  // color: widget.request.status=="Accepted" ? Colors.green :widget.request.status=="Rejected"? Colors.red:Colors.yellow,
                      // ),
                    ),
                    SizedBox(width: 10),

                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.request.firstName+" "+widget.request.lastName,
                                //type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                            //  SizedBox(width: constraint.maxWidth*0.2),
                              //display buttton if no action else display result
                             widget.request.markedByRelative==0? Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){showDialog(context: context,
                                        builder: (BuildContext context){
                                          return CustomDialogBox2(
                                            title: "Please select all completed exercises:",
                                         //   descriptions: "If you press Yes, exercise will be marked done and cannot be changed later!",
                                            text: "Proceed",
                                              exercises:widget.exercises

                                          );
                                        }
                                    );},
                                    child: Container(

                                      height: 42,
                                      width: 60,alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlueAccent,//request.status=="Accepted" ? Colors.green :request.status=="Rejected"? Colors.red:Colors.yellow,
                                        // shape: BoxShape.values[],
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        //border: Border.all(color: kBlueColor),
                                      ),
                                      child: Text(
                                        "Accept",
                                        // type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                    ),
                                  ),SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: (){showDialog(context: context,
                                        builder: (BuildContext context){
                                          return CustomDialogBox2(
                                            title: "Do you wish to reject the request?",
                                           // descriptions: "If you press Yes, exercise will be marked not done and cannot be changed later!",
                                            text: "Yes", exercises:widget.exercises
                                          );
                                        }
                                    );},
                                    child: Container(
                                      height: 42,
                                      width: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,//request.status=="Accepted" ? Colors.green :request.status=="Rejected"? Colors.red:Colors.yellow,
                                        // shape: BoxShape.values[],
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        //border: Border.all(color: kBlueColor),
                                      ),
                                      child: Text(
                                        "Reject",
                                        // type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
                                    ),
                                  )
                                ],
                              )
                                // keep when all requests will be sent

                                 :
                             Row(
                               children: [
                                 Container(
                                   height: 42,
                                   width: 43,
                                   decoration: BoxDecoration(
                                     color: Colors.white,//request.status=="Accepted" ? Colors.green :request.status=="Rejected"? Colors.red:Colors.yellow,
                                     shape: BoxShape.circle,
                                     //border: Border.all(color: kBlueColor),
                                   ),
                                   child: Icon(
                                     widget.request.markedByRelative==1 ? Icons.mark_chat_read :widget.request.markedByRelative==2? Icons.mark_chat_read:Icons.mark_chat_unread,
                                     color: widget.request.markedByRelative==1 ? Colors.green :widget.request.markedByRelative==2? Colors.red:Colors.yellow,
                                   ),
                                 ),//SizedBox(width: 20),
                                 // Text(
                                 //   widget.request.markedByRelative.toString(),
                                 //   //type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                 //   style: Theme.of(context).textTheme.subtitle,
                                 // ),
                               ],
                             ),

                            ],
                          ),
                          Text(
                            "Day "+widget.request.todayDay.toString(),

                            // type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}




//custom dialoge box.




class CustomDialogBox2 extends StatefulWidget {

  final String title,  text;
  final String img;
 final List<RExerciseRequest> exercises;
  const CustomDialogBox2({Key key, this.title,  this.text, this.img, this.exercises}) : super(key: key);

  @override
  _CustomDialogBox2State createState() => _CustomDialogBox2State();
}

class _CustomDialogBox2State extends State<CustomDialogBox2> {
  List<RExerciseRequest> selectedList = [];
  UserTypeService userService;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();  userService= UserTypeService();
  }
  @override
  Widget build(BuildContext context) {
   print(widget.exercises[0].exerciseVideoUrl);
   // print(selectedList);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
         // margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(color: Colors.grey,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              !widget.title.contains("reject")?CheckboxListTile(
                 title: Text("Select All"),
                 secondary:Icon(Icons.select_all),
                 activeColor: Colors.green,
                 checkColor: Colors.purple,

                 value: selectedList.length==widget.exercises.length, onChanged:
                 (bool value){
               setState(() {
                 if(value){
    for (int b = 0; b < widget.exercises.length; b++) {
                if (!selectedList.contains(widget.exercises[b]))   selectedList.add(widget.exercises[b]);}
                 }
                 else{
                   selectedList.clear();

         }
                 }
              );
             }):Container(),


             !widget.title.contains("reject")?SizedBox(
                  height: MediaQuery.of(context).size.height*0.5,
               child: GridView.count(
                 crossAxisCount: 1,mainAxisSpacing: 3.0,childAspectRatio:5 ,
                 shrinkWrap: true,

                 children: List.generate(widget.exercises.length, (index){
                    List<bool> _checked=List<bool>.filled(widget.exercises.length,false,growable:false);
                    return CheckboxListTile(
                      title: Text(widget.exercises[index].exerciseName),
                       secondary:
                       //Image( image:

                        CachedNetworkImage(
                          imageUrl: widget.exercises[index].exerciseVideoUrl == null? 'https://jflowershealth.com/wp-content/uploads/2020/09/iStock-1172191646-1024x448.jpg' :'https://img.youtube.com/vi/${(Uri.tryParse(widget.exercises[index].exerciseVideoUrl)).queryParameters['v']}/0.jpg'
                         , imageBuilder: (context, imageProvider) => Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.rectangle,

                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),

                       //NetworkImage(widget.exercises[index].exerciseVideoUrl == ''? 'https://jflowershealth.com/wp-content/uploads/2020/09/iStock-1172191646-1024x448.jpg' :'https://img.youtube.com/vi/${(Uri.tryParse(widget.exercises[index].exerciseVideoUrl)).queryParameters['v']}/0.jpg')
                        // ,width: 50.0,height: 50.0,),
                        activeColor: Colors.green,
                        checkColor: Colors.purple,


                        onChanged:  (bool value){
                          setState(() {
                            if(value){
                              selectedList.add(widget.exercises[index]);
                            }else{
                              selectedList.remove(widget.exercises[index]);
                            }
                          });
                        },
                      value: selectedList.contains(widget.exercises[index]),
                    );
                  }
               ),
               )):Container(),
              SizedBox(height: 15,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed:  () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) {
                          return RouteToRequestScreen(widget.text,widget.exercises,widget.title,selectedList); //TODO
                        }),
                      );
    // if (widget.text=="Proceed"){
    // print("accepting Erequests");
    // int status=0;
    // for(int i=0;i<widget.exercises.length;i++){
    //   if(selectedList.contains(widget.exercises[i]) ){
    //  status += await userService.RUpdateExerciseRequest(widget.exercises[i].patientId,widget.exercises[i].todayDay,widget.exercises[i].exerciseId,"1");}
    // else{
    //     status += await userService.RUpdateExerciseRequest(widget.exercises[i].patientId,widget.exercises[i].todayDay,widget.exercises[i].exerciseId,"2");
    // }}
    // if(status==widget.exercises.length)Navigator.pop(context);
    //
    // }
    // else if (widget.title.contains("reject")){
    //   print("rejecting Erequest");
    //   int status=0;
    //   print(widget.exercises[0].patientId);
    //   for(int i=0;i<widget.exercises.length;i++){
    //
    //       status += await userService.RUpdateExerciseRequest(widget.exercises[i].patientId,widget.exercises[i].todayDay,widget.exercises[i].exerciseId,"2");
    //     }
    //   if(status==widget.exercises.length)Navigator.pop(context);
    //
    // }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     return RequestsScreenR();
    //   }),
    // );
    },

                    child: Text(widget.text,style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),

      ],
    );
  }
}


class RouteToRequestScreen extends StatefulWidget {
  final List<RExerciseRequest> exercises;
  final String text;
  final String title;
  final List<RExerciseRequest> selectedList;
  RouteToRequestScreen(this.text,this.exercises,this.title,this.selectedList);
  @override
  _RouteToRequestScreenState createState() => _RouteToRequestScreenState();
}

class _RouteToRequestScreenState extends State<RouteToRequestScreen> {



  UserTypeService userService;
  bool isLoading;
  Future<void> getMyWeekProgress() async {

    if (widget.text=="Proceed"){
      print("accepting Erequests");
      //print(widget.exercises.length);
      int status=0;
      for(int i=0;i<widget.exercises.length;i++){
        if(widget.selectedList.contains(widget.exercises[i]) ){
          // print(widget.exercises[i].patientId);
          // print(widget.exercises[i].todayDay);
          // print(widget.exercises[i].exerciseId);
          status += await userService.RUpdateExerciseRequest(widget.exercises[i].userId,widget.exercises[i].todayDay,widget.exercises[i].exerciseId,"1");}
        else{
          status += await userService.RUpdateExerciseRequest(widget.exercises[i].userId,widget.exercises[i].todayDay,widget.exercises[i].exerciseId,"2");
        }}
      if(status==widget.exercises.length)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return RequestsScreenR();
      }),
        // Navigator.pushAndRemoveUntil(context,
        //   MaterialPageRoute(builder: (BuildContext context) => RequestsScreenR()),
        //       (Route<dynamic> route) => route is WelcomeBoarding
      );
print(status);
    }
    else if (widget.title.contains("reject")){
      print("rejecting Erequest");
      int status=0;
      print(widget.exercises[0].userId);
      for(int i=0;i<widget.exercises.length;i++){

        status += await userService.RUpdateExerciseRequest(widget.exercises[i].userId,widget.exercises[i].todayDay,widget.exercises[i].exerciseId,"2");
      }
      if(status==widget.exercises.length) Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return RequestsScreenR();
        }),
        // Navigator.pushAndRemoveUntil(context,
        //   MaterialPageRoute(builder: (BuildContext context) => RequestsScreenR()),
        //       (Route<dynamic> route) => route is WelcomeBoarding
      );

    }
    // print("curr day sent is "+widget.currDay.toString());
    // bool status = await userService.UpdateDayExerciseStatus(widget.currDay);
    // print(status);
    // if(status == widget.exercises.length){
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (_) {
    //       return RequestsScreenR();
    //     }),
    //   );
    // }
  }


  @override
  void initState() {
    isLoading = true;
    userService = UserTypeService();
    getMyWeekProgress();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitFoldingCube(color: Colors.green),
      ),
    );
  }
}