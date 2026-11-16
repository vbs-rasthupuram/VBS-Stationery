import 'package:flutter/material.dart';
void main()=>runApp(VBSApp());
List<Map<String,dynamic>> allBills=[];
List<Map<String,dynamic>> stockItems=[
{'name':'Blue Pen','qty':100,'price':10.0,'cat':'Stationery'},
{'name':'Black Pen','qty':50,'price':10.0,'cat':'Stationery'},
{'name':'Red Pen','qty':30,'price':10.0,'cat':'Stationery'},
{'name':'Pencil HB','qty':100,'price':5.0,'cat':'Stationery'},
{'name':'Eraser','qty':50,'price':5.0,'cat':'Stationery'},
{'name':'Sharpener','qty':50,'price':5.0,'cat':'Stationery'},
{'name':'Scale 30cm','qty':50,'price':15.0,'cat':'Stationery'},
{'name':'Geometry Box','qty':20,'price':50.0,'cat':'Stationery'},
{'name':'Cello Tape','qty':20,'price':25.0,'cat':'Stationery'},
{'name':'Glue Stick','qty':30,'price':20.0,'cat':'Stationery'},
{'name':'Fevicol 100ml','qty':20,'price':35.0,'cat':'Stationery'},
{'name':'Highlighter Set','qty':20,'price':40.0,'cat':'Stationery'},
{'name':'Marker Black','qty':20,'price':25.0,'cat':'Stationery'},
{'name':'Sketch Pens 12','qty':20,'price':40.0,'cat':'Stationery'},
{'name':'Crayons 12','qty':20,'price':35.0,'cat':'Stationery'},
{'name':'Colour Pencils 12','qty':20,'price':45.0,'cat':'Stationery'},
{'name':'Stickers Pack','qty':50,'price':20.0,'cat':'Stationery'},
{'name':'Washi Tape','qty':30,'price':30.0,'cat':'Stationery'},
{'name':'Chart Paper White','qty':50,'price':12.0,'cat':'Stationery'},
{'name':'Chart Paper Colour','qty':50,'price':15.0,'cat':'Stationery'},
{'name':'Brown Cover','qty':50,'price':8.0,'cat':'Stationery'},
{'name':'Book Labels','qty':100,'price':3.0,'cat':'Stationery'},
{'name':'Exam Pad','qty':20,'price':35.0,'cat':'Stationery'},
{'name':'File Folder','qty':30,'price':20.0,'cat':'Stationery'},
{'name':'JK Copier A4','qty':5,'price':300.0,'cat':'Office'},
{'name':'Notebook 100P','qty':100,'price':35.0,'cat':'Notebooks'},
{'name':'Notebook 200P','qty':50,'price':55.0,'cat':'Notebooks'},
{'name':'Notebook Small','qty':50,'price':15.0,'cat':'Notebooks'},
{'name':'Paper Plate 6','qty':50,'price':80.0,'cat':'Disposal'},
{'name':'Paper Plate 8','qty':50,'price':110.0,'cat':'Disposal'},
{'name':'Paper Plate 10','qty':30,'price':150.0,'cat':'Disposal'},
{'name':'Paper Cup','qty':30,'price':70.0,'cat':'Disposal'},
{'name':'Paper Spoon','qty':40,'price':60.0,'cat':'Disposal'},
{'name':'Paper Bags','qty':40,'price':50.0,'cat':'Disposal'},
{'name':'Foil Container','qty':30,'price':90.0,'cat':'Disposal'},
{'name':'Foil Roll','qty':20,'price':120.0,'cat':'Disposal'},
{'name':'Tissue Paper','qty':50,'price':40.0,'cat':'Disposal'},
{'name':'Packing Covers','qty':50,'price':60.0,'cat':'Disposal'},
{'name':'School Bag','qty':15,'price':450.0,'cat':'Others'},
{'name':'Water Bottle','qty':20,'price':180.0,'cat':'Others'},
{'name':'Tiffin Box','qty':15,'price':150.0,'cat':'Others'},
{'name':'Gift Item','qty':30,'price':99.0,'cat':'Others'},
{'name':'Greeting Card','qty':40,'price':25.0,'cat':'Others'},
{'name':'Stapler','qty':20,'price':85.0,'cat':'Office'},
{'name':'Scissors','qty':20,'price':45.0,'cat':'Office'},
{'name':'Xerox B/W','qty':999,'price':2.0,'cat':'Services'},
{'name':'Printout B/W','qty':999,'price':5.0,'cat':'Services'},
{'name':'Printout Colour','qty':999,'price':10.0,'cat':'Services'},
{'name':'Lamination A4','qty':999,'price':30.0,'cat':'Services'},
{'name':'Spiral Binding','qty':999,'price':60.0,'cat':'Services'},
{'name':'Passport Photo','qty':999,'price':40.0,'cat':'Services'},
];
String currentUser='',currentRole='';
void showMsg(BuildContext c,String m){ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text(m),backgroundColor:Colors.green));}
class VBSApp extends StatelessWidget{@override Widget build(BuildContext c)=>MaterialApp(debugShowCheckedModeBanner:false,title:'VBS',home:LoginScreen());}
Widget vbsLogo({double size=70})=>Container(width:size,height:size,decoration:BoxDecoration(color:Color(0xFF0B3D91),shape:BoxShape.circle,border:Border.all(color:Color(0xFFD4AF37),width:3)),child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Text('VBS',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:size*0.3)),Text('STATIONERY',style:TextStyle(color:Color(0xFFD4AF37),fontSize:size*0.11,fontWeight:FontWeight.bold))]))); 
class LoginScreen extends StatefulWidget{@override _LoginState createState()=>_LoginState();}
class _LoginState extends State<LoginScreen>{
final user=TextEditingController();
final pass=TextEditingController();
@override
Widget build(BuildContext context){
return Scaffold(body:Padding(padding:EdgeInsets.all(24),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
vbsLogo(size:110),
SizedBox(height:12),
Text('VBS STATIONERY',style:TextStyle(fontSize:26,fontWeight:FontWeight.bold,color:Color(0xFF0B3D91))),
Text('Rasathupuram, Chennai | 8667271415'),
SizedBox(height:8),
Text('"Here All Products Available With Affordable Prices"',style:TextStyle(fontStyle:FontStyle.italic,color:Colors.orange.shade800)),
SizedBox(height:24),
TextField(controller:user,decoration:InputDecoration(labelText:'Username',border:OutlineInputBorder(),prefixIcon:Icon(Icons.person))),
SizedBox(height:12),
TextField(controller:pass,obscureText:true,decoration:InputDecoration(labelText:'Password',border:OutlineInputBorder(),prefixIcon:Icon(Icons.lock))),
SizedBox(height:20),
SizedBox(width:double.infinity,height:50,child:ElevatedButton(child:Text('LOGIN'),onPressed:(){
if(user.text.trim()=='VBS'&&pass.text.trim()=='VBS123'){currentUser='VBS Staff';currentRole='Staff';}
else if(user.text.trim()=='admin'&&pass.text.trim()=='Banu2930*'){currentUser='Admin';currentRole='Admin';}
else{ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Wrong Username / Password'),backgroundColor:Colors.red));return;}
showMsg(context,'Welcome $currentUser! Login Successful');
Future.delayed(Duration(milliseconds:500),(){Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>Dashboard()));});
})),
SizedBox(height:12),
Text('Staff: VBS / VBS123 | Admin: admin / Banu2930*',style:TextStyle(fontSize:12,color:Colors.grey))
])));}}

class Dashboard extends StatelessWidget{
@override
Widget build(BuildContext context){
double t=allBills.fold(0,(s,e)=>s+(e['total'] as double));
int st=stockItems.fold(0,(s,e)=>s+(e['qty'] as int));
return Scaffold(
appBar:AppBar(title:Row(children:[vbsLogo(size:36),SizedBox(width:8),Text('VBS - Dashboard')]),actions:[Center(child:Padding(padding:EdgeInsets.only(right:12),child:Text(currentRole,style:TextStyle(fontWeight:FontWeight.bold))))]),
body:Padding(padding:EdgeInsets.all(16),child:Column(children:[
Row(children:[
Expanded(child:Card(child:Padding(padding:EdgeInsets.all(16),child:Column(children:[Text('Today Sales'),Text('Rs. $t',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold))])))),
SizedBox(width:12),
Expanded(child:Card(child:Padding(padding:EdgeInsets.all(16),child:Column(children:[Text('Total Stock'),Text('$st Pcs',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold))]))))
]),
SizedBox(height:16),
_btn(context,'New Bill',Colors.green,NewBillScreen()),
_btn(context,'Stock - Edit Available',Colors.orange,StockScreen()),
_btn(context,'Today Sales',Colors.blue,SalesScreen()),
_btn(context,'Logout',Colors.red,LoginScreen(),isLogout:true),
SizedBox(height:10),
Text('Logged in as: $currentUser')
])));}

Widget _btn(BuildContext ctx,String t,Color c,Widget p,{bool isLogout=false}){
return Container(width:double.infinity,height:60,margin:EdgeInsets.only(bottom:12),child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:c),child:Text(t,style:TextStyle(fontSize:18,color:Colors.white)),onPressed:(){
if(isLogout){showMsg(ctx,'Logged Out Successfully');Future.delayed(Duration(milliseconds:500),(){Navigator.pushReplacement(ctx,MaterialPageRoute(builder:(_)=>p));});}
else Navigator.push(ctx,MaterialPageRoute(builder:(_)=>p));
}));}
}
class NewBillScreen extends StatefulWidget{@override _BillState createState()=>_BillState();}
class _BillState extends State<NewBillScreen>{
final nameCtrl=TextEditingController();
final priceCtrl=TextEditingController();
List<Map<String,dynamic>> items=[];
String filter='All';
double get total=>items.fold(0,(s,e)=>s+(e['price'] as double));
List<Map<String,dynamic>> get filtered=>filter=='All'?stockItems:stockItems.where((e)=>e['cat']==filter).toList();
void addItem(){
if(nameCtrl.text.trim().isEmpty||priceCtrl.text.trim().isEmpty){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Item Name + Price podunga')));return;}
double? pr=double.tryParse(priceCtrl.text.trim());
if(pr==null)return;
setState((){items.add({'name':nameCtrl.text.trim(),'price':pr});nameCtrl.clear();priceCtrl.clear();});
showMsg(context,'Item Added to Bill');
}
@override
Widget build(BuildContext context){
List<String> cats=['All','Stationery','Notebooks','Office','Disposal','Services','Others'];
return Scaffold(
appBar:AppBar(title:Row(children:[vbsLogo(size:36),SizedBox(width:8),Text('New Bill')])),
body:Column(children:[
Container(height:40,child:ListView(scrollDirection:Axis.horizontal,children:cats.map((c)=>Padding(padding:EdgeInsets.symmetric(horizontal:4),child:ChoiceChip(label:Text(c),selected:filter==c,onSelected:(_)=>setState(()=>filter=c)))).toList())),
Container(height:110,child:ListView.builder(scrollDirection:Axis.horizontal,itemCount:filtered.length,itemBuilder:(_,i){
var s=filtered[i];
return InkWell(onTap:(){nameCtrl.text=s['name'];priceCtrl.text=s['price'].toString();showMsg(context,'${s['name']} Selected');},child:Container(width:120,margin:EdgeInsets.all(6),padding:EdgeInsets.all(8),decoration:BoxDecoration(color:Colors.blue.shade50,borderRadius:BorderRadius.circular(10),border:Border.all(color:Colors.blue.shade200)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(s['name'],maxLines:2,style:TextStyle(fontWeight:FontWeight.bold,fontSize:13)),Spacer(),Text('Rs.${s['price']}',style:TextStyle(color:Colors.green,fontWeight:FontWeight.bold)),Text('Stock: ${s['qty']}',style:TextStyle(fontSize:11))]))); })),
Padding(padding:EdgeInsets.all(12),child:Row(children:[
Expanded(child:TextField(controller:nameCtrl,decoration:InputDecoration(labelText:'Item Name',border:OutlineInputBorder()))),
SizedBox(width:8),
SizedBox(width:90,child:TextField(controller:priceCtrl,keyboardType:TextInputType.number,decoration:InputDecoration(labelText:'Price',border:OutlineInputBorder()))),
SizedBox(width:8),
InkWell(onTap:addItem,child:CircleAvatar(backgroundColor:Colors.green,radius:24,child:Icon(Icons.add,color:Colors.white,size:30)))
])),
Expanded(child:items.isEmpty?Center(child:Text('Mele item-a click panni + pannunga')):ListView.builder(itemCount:items.length,itemBuilder:(_,i)=>ListTile(title:Text(items[i]['name']),trailing:Row(mainAxisSize:MainAxisSize.min,children:[Text('Rs. ${items[i]['price']}'),IconButton(icon:Icon(Icons.delete,color:Colors.red),onPressed:(){setState(()=>items.removeAt(i));showMsg(context,'Item Removed from Bill');})])))),
Container(padding:EdgeInsets.all(16),color:Colors.blue.shade50,child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[
Text('TOTAL: Rs. $total',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
ElevatedButton(onPressed:(){
if(items.isEmpty){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('First + click pannunga')));return;}
setState((){allBills.add({'items':List.from(items),'total':total,'time':DateTime.now().toString().substring(11,16),'by':currentUser});items.clear();});
showMsg(context,'Bill Saved Successfully! Total Rs. $total');
},child:Text('SAVE BILL'))
])))
])));}}

class StockScreen extends StatefulWidget{@override _StockState createState()=>_StockState();}
class _StockState extends State<StockScreen>{
void editItem(int i){
var s=stockItems[i];
final n=TextEditingController(text:s['name']);
final q=TextEditingController(text:s['qty'].toString());
final pr=TextEditingController(text:s['price'].toString());
String cat=s['cat'];
showDialog(context:context,builder:(_)=>AlertDialog(
title:Text('Edit Stock Item'),
content:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,children:[
TextField(controller:n,decoration:InputDecoration(labelText:'Item Name',border:OutlineInputBorder())),
SizedBox(height:10),
TextField(controller:q,keyboardType:TextInputType.number,decoration:InputDecoration(labelText:'Quantity',border:OutlineInputBorder())),
SizedBox(height:10),
TextField(controller:pr,keyboardType:TextInputType.number,decoration:InputDecoration(labelText:'Price',border:OutlineInputBorder())),
SizedBox(height:10),
DropdownButton<String>(value:cat,isExpanded:true,items:['Stationery','Notebooks','Office','Disposal','Services','Others'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v){cat=v!;})
])),
actions:[
TextButton(onPressed:()=>Navigator.pop(context),child:Text('Cancel')),
ElevatedButton(onPressed:(){
setState((){stockItems[i]={'name':n.text.trim(),'qty':int.tryParse(q.text)??s['qty'],'price':double.tryParse(pr.text)??s['price'],'cat':cat};});
Navigator.pop(context);
showMsg(context,'Stock Updated! ${n.text} saved');
},child:Text('SAVE'))
]));}

void addNew(){
final n=TextEditingController();
final q=TextEditingController();
final pr=TextEditingController();
String cat='Stationery';
showDialog(context:context,builder:(_)=>AlertDialog(
title:Text('Add New Stock Item'),
content:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,children:[
TextField(controller:n,decoration:InputDecoration(labelText:'Item Name',border:OutlineInputBorder())),
SizedBox(height:10),
TextField(controller:q,keyboardType:TextInputType.number,decoration:InputDecoration(labelText:'Quantity',border:OutlineInputBorder())),
SizedBox(height:10),
TextField(controller:pr,keyboardType:TextInputType.number,decoration:InputDecoration(labelText:'Price',border:OutlineInputBorder()))
])),
actions:[
TextButton(onPressed:()=>Navigator.pop(context),child:Text('Cancel')),
ElevatedButton(onPressed:(){
if(n.text.isEmpty)return;
setState((){stockItems.add({'name':n.text.trim(),'qty':int.tryParse(q.text)??0,'price':double.tryParse(pr.text)??0.0,'cat':cat});});
Navigator.pop(context);
showMsg(context,'New Item Added! ${n.text}');
},child:Text('ADD'))
]));}

@override
Widget build(BuildContext context){
return Scaffold(
appBar:AppBar(title:Row(children:[vbsLogo(size:36),SizedBox(width:8),Text('Stock - Tap Edit')])),
floatingActionButton:FloatingActionButton(onPressed:addNew,child:Icon(Icons.add),backgroundColor:Colors.green),
body:ListView.builder(itemCount:stockItems.length,itemBuilder:(_,i){
var s=stockItems[i];
return Card(child:ListTile(
leading:CircleAvatar(backgroundColor:s['qty']<20?Colors.red.shade100:Colors.green.shade100,child:Text(s['cat'][0])),
title:Text(s['name']),
subtitle:Text('${s['cat']} | Rs.${s['price']} | Qty: ${s['qty']}'),
trailing:Row(mainAxisSize:MainAxisSize.min,children:[
IconButton(icon:Icon(Icons.edit,color:Colors.blue),onPressed:()=>editItem(i)),
IconButton(icon:Icon(Icons.delete,color:Colors.red),onPressed:(){
showDialog(context:context,builder:(_)=>AlertDialog(title:Text('Delete?'),content:Text('${s['name']} ah delete pannava?'),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:Text('No')),ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Colors.red),onPressed:(){setState(()=>stockItems.removeAt(i));Navigator.pop(context);showMsg(context,'Item Deleted! ${s['name']}');},child:Text('Yes Delete'))]));
})
])
));})));}}

class SalesScreen extends StatelessWidget{
@override
Widget build(BuildContext context){
double tot=allBills.fold(0,(s,e)=>s+(e['total'] as double));
return Scaffold(
appBar:AppBar(title:Row(children:[vbsLogo(size:36),SizedBox(width:8),Text('Today Sales')])),
body:Column(children:[
SizedBox(height:20),
Text('Today Total: Rs. $tot',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),
Text('Bills: ${allBills.length}',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),
SizedBox(height:16),
Expanded(child:allBills.isEmpty?Center(child:Text('Innum bill illa')):ListView.builder(itemCount:allBills.length,itemBuilder:(_,i)=>Card(child:ListTile(title:Text('Bill ${i+1} - Rs. ${allBills[i]['total']}'),subtitle:Text('By: ${allBills[i]['by']} | Time: ${allBills[i]['time']}')))))
]));}}
