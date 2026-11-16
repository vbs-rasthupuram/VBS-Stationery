import 'package:flutter/material.dart';

void main() { runApp(const VBSApp()); }

class VBSApp extends StatelessWidget {
  const VBSApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VBS Stationery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = TextEditingController();
  final pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.store, size: 80, color: Colors.deepPurple),
          const SizedBox(height: 10),
          const Text('VBS STATIONERY', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('Rasthupuram, Chennai'),
          const SizedBox(height: 30),
          TextField(controller: user, decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person))),
          const SizedBox(height: 12),
          TextField(controller: pass, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock))),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton(
            onPressed: () {
              if (user.text == 'admin' && pass.text == '1234') {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Dashboard()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong! Username: admin, Password: 1234')));
              }
            },
            child: const Text('LOGIN', style: TextStyle(fontSize: 18)),
          )),
        ]),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VBS - Dashboard'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
      body: GridView.count(crossAxisCount: 2, padding: const EdgeInsets.all(16), children: [
        _card(context, 'New Bill', Icons.receipt, Colors.green, const BillingPage()),
        _card(context, 'Stock', Icons.inventory, Colors.orange, const StockPage()),
        _card(context, 'Today Sales', Icons.currency_rupee, Colors.blue, const SalesPage()),
        _card(context, 'Logout', Icons.logout, Colors.red, const LoginPage()),
      ]),
    );
  }
  Widget _card(BuildContext ctx, String t, IconData i, Color c, Widget p) {
    return Card(child: InkWell(onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => p)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(i, size: 50, color: c), const SizedBox(height: 8), Text(t, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))])));
  }
}

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});
  @override
  State<BillingPage> createState() => _BillingPageState();
}
class _BillingPageState extends State<BillingPage> {
  List<Map<String, dynamic>> items = [];
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  double get total => items.fold(0, (s, e) => s + (e['price'] as double));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Bill')),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(12), child: Row(children: [
          Expanded(child: TextField(controller: nameC, decoration: const InputDecoration(labelText: 'Item Name', border: OutlineInputBorder()))),
          const SizedBox(width: 8),
          SizedBox(width: 90, child: TextField(controller: priceC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder()))),
          IconButton(onPressed: () {
            if (nameC.text.isNotEmpty && priceC.text.isNotEmpty) {
              setState(() { items.add({'name': nameC.text, 'price': double.tryParse(priceC.text) ?? 0}); nameC.clear(); priceC.clear(); });
            }
          }, icon: const Icon(Icons.add_circle, size: 40, color: Colors.green)),
        ])),
        Expanded(child: ListView.builder(itemCount: items.length, itemBuilder: (_, i) => ListTile(title: Text(items[i]['name']), trailing: Text('Rs. ${items[i]['price']}'), leading: CircleAvatar(child: Text('${i + 1}'))))),
        Container(padding: const EdgeInsets.all(16), color: Colors.deepPurple.shade50, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('TOTAL: Rs. $total', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ElevatedButton(onPressed: () {
            if (items.isEmpty) return;
            showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Bill Saved!'), content: Text('Total: Rs. $total\nPayment: Cash / UPI'), actions: [TextButton(onPressed: () { setState(() => items.clear()); Navigator.pop(context); }, child: const Text('OK'))]));
          }, child: const Text('SAVE BILL')),
        ])),
      ]),
    );
  }
}

class StockPage extends StatelessWidget {
  const StockPage({super.key});
  @override
  Widget build(BuildContext context) {
    final stock = [{'n': 'Notebook', 'q': 120}, {'n': 'Pen - Blue', 'q': 250}, {'n': 'Pencil', 'q': 180}, {'n': 'Eraser', 'q': 90}, {'n': 'Scale', 'q': 60}];
    return Scaffold(appBar: AppBar(title: const Text('Stock')), body: ListView.builder(itemCount: stock.length, itemBuilder: (_, i) => ListTile(leading: const Icon(Icons.inventory), title: Text(stock[i]['n'] as String), trailing: Text('Qty: ${stock[i]['q']}'))));
  }
}

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Today Sales')), body: const Center(child: Text('Today Total: Rs. 4,250\nBills: 32', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center)));
  }
}
