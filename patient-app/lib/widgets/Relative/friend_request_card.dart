import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/constants.dart';
import 'package:treatment_checkup_app/models/exercise.dart';
import 'package:treatment_checkup_app/models/requests_relative.dart';
import 'package:treatment_checkup_app/screens/Relative/friend_request_screen.dart';
import 'package:treatment_checkup_app/screens/Relative/relative_home.dart';
import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';

String _defaultPic = "https://i.pinimg.com/originals/51/f6/fb/51f6fb256629fc755b8870c801092942.png";
class FriendRequestCardRelative extends StatefulWidget {

  final Function press;
  final FRequestModel request;
  final String number;
  const FriendRequestCardRelative({
    Key key,
    this.request,
    this.number,
    this.press,
  }) : super(key: key);

  @override
  _FriendRequestCardRelativeState createState() => _FriendRequestCardRelativeState();
}

class _FriendRequestCardRelativeState extends State<FriendRequestCardRelative> {

  @override
  Widget build(BuildContext context) {

    final status= widget.number==widget.request.relative_1? widget.request.relative_1_status:widget.request.relative_2_status;

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
                          imageUrl: widget.request.profile_pic.length > 10 ?widget.request.profile_pic : _defaultPic,
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
                      // decoration: BoxDecoration(
                      //   color: Colors.white ,
                      //   shape: BoxShape.circle,
                      //   border: Border.all(color: kBlueColor),
                      //
                      //  image: widget.request.profile_pic!=""? DecorationImage(
                      //     image: NetworkImage(widget.request.profile_pic),
                      //     fit: BoxFit.fill,
                      //
                      //   ):DecorationImage(
                      //    image: AssetImage('assets/images/Dylan.jpg'),
                      //    fit: BoxFit.fill,
                      //
                      //  )
                      //
                      // ),
                      // child: Image(
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
                                widget.request.first_name+" "+widget.request.last_name,
                                //type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                              //  SizedBox(width: constraint.maxWidth*0.2),
                              //display buttton if no action else display result
                              status=="W"? Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){showDialog(context: context,
                                        builder: (BuildContext context){
                                          return CustomDialogBox(
                                            title: "Do you wish to accept the request?",
                                            // descriptions: "If you press Yes, exercise will be marked not done and cannot be changed later!",
                                            text: "Yes",request: widget.request,
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
                                          return CustomDialogBox(
                                            title: "Do you wish to reject the request?",
                                            // descriptions: "If you press Yes, exercise will be marked not done and cannot be changed later!",
                                            text: "Yes",
                                              request: widget.request,
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
                              ):
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
                                      status=="A" ? Icons.mark_chat_read :status=="R"? Icons.mark_chat_read:Icons.mark_chat_unread,
                                      color: status=="A" ? Colors.green :status=="R"? Colors.red:Colors.yellow,
                                    ),
                                  ),//SizedBox(width: 20),
                                  Text(
                                    status,
                                    //type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                    style: Theme.of(context).textTheme.subtitle,
                                  ),
                                ],
                              ),

                            ],
                          ),
                          // Text(
                          //   widget.request.date,
                          //
                          //   // type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                          //   style: Theme.of(context).textTheme.bodyText2,
                          // ),
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




class CustomDialogBox extends StatefulWidget {
  final String title,  text;
  final Image img;
final FRequestModel request;
  const CustomDialogBox({Key key, this.title,  this.text, this.img,this.request}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {

  UserTypeService userService;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();  userService= UserTypeService();
  }
  @override

  Widget build(BuildContext context) {

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
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () async {
                     if (widget.title.contains("accept")){
                       print("accepting Frequest");
                       int status = await userService.UpdateFriendRequest(widget.request.user_id,"A");
                       if(status==1)Navigator.pop(context);
                       Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(builder: (context) {
                           return FriendRequestScreenR();
                         }),
                       );
                     }
                     else if (widget.title.contains("reject")){
                      print("rejecting Frequest");
                    int status = await userService.UpdateFriendRequest(widget.request.user_id,"R");
                     if(status==1) Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return FriendRequestScreenR();
                        }),
                      );
                     }
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