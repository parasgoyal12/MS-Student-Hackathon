import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/Localization/localization_constant.dart';
import 'package:treatment_checkup_app/constants.dart';

import 'package:treatment_checkup_app/services/auth/UserTypeService.dart';
//this is patient side request page
class RekuestCard extends StatefulWidget {

  final Function press;

  final List<PatientRequestModel> request;
  const RekuestCard({
    Key key,
    this.request,
    this.press,
  }) : super(key: key);

  @override
  _RekuestCardState createState() => _RekuestCardState();
}

class _RekuestCardState extends State<RekuestCard> {
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
              onTap: (){ //Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> RequestsScreenR()));
              },
              child: Padding(

                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: Colors.white ,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Icon(
                        Icons.check_circle_outline_outlined,
                        color: widget.request[0].markedByRelative!=0 ? Colors.green :Colors.yellow,
                      ),
                    ),
                    SizedBox(width: 10),

                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              getTranslated(context, "day")+" "+widget.request[0].todayDay.toString(),
                              //widget.request.Relative_name,
                              //type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                             SizedBox(width: constraint.maxWidth*0.3),
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
                                    widget.request[0].markedByRelative!=0 ? Icons.mark_chat_read :Icons.mark_chat_unread,
                                    color: widget.request[0].markedByRelative!=0 ? Colors.green :Colors.yellow,
                                  ),
                                ),//SizedBox(width: 20),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    widget.request[0].markedByRelative==0?getTranslated(context, "no_action"):getTranslated(context, "processed"),
                                    //type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                                    style: Theme.of(context).textTheme.subtitle,softWrap: true,overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                        Text(
                          getTranslated(context, "all_exercises"),
                         // type==1?"Day""$rekuestNum":"Week"+"$rekuestNum",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
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
