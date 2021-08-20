import 'package:flutter/material.dart';

class Registrationnew extends StatefulWidget {
  @override
  _RegistrationnewState createState() => _RegistrationnewState();
}
class _RegistrationnewState extends State<Registrationnew> {
  List<dynamicWidget> dynamicList = [];
  List<String> Price = [];
  List<String> Product = [];

  Icon floatingIcon = new Icon(Icons.add);

  addDynamic() {
    if (Product.length != 0) {
      Icon floatingIcon = new Icon(Icons.add);
      Product = [];
      Price = [];
      dynamicList = [];
    }
    setState(() {});
    if (dynamicList.length >= 15) {
      return;
    }
    dynamicList.add(new dynamicWidget());
  }
  @override
  Widget build(BuildContext context) {
    Widget result = new Flexible(
        flex: 1,
        child: new Card(
            ));

    Widget dynamicTextField = new Flexible(
      flex: 2,
      child: new ListView.builder(
        itemCount: dynamicList.length,
        itemBuilder: (_, index) => dynamicList[index],
      ),
    );
    return Material(
      // child:Container(
      //   child: new Column(children: <Widget>[
      //       Product.length == 0 ? dynamicTextField : result,
      //      // Product.length == 0 ? submitButton : new Container(),
      //     ]),
      // ),
      
       
      child: new Scaffold(
        // body: new Container(
        //   margin: new EdgeInsets.all(10.0),
        //   child: new Column(children: <Widget>[
        //     Product.length == 0 ? dynamicTextField : result,
        //    // Product.length == 0 ? submitButton : new Container(),
        //   ]),
        // ),
        body: Container(
          child: new Column(
            children: <Widget>[
          Product.length == 0 ? dynamicTextField : result,
        ],
        ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: addDynamic,
        child: floatingIcon,
        ),
      ),
    );

  }
}
class dynamicWidget extends StatelessWidget {
  TextEditingController Product = new TextEditingController();
  TextEditingController Price = new TextEditingController();
  var grade1;
  final List<String> _gradeValues = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
//      margin: new EdgeInsets.all(8.0),
      child: ListBody(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 200,
                height: 40,
                padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                child: new TextFormField(
                  controller: Product,
                  decoration: const InputDecoration(
                      labelText: 'Child Name', border: OutlineInputBorder()),
                ),
              ),
              Container(
                width: 120,
                height: 40,
                padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Grade"),
                      value: this.grade1,
                      isDense: true,
                      isExpanded: true,
                      items: _gradeValues
                          .map((value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (val) {
                        this.grade1 = val;
                        // setState(() {
                        //   this.grade1 = val;
                        //   print(val);
                        // });
                      },
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
