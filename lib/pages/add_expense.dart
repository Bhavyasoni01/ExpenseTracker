import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/transaction_model.dart';
import 'package:notes_app/services/hive_services.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController  = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String?  selectedPath;

  Future<void> _dateSelect(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  List<Map<String, String>> brandItems = [
  {'value': 'amazon', 'label': 'Amazon', 'logoPath': 'assets/logos/amazon.png'},
  {'value': 'uber', 'label': 'Uber', 'logoPath': 'assets/logos/uber.png'},
];


  final List<Map<String, String>> logoOptions = [
    {'label': 'Amazon', 'path': 'assets/logo/amazon.png'},
    {'label': 'Uber', 'path': 'assets/logo/uber.png'},
    {'label': 'Swiggy', 'path': 'assets/logo/swiggy.png'},
    {'label': 'Zomato', 'path': 'assets/logo/zomato.png'},
    {'label': 'Flipkart', 'path': 'assets/logo/flipkart.png'},
    {'label': 'Myntra', 'path': 'assets/logo/myntra.png'},
    {'label': 'Ola', 'path': 'assets/logo/ola.png'},
    {'label': 'Shopping', 'path': 'assets/logo/shopping.png'},
    {'label': 'UPI', 'path': 'assets/logo/upi.png'},
    {'label': 'Credit Card', 'path': 'assets/logo/creditcard.png'},
    {'label': 'Cash Withdrawal', 'path': 'assets/logo/cashwithdrawal.png'},

  ];


  Future<void> _saveTransaction() async{

    if(amountController.text.isEmpty || descriptionController.text.isEmpty || selectedDate == null || selectedPath == null){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Fill all fields')));
       return;
    }

    try {
      double amount = double.parse(amountController.text);

      String category = logoOptions
      .firstWhere((logo)=> logo['path']== selectedPath) ['label']?? 'other';

      TransactionModel transaction = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      amount: amount, 
      description: descriptionController.text, 
      date: selectedDate!, 
      isExpense: true, 
      category: category, 
      logoPath: selectedPath!
      );

      await HiveService.addTransaction(transaction);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Expense added successfully!!')));

      Navigator.pop(context);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: Please enter a valid amount')));
      
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Add Expense',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: IconButton(
                    icon: Icon(CupertinoIcons.back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Amount',
                      style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                    ),

                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 08),
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(
                            Icons.currency_rupee_sharp,
                            size: 22,
                          ),
                          hintText: 'Enter Amount',
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      'Enter Description',
                      style: TextStyle(fontSize: 17, color: Colors.grey[900]),
                    ),

                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 08),
                      child: TextField(
                        keyboardType: TextInputType.name,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.description, size: 22),
                          hintText: 'Enter Description',
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    Text(
                      'Select Date',
                      style: TextStyle(fontSize: 17, color: Colors.grey[900]),
                    ),

                    SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextField(
                        controller: dateController,
                        readOnly: true,
                        onTap: () => _dateSelect(context),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixIcon: Icon(Icons.calendar_today, size: 22),
                          hintText: 'Select Date',
                          suffixIcon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Select Logo',
                      style: TextStyle(fontSize: 17, color: Colors.grey[900]),
                    ),

                    SizedBox(height: 15,),


                    Padding(padding: EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedPath,
                          hint: Row(
                            children: [
                              Icon(Icons.image, size: 22, color: Colors.grey[600]),
                                SizedBox(width: 12),
                                Text('Select Logo')
                            ],
                          ),
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down,
                          color: Colors.grey[500]),
                        items: logoOptions.map((logo){
                          return DropdownMenuItem(
                            value: logo['path'],
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Image.asset(logo['path']!,
                                  width: 22,
                                  height: 22,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.image, size: 22 , color: Colors.grey[500],);
                                  },
                                  ),
                                ),
                                SizedBox(width: 12,),
                                Text(logo['label']!)
                              ],
                            ));
                        }
                        ).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            selectedPath = newValue;
                          });
                        }),),
                    ),
                    ),

                    SizedBox(height: 50,),


                    Center(
                      child: GestureDetector(
                        onTap: _saveTransaction,
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: Colors.blue[800]
                          ),
                          child: Center(child: Text('Save',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                          ),)),
                        ),
                      ),
                    )

                   



                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
