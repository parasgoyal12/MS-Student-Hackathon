import 'package:flutter/material.dart';


class ClickableTitleWithModel extends StatefulWidget {
  final String _categoriesofmonths;
  final int index;
  final classModel;
  ClickableTitleWithModel(this._categoriesofmonths,this.index,this.classModel);
  @override
  _ClickableTitleWithModelState createState() => _ClickableTitleWithModelState();
}

class _ClickableTitleWithModelState extends State<ClickableTitleWithModel> {

  var clientModel;

  bool isselected = false;

  bool stateofothermember = false;


  @override
  void initState() {
    clientModel =  widget.classModel;
    if(clientModel.activeFilter == widget.index){
      isselected = true;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(ClickableTitleWithModel oldWidget) {
    if(clientModel.activeFilter == widget.index){
      isselected = true;
    }
    else{
      isselected = false;
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){
        clientModel.changeActiveFilter(widget.index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget._categoriesofmonths,
            style: TextStyle(
              color: isselected ? Colors.white : Color(0xffac97c1),
              fontSize: isselected ? 15.0 : 13.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 7),
          ),
          Container(
            height: 4,
            width: 20,

            decoration: BoxDecoration(
              color: isselected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          )
        ],
      ),

    );
  }
}