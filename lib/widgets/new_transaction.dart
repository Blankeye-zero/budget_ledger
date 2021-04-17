import 'package:budget_ledger/widgets/adaptiveFlatButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleContoller = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _addtrn() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final titleinput = _titleContoller.text;
    final amountinput = double.parse(_amountController.text);

    if (titleinput.isEmpty || amountinput <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      titleinput,
      amountinput,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                //onChanged: (val) {
                // titleInput = val;
                //},
                controller: _titleContoller,
                onSubmitted: (_) => _addtrn(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                //onChanged: (val) => amountInput = val,
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addtrn(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen'
                          : 'Picked Date: ' +
                              DateFormat().add_yMMMd().format(_selectedDate)),
                    ),
                    AdaptiveFlatButton("Choose Date", _presentDatePicker),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Text('Add Transaction'),
                onPressed: _addtrn,
              )
            ],
          ),
        ),
      ),
    );
  }
}
