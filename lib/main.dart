import 'package:flutter/material.dart';

void main() => runApp(VBSApp());

// ================= DATA =================
List<Map<String, dynamic>> allBills = [];
List<Map<String, dynamic>> allCustomers = [
  {'name': 'R. Karthik', 'phone': '9876543210', 'totalBills': 5, 'totalSpent': 1240.0, 'lastVisit': '12-11-2026'},
  {'name': 'S. Meena', 'phone': '8765432109', 'totalBills': 3, 'totalSpent': 450.0, 'lastVisit': '10-11-2026'},
];
List<Map<String, dynamic>> stockItems = [
  {'name': 'Blue Pen', 'qty': 100, 'price': 5.0},
  {'name': 'Black Pen', 'qty': 50, 'price': 5.0},
  {'name': 'Red Pen', 'qty': 3, 'price': 5.0},
  {'name': 'Pencil HB', 'qty': 100, 'price': 5.0},
  {'name': 'Eraser', 'qty': 2, 'price': 5.0},
  {'name': 'Sharpener', 'qty': 50, 'price': 5.0},
  {'name': 'Scale 30cm', 'qty': 50, 'price': 10.0},
  {'name': 'Geometry Box', 'qty': 20, 'price': 55.0},
  {'name': 'Exam Pad', 'qty': 20, 'price': 35.0},
  {'name': 'Note Book', 'qty': 50, 'price': 40.0},
];

Map<String, dynamic>? selectedCustomer;
String cleanPhone(String p) {
  String c = p.replaceAll(RegExp(r'\D'), '');
  if (c.length > 10) c = c.substring(c.length - 10);
  return c;
}
String todayStr() => '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

class VBSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VBS Stationery',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: LoginScreen(),
    );
  }
}

// ================= LOGIN =================
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController pinCtrl = TextEditingController();
  void login() {
    if (pinCtrl.text == '1234') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong PIN bro! Try 1234')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0284C7),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.store, size: 60, color: Color(0xFF0284C7)),
                SizedBox(height: 8),
                Text('VBS STATIONERY', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Rasathupuram', style: TextStyle(color: Colors.grey)),
                SizedBox(height: 20),
                TextField(controller: pinCtrl, keyboardType: TextInputType.number, obscureText: true, maxLength: 4, textAlign: TextAlign.center, style: TextStyle(fontSize: 24, letterSpacing: 10), decoration: InputDecoration(labelText: 'Enter PIN', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                SizedBox(height: 16),
                SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0284C7)), onPressed: login, child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 18)))),
                SizedBox(height: 8),
                Text('Demo PIN: 1234', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= HOME =================
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VBS STATIONERY'),
        backgroundColor: Color(0xFF0284C7), foregroundColor: Colors.white,
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen())) )],
      ),
      body: [_DashboardTab(onNewBill: () => setState(() => _index = 2), onSearchCustomer: () => setState(() => _index = 1)), _CustomerTab(onSelect: (c) => setState(() { selectedCustomer = c; _index = 2; })), _BillingTab(), _StockTab(), _BillsTab()][_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index, onTap: (i) => setState(() => _index = i), type: BottomNavigationBarType.fixed, selectedItemColor: Color(0xFF0284C7),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person_search), label: 'Customers'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Billing'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Stock'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Bills'),
        ],
      ),
    );
  }
}

// ================= DASHBOARD =================
class _DashboardTab extends StatelessWidget {
  final VoidCallback onNewBill;
  final VoidCallback onSearchCustomer;
  _DashboardTab({required this.onNewBill, required this.onSearchCustomer});
  @override
  Widget build(BuildContext context) {
    double todaySales = allBills.fold(0, (s, e) => s + (e['total'] as double));
    var lowStock = stockItems.where((s) => s['qty'] < 10).toList();
    return SingleChildScrollView(
      padding: EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Vanakkam! 🙏', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text('Today: ${todayStr()}', style: TextStyle(color: Colors.grey)),
        SizedBox(height: 12),
        Row(children: [
          Expanded(child: _dashCard('Today Sales', 'Rs.${todaySales.toStringAsFixed(0)}', Colors.green, Icons.currency_rupee)),
          SizedBox(width: 10),
          Expanded(child: _dashCard('Today Bills', '${allBills.length}', Colors.blue, Icons.receipt)),
        ]),
        SizedBox(height: 10),
        Row(children: [
          Expanded(child: _dashCard('Total Customers', '${allCustomers.length}', Colors.orange, Icons.people)),
          SizedBox(width: 10),
          Expanded(child: _dashCard('Total Items', '${stockItems.length}', Colors.purple, Icons.inventory)),
        ]),
        SizedBox(height: 14),
        Row(children: [
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(vertical: 14)), onPressed: onNewBill, child: Text('+ New Bill', style: TextStyle(color: Colors.white)))),
          SizedBox(width: 10),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0284C7), padding: EdgeInsets.symmetric(vertical: 14)), onPressed: onSearchCustomer, child: Text('Search Customer', style: TextStyle(color: Colors.white)))),
        ]),
        SizedBox(height: 14),
        Text('⚠️ Low Stock Alert', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
        SizedBox(height: 6),
        if (lowStock.isEmpty) Text('All stock OK ✅', style: TextStyle(color: Colors.green)),
        ...lowStock.map((s) => Card(color: Colors.red.shade50, child: ListTile(leading: Icon(Icons.warning, color: Colors.red), title: Text(s['name']), trailing: Text('${s['qty']} left', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))))).toList(),
        SizedBox(height: 14),
        Text('Recent Bills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        if (allBills.isEmpty) Card(child: Padding(padding: EdgeInsets.all(14), child: Text('No bills yet today. + New Bill click pannunga!'))),
        ...allBills.reversed.take(5).map((b) => Card(child: ListTile(title: Text('${b['billNo']} - ${b['name']}'), subtitle: Text('${b['date']} • ${(b['items'] as List).map((e) => '${e['name']} x ${e['qty']}').join(', ')}'), trailing: Text('Rs.${b['total']}', style: TextStyle(fontWeight: FontWeight.bold))))).toList(),
      ]),
    );
  }
  Widget _dashCard(String title, String value, Color color, IconData icon) {
    return Container(padding: EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: color), SizedBox(height: 6), Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text(title, style: TextStyle(color: Colors.grey, fontSize: 12))]));
  }
}

// ================= CUSTOMERS =================
class _CustomerTab extends StatefulWidget {
  final Function(Map<String, dynamic>) onSelect;
  _CustomerTab({required this.onSelect});
  @override
  State<_CustomerTab> createState() => __CustomerTabState();
}
class __CustomerTabState extends State<_CustomerTab> {
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController searchAllCtrl = TextEditingController();
  Map<String, dynamic>? found;
  bool searched = false;
  void search() {
    String p = cleanPhone(phoneCtrl.text);
    setState(() { searched = true; try { found = allCustomers.firstWhere((c) => c['phone'] == p); } catch (_) { found = null; } });
  }
  void addCustomer() {
    if (nameCtrl.text.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name kudunga bro'))); return; }
    String p = cleanPhone(phoneCtrl.text);
    setState(() { allCustomers.add({'name': nameCtrl.text, 'phone': p, 'totalBills': 0, 'totalSpent': 0.0, 'lastVisit': 'Today'}); found = allCustomers.last; });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Customer Added: ${nameCtrl.text}')));
  }
  List<dynamic> lastItems(String phone) {
    final bills = allBills.where((b) => b['phone'] == phone).toList();
    if (bills.isEmpty && phone == '9876543210') return [{'name': 'Blue Pen', 'qty': 2, 'price': 5.0}, {'name': 'Pencil HB', 'qty': 2, 'price': 5.0}, {'name': 'Geometry Box', 'qty': 1, 'price': 55.0}, {'name': 'Eraser', 'qty': 1, 'price': 5.0}];
    if (bills.isEmpty) return [];
    return bills.last['items'] ?? [];
  }
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtered = allCustomers.where((c) => c['name'].toLowerCase().contains(searchAllCtrl.text.toLowerCase()) || c['phone'].contains(searchAllCtrl.text)).toList();
    return SingleChildScrollView(padding: EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Find Repeat Customer', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'Phone Number', hintText: '98765 43210', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      SizedBox(height: 8),
      SizedBox(width: double.infinity, child: ElevatedButton(onPressed: search, child: Text('Search'))),
      SizedBox(height: 12),
      if (searched && found != null) _customerCard(found!),
      if (searched && found == null) Card(child: Padding(padding: EdgeInsets.all(14), child: Column(children: [Text('Customer not found - New Customer?', style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 8), TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Enter Name', border: OutlineInputBorder())), SizedBox(height: 8), SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: addCustomer, child: Text('+ Add New Customer', style: TextStyle(color: Colors.white))))]))),
      SizedBox(height: 16),
      TextField(controller: searchAllCtrl, onChanged: (_) => setState(() {}), decoration: InputDecoration(hintText: 'Search all customers by name / phone', prefixIcon: Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
      SizedBox(height: 10),
      Text('All Customers (${filtered.length})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      ...filtered.map((c) => Card(child: ListTile(leading: CircleAvatar(child: Text(c['name'][0])), title: Text(c['name']), subtitle: Text('+91 ${c['phone']} • Bills: ${c['totalBills']} • Rs.${c['totalSpent']}'), trailing: Icon(Icons.arrow_forward), onTap: () { setState(() { found = c; searched = true; phoneCtrl.text = c['phone']; }); }))).toList(),
    ]));
  }
  Widget _customerCard(Map<String, dynamic> c) {
    final items = lastItems(c['phone']);
    double lastTotal = items.fold(0, (s, e) => s + (e['price'] * e['qty']));
    return Card(color: Color(0xFFF0F9FF), child: Padding(padding: EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [CircleAvatar(radius: 24, child: Text(c['name'][0], style: TextStyle(fontSize: 20))), SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(c['name'], style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)), Text('+91 ${c['phone']}')])]),
      Divider(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(children: [Text('Last Visit', style: TextStyle(color: Colors.grey, fontSize: 12)), Text('${c['lastVisit'] ?? 'Today'}', style: TextStyle(fontWeight: FontWeight.bold))]), Column(children: [Text('Total Bills', style: TextStyle(color: Colors.grey, fontSize: 12)), Text('${c['totalBills']}', style: TextStyle(fontWeight: FontWeight.bold))]), Column(children: [Text('Total Spent', style: TextStyle(color: Colors.grey, fontSize: 12)), Text('Rs.${c['totalSpent']}', style: TextStyle(fontWeight: FontWeight.bold))])]),
      Divider(),
      Text('Last Purchased Items', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      SizedBox(height: 6),
      if (items.isEmpty) Text('No previous purchase', style: TextStyle(color: Colors.grey)),
      ...items.map((it) => Padding(padding: EdgeInsets.symmetric(vertical: 3), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('${it['name']} x ${it['qty']}'), Text('Rs.${(it['price'] * it['qty']).toStringAsFixed(0)}')]))).toList(),
      SizedBox(height: 8),
      Container(width: double.infinity, padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Color(0xFFD6EAF8), borderRadius: BorderRadius.circular(8)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Last Bill Total'), Text('Rs.${lastTotal.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold))])),
      SizedBox(height: 10),
      SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () => widget.onSelect(c), child: Text('Select Customer & Start Billing →', style: TextStyle(color: Colors.white)))),
    ])));
  }
}

// ================= BILLING =================
class _BillingTab extends StatefulWidget { @override State<_BillingTab> createState() => __BillingTabState(); }
class __BillingTabState extends State<_BillingTab> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  List<Map<String, dynamic>> cart = [];
  double get total => cart.fold(0, (s, e) => s + (e['price'] * e['qty']));
  @override
  void initState() { super.initState(); if (selectedCustomer != null) { nameCtrl.text = selectedCustomer!['name']; phoneCtrl.text = selectedCustomer!['phone']; } }
  @override
  void didUpdateWidget(covariant _BillingTab oldWidget) { super.didUpdateWidget(oldWidget); if (selectedCustomer != null) { nameCtrl.text = selectedCustomer!['name']; phoneCtrl.text = selectedCustomer!['phone']; } }
  void addToCart(Map<String, dynamic> item) {
    setState(() { var ex; try { ex = cart.firstWhere((c) => c['name'] == item['name']); } catch (_) { ex = null; } if (ex != null) ex['qty'] += 1; else cart.add({'name': item['name'], 'qty': 1, 'price': item['price']}); });
  }
  void saveBill() {
    if (nameCtrl.text.isEmpty || cart.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name + Item kudunga bro'))); return; }
    String phone = cleanPhone(phoneCtrl.text);
    String today = todayStr();
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text('VBS STATIONERY'),
      content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Customer: ${nameCtrl.text}'), Text('Phone: +91 $phone'), Divider(), ...cart.map((c) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('${c['name']} x ${c['qty']}'), Text('Rs.${(c['price'] * c['qty']).toStringAsFixed(0)}')])), Divider(), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('TOTAL', style: TextStyle(fontWeight: FontWeight.bold)), Text('Rs.${total.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold))]), SizedBox(height: 8), Text('Thank You Visit Again!', style: TextStyle(color: Colors.grey))]),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')), ElevatedButton(onPressed: () {
        Navigator.pop(context);
        setState(() {
          allBills.add({'name': nameCtrl.text, 'phone': phone, 'items': List.from(cart), 'total': total, 'date': today, 'billNo': 'Bill #${(allBills.length + 1).toString().padLeft(3, '0')}'});
          var ex; try { ex = allCustomers.firstWhere((c) => c['phone'] == phone); } catch (_) { ex = null; }
          if (ex == null && phone.isNotEmpty) allCustomers.add({'name': nameCtrl.text, 'phone': phone, 'totalBills': 1, 'totalSpent': total, 'lastVisit': today});
          else if (ex != null) { ex['totalBills'] += 1; ex['totalSpent'] += total; ex['lastVisit'] = today; }
          for (var c in cart) { var s = stockItems.firstWhere((e) => e['name'] == c['name']); s['qty'] -= c['qty'] as int; }
          cart.clear(); selectedCustomer = null; nameCtrl.clear(); phoneCtrl.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bill Saved! ✅')));
      }, child: Text('Print / Save'))],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: EdgeInsets.all(14), child: Column(children: [
      if (selectedCustomer != null) Container(width: double.infinity, padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)), child: Text('Selected: ${selectedCustomer!['name']} • +91 ${selectedCustomer!['phone']}', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
      SizedBox(height: 8),
      TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Customer Name', border: OutlineInputBorder())),
      SizedBox(height: 8),
      TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'Phone Number', hintText: '98765 43210', border: OutlineInputBorder(), suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () { var f; try { f = allCustomers.firstWhere((c) => c['phone'] == cleanPhone(phoneCtrl.text)); } catch (_) { f = null; } if (f != null) setState(() => nameCtrl.text = f['name']); else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New Customer'))); }))),
      SizedBox(height: 12),
      Text('Select Items - Tap to Add', style: TextStyle(fontWeight: FontWeight.bold)),
      ...stockItems.map((item) => Card(child: ListTile(title: Text(item['name']), subtitle: Text('Rs.${item['price']} • Stock: ${item['qty']}'), trailing: ElevatedButton(onPressed: () => addToCart(item), child: Text('Add'))))).toList(),
      Divider(),
      Text('Bill Items', style: TextStyle(fontWeight: FontWeight.bold)),
      ...cart.map((c) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Text('${c['name']}')), Row(children: [IconButton(icon: Icon(Icons.remove_circle, color: Colors.red), onPressed: () => setState(() { if (c['qty'] > 1) c['qty']--; else cart.remove(c); })), Text('${c['qty']}'), IconButton(icon: Icon(Icons.add_circle, color: Colors.green), onPressed: () => setState(() => c['qty']++))]), Text('Rs.${(c['price'] * c['qty']).toStringAsFixed(0)}')])).toList(),
      SizedBox(height: 10),
      Text('Total: Rs.${total.toStringAsFixed(0)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: saveBill, child: Text('Save Bill & Print 🖨️', style: TextStyle(color: Colors.white, fontSize: 17)))),
    ]));
  }
}

// ================= STOCK - FULLY FIXED =================
class _StockTab extends StatefulWidget { @override State<_StockTab> createState() => __StockTabState(); }
class __StockTabState extends State<_StockTab> {
  TextEditingController searchCtrl = TextEditingController();
  void showAddDialog() {
    TextEditingController nameC = TextEditingController();
    TextEditingController priceC = TextEditingController();
    TextEditingController qtyC = TextEditingController();
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text('Add New Item'),
      content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: nameC, textCapitalization: TextCapitalization.words, decoration: InputDecoration(labelText: 'Item Name *', hintText: 'Ex: Gel Pen', border: OutlineInputBorder())),
        SizedBox(height: 10),
        TextField(controller: priceC, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Price *', hintText: 'Ex: 10', prefixText: 'Rs. ', border: OutlineInputBorder())),
        SizedBox(height: 10),
        TextField(controller: qtyC, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Opening Qty *', hintText: 'Ex: 50', border: OutlineInputBorder())),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel')),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: () {
          String name = nameC.text.trim();
          double? price = double.tryParse(priceC.text);
          int? qty = int.tryParse(qtyC.text);
          if (name.isEmpty || price == null || qty == null) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name, Price, Qty ellam correct-a kudunga bro'))); return; }
          if (stockItems.any((e) => e['name'].toLowerCase() == name.toLowerCase())) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Indha item already irukku bro!'))); return; }
          setState(() { stockItems.add({'name': name, 'qty': qty, 'price': price}); });
          Navigator.pop(ctx);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name Added ✅')));
        }, child: Text('Add Item', style: TextStyle(color: Colors.white))),
      ],
    ));
  }
  void showEditDialog(Map<String, dynamic> item) {
    TextEditingController nameC = TextEditingController(text: item['name']);
    TextEditingController priceC = TextEditingController(text: item['price'].toString());
    TextEditingController qtyC = TextEditingController(text: item['qty'].toString());
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text('Edit Item - ${item['name']}'),
      content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: nameC, decoration: InputDecoration(labelText: 'Item Name', border: OutlineInputBorder())),
        SizedBox(height: 10),
        TextField(controller: priceC, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Price', prefixText: 'Rs. ', border: OutlineInputBorder())),
        SizedBox(height: 10),
        TextField(controller: qtyC, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Stock Qty', border: OutlineInputBorder())),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel')),
        ElevatedButton(onPressed: () {
          String name = nameC.text.trim();
          double? price = double.tryParse(priceC.text);
          int? qty = int.tryParse(qtyC.text);
          if (name.isEmpty || price == null || qty == null) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Correct values kudunga'))); return; }
          setState(() { item['name'] = name; item['price'] = price; item['qty'] = qty; });
          Navigator.pop(ctx);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated ✅')));
        }, child: Text('Save Changes')),
      ],
    ));
  }
  void confirmDelete(Map<String, dynamic> item) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text('Delete ${item['name']}?'),
      content: Text('Indha item-a delete pannalama bro?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel')),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), onPressed: () { setState(() { stockItems.remove(item); }); Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted'))); }, child: Text('Delete', style: TextStyle(color: Colors.white))),
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    String q = searchCtrl.text.toLowerCase().trim();
    var filtered = q.isEmpty ? stockItems : stockItems.where((s) => s['name'].toLowerCase().contains(q)).toList();
    return Column(children: [
      Padding(padding: EdgeInsets.all(12), child: Row(children: [
        Expanded(child: TextField(controller: searchCtrl, onChanged: (_) => setState(() {}), decoration: InputDecoration(hintText: 'Search item... Pen, Book...', prefixIcon: Icon(Icons.search), suffixIcon: q.isNotEmpty ? IconButton(icon: Icon(Icons.clear), onPressed: () => setState(() => searchCtrl.clear())) : null, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
        SizedBox(width: 8),
        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14)), onPressed: showAddDialog, child: Text('+ Add', style: TextStyle(color: Colors.white))),
      ])),
      Padding(padding: EdgeInsets.symmetric(horizontal: 14), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Inventory (${filtered.length} items)', style: TextStyle(fontWeight: FontWeight.bold)), Text('Total Stock: ${stockItems.fold(0, (s, e) => s + (e['qty'] as int))}', style: TextStyle(color: Colors.grey))])),
      SizedBox(height: 6),
      Expanded(child: filtered.isEmpty
        ? Center(child: Text('No item found for "$q"\n+ Add button click panni add pannunga', textAlign: TextAlign.center))
        : ListView.builder(itemCount: filtered.length, itemBuilder: (c, i) {
          final s = filtered[i];
          bool low = (s['qty'] as int) < 10;
          return Card(color: low ? Colors.red.shade50 : Colors.white, elevation: 1, margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: ListTile(
            leading: CircleAvatar(backgroundColor: low ? Colors.red : Color(0xFF0284C7), child: Icon(Icons.inventory_2, color: Colors.white, size: 20)),
            title: Row(children: [Expanded(child: Text(s['name'], style: TextStyle(fontWeight: FontWeight.bold))), if (low) Container(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)), child: Text('LOW STOCK', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))]),
            subtitle: Text('Rs.${s['price']} • Stock: ${s['qty']}'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(icon: Icon(Icons.remove_circle, color: Colors.orange), onPressed: () => setState(() { if (s['qty'] > 0) s['qty']--; })),
              Text('${s['qty']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: low ? Colors.red : Colors.green)),
              IconButton(icon: Icon(Icons.add_circle, color: Colors.green), onPressed: () => setState(() { s['qty'] += 1; })),
              IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () => showEditDialog(s)),
              IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => confirmDelete(s)),
            ]),
          ));
        })),
      ),
      Padding(padding: EdgeInsets.all(12), child: SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green), onPressed: showAddDialog, child: Text('+ Add New Item', style: TextStyle(color: Colors.white, fontSize: 16))))),
    ]);
  }
}

// ================= BILLS =================
class _BillsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (allBills.isEmpty) return Center(child: Text('No bills yet'));
    return ListView.builder(itemCount: allBills.length, itemBuilder: (c, i) {
      final b = allBills[i];
      return Card(child: ListTile(title: Text('${b['billNo']} - ${b['name']}'), subtitle: Text('+91 ${b['phone']} • ${b['date']}\nItems: ${(b['items'] as List).map((e) => '${e['name']} x ${e['qty']}').join(', ')}'), isThreeLine: true, trailing: Text('Rs.${b['total']}', style: TextStyle(fontWeight: FontWeight.bold))));
    });
  }
}
