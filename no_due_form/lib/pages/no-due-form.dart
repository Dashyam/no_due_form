import 'package:flutter/material.dart';

class NoDueFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Due Form Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            ListTile(
              title: Text('H.O.D. Concerned Deptt.'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('Deptt. Library'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('Advisor'),
              trailing: Icon(Icons.close),
              subtitle: Text('Reason for rejection'),
            ),
            ListTile(
              title: Text('Dean Hostels'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('Secy. S.A.F. (i)'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('Secy. S.A.F. (ii)'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('Uni. Extn. Lib.'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('College Library'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('Care Taker'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('Training & Placement Office'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('Mess Accountant'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('Record Keeper'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('Security Officer'),
              trailing: Icon(Icons.check),
            ),
            ListTile(
              title: Text('College Acctt'),
              trailing: Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }
}
