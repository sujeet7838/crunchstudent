 //import 'package:crunchtutor/widgets/drawer.dart';
import 'package:crunchstudent/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   var mainsub, secondsub,grade;
     final List<String> _mainsublectValues = ['Chemstry','History','Math']; //T
     final List<String> _secondublectValues = ['Organic chemistry','Algebra','Indian History']; 
     final List<String> _gradeValues = ['Class 1','Class 2','Class 3','Class 4','Class 5','Class 6','Class 7','Class 8','Class 9']; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0xfff4f7ff),
        appBar: AppBar(
        backgroundColor:Color(0xfff4f7ff),
        //title: Text("Welcome"),
         actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.notification_add,
        color: Color(0xff0c3053),
      ),
      onPressed: () {
        // do something
      },
    ),
       IconButton(
      icon: Icon(
        Icons.account_circle_sharp,
        color: Color(0xff0c3053),
      ),
      onPressed: () {
        // do something
      },
    )
  ],
        ),
       
      body: SafeArea(
        child: SingleChildScrollView(
                 child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
       
      Card(
        color: Colors.white,
        margin: EdgeInsets.all(20),
        elevation: 15,
        child: SizedBox(
        height: 630, 
        child: Container(
               child:Column(
               crossAxisAlignment : CrossAxisAlignment.start,
               children: <Widget> [
              SizedBox(height: 10.0,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text("Get Instant Help for Your Child from Experienced Tutors",
              textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0c3053),
                          ),
                        ),
              ),
        SizedBox(height: 10.0,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
          child:InputDecorator(
            decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                contentPadding: EdgeInsets.all(10),
              
            ),
            child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                   hint: Text("Main Subject"),
                  value:this.mainsub,
                    isDense: true,
                    isExpanded: true,
               items: _mainsublectValues
                .map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ))
                .toList(),
                    onChanged: (newValue) {
                        setState(() {
                          this.mainsub = newValue;
                        });
                    },
                ),
            ),
        ),
        ),
         SizedBox(height: 10.0,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
        child:InputDecorator(
        decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                contentPadding: EdgeInsets.all(10),),
            child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    hint: Text("Second Subject"),
                  value:this.secondsub,
                    isDense: true,
                    isExpanded: true,
               items: _secondublectValues
                .map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ))
                .toList(),
                    onChanged: (val) {
                        setState(() {
                          this.secondsub=val;
                        });
                    },
                ),
            ),
        ),
        ),
        SizedBox(height: 10.0,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
        child:InputDecorator(
        decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                contentPadding: EdgeInsets.all(10),),
            child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    hint: Text("Grade"),
                    value:this.grade,
                    isDense: true,
                    isExpanded: true,
               items: _gradeValues
                .map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ))
                .toList(),
                    onChanged: (val) {
                        setState(() {
                          this.grade=val;
                        });
                    },
                ),
            ),
        ),
                ),
              SizedBox(
                  height: 10.0,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                child:TextField(
            //controller: _eateryController,
                autofocus: false,
            decoration:
            InputDecoration(labelText: '10-06-2021', hintText: 'Date',
             border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(5),
                suffixIcon: Icon(
                      Icons.date_range,
                    ),),
          ),
                ),
                  SizedBox(
                  height: 10.0,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                child:TextField(
                 style: TextStyle(
                  fontSize: 11.0,
                  height: 2.0,
                  color: Colors.black                  
                ),
            //controller: _eateryController,
            autofocus: false,
            decoration:InputDecoration(labelText: '05:45', hintText: 'Time',
             border: OutlineInputBorder(),
             contentPadding: EdgeInsets.all(5),
                suffixIcon: Icon(
                      Icons.timer,
                    ),),
                ),
                ),
                   SizedBox(
                  height: 10.0,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                child:TextField(
                  textAlignVertical: TextAlignVertical.top,
                  style: TextStyle(
                  fontSize: 11.0,
                  height: 3.0,
                  color: Colors.black                  
                ),
                autocorrect: true,
                decoration: InputDecoration(
                hintText: 'Describe the problem (optional)',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white70,
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.grey),
                ),
              ),)
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
               child:ElevatedButton.icon(
               style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Color(0xff3049ac))
              ),
            
               onPrimary: Colors.grey,
                  primary: Color(0xffe8effd),
                 minimumSize: Size(350,50),    
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),  
                        
               ),
               
                icon: Icon(Icons.save_alt, color:Colors.grey,), 
                 label: Text('Upload the Problem'),
                 onPressed: (){ print('Upload the problem'); },
                 )
                ),
                   SizedBox(
                  height: 10.0,
                ),
              //   Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
              // child:Row(children: <Widget>[
              //     Expanded(
              //       child: new Container(
              //         margin: const EdgeInsets.only(left: 10.0, right: 15.0),
              //         child: Divider(
              //         color: Colors.black,
              //         height: 50,
              //         )),
              //     ),
                
              //     Text("OR"),
                
              //     Expanded(
              //       child: new Container(
              //         margin: const EdgeInsets.only(left: 15.0, right: 10.0),
              //         child: Divider(
              //         color: Colors.black,
              //         height: 50,
              //         )),
              //     ),
              //     ]),
              //   ),
          

                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
               child:ElevatedButton.icon(
               style: ElevatedButton.styleFrom(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Color(0xff3049ac))
              ),
                onPrimary: Colors.grey,
                primary: Color(0xffe8effd),
                minimumSize: Size(350,50),    
                textStyle: TextStyle(
                color: Colors.black,
                fontSize: 15,
                  ),             
               ),
                icon: Icon(Icons.camera_alt_outlined, color:Colors.grey,), 
                 label: Text('Take a Photo'),
               onPressed: (){ print('Take a photo.'); },
            )
                ),
                   SizedBox(
                  height: 10.0,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
           child:ElevatedButton(
              child: Text("Find Me a Tutor"),
               style: ElevatedButton.styleFrom(
                 onPrimary: Colors.white,
                  primary: Color(0xff3049ac),
                 minimumSize: Size(350,50),                 
               ),
              onPressed: (){ print('Button Tutor.'); },
            )
                ),
           
    ]
),
         
          ),
        ),
      ),
    ],
  ), 
     
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
