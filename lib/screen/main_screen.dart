import 'package:flutter/material.dart';
import '../model/model.dart';
import '../services/data.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late Future<MainModel?> _mainModel;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _mainModel = getMainModel();
  }

  void toggle() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void _showUserInfoBottomSheet(InfoModel user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (context) {
        return FractionallySizedBox(
          widthFactor: 1.0,
          heightFactor: 0.5,
          child: StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                const  Text(
                    'Student Detailed Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  Table(
                    columnWidths: {
                      0: FixedColumnWidth(120),
                    },
                    children: [
                      _buildTableRow('Name', '${user.name} ${user.surName}'),
                      _buildTableRow('ID', '${user.id}'),
                      _buildTableRow('Age', '${user.age}'),
                      _buildTableRow('Username', '${user.username}'),
                      _buildTableRow(
                         'Password', 
                        showPassword ? user.password : '******',
                        showPassword ? null : toggle,
                        showPassword ? 'Hide' : 'Show',
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  TableRow _buildTableRow(String label, String value, [Function()? onTap, String? actionLabel]) {
    return TableRow(
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(label),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Expanded(child: Text(value)),
                if (actionLabel != null)
                  TextButton(
                    onPressed: onTap,
                    child: Text(actionLabel),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MainModel?>(
        future: _mainModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else if (!snapshot.hasData ||
              snapshot.data!.users == null ||
              snapshot.data!.users!.isEmpty) {
            return Center(child: Text('No students available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.users!.length,
              itemBuilder: (context, index) {
                InfoModel user = snapshot.data!.users![index];
                return ListTile(
                  title: Text('${user.name} ${user.surName}'),
                  onTap: () => _showUserInfoBottomSheet(user),
                );
              },
            );
          }
        },
      ),
    );
  }
}
