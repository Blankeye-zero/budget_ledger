import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions, this.deleteTx);
  final Function deleteTx;
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    "No Transactions Added Yet",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            },
          )
        : ListView(
            children: transactions
                .map(
                  (tx) => TransactionItem(
                    key: ValueKey(tx.id),
                    /* The ValueKey wraps our own custom identifier over a widget to uniquely identify it
                    for the state confusion that occurs when a widget is deleted 
                    and the suceeding widget takes its state*/
                    transactions: tx,
                    deleteTx: deleteTx,
                  ),
                )
                .toList(),
          );
  }
}
