import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  _openAlert(context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja realmente excluir?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('A despesa será excluida permanentemente.'),
              ],
            ),
          ),
          actions: [
            TextButton(
                child: const Text('Excluir'),
                onPressed: () {
                  Navigator.of(context).pop();
                  onRemove(id);
                }),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    height: constraints.maxHeight * 0.57,
                    child: const Image(
                      image: AssetImage(
                        'assets/images/waiting.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.2,
                  child: Text(
                    'Vazio!',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            );
          }))
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.all(5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          NumberFormat('R\$ #.00', 'pt-BR').format(tr.value),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    tr.title,
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('dd-MM-y', "pt_BR").format(tr.date),
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => _openAlert(context, tr.id),
                  ),
                ),
              );
            });
  }
}
