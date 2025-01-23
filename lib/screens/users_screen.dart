import 'package:flutter/material.dart';
import 'package:mobilesoftware/helpers/database_helper.dart';
import 'package:mobilesoftware/models/user.dart';
import 'package:mobilesoftware/styles/styles.dart';
import 'package:intl/intl.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<User> _users = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final dbHelper = DatabaseHelper();
      final List<Map<String, dynamic>> userMaps = await dbHelper.getAllRecords('users');
      _users = userMaps.map((map) => User.fromMap(map)).toList();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch users: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _errorMessage,
            style: Styles.errorTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      )
          : _users.isEmpty
          ? const Center(
        child: Text("No user found!"),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              border: TableBorder.all(color: Styles.borderColor),
              headingTextStyle: Styles.subtitleStyle,
              columns: const [
                DataColumn(label: Text('Sr No')),
                DataColumn(label: Text('User Name')),
                DataColumn(label: Text('User Role')),
                DataColumn(label: Text('Last Login')),
                DataColumn(label: Text('Created On')),
              ],
              rows: List.generate(
                _users.length,
                    (index) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        (index + 1).toString(),
                        style: Styles.bodyTextStyle,
                      ),
                    ),
                    DataCell(
                      Text(
                        _users[index].username,
                        style: Styles.bodyTextStyle,
                      ),
                    ),
                    DataCell(
                      Text(
                        _users[index].role,
                        style: Styles.bodyTextStyle,
                      ),
                    ),
                    DataCell(
                      Text(
                        'N/A',
                        style: Styles.bodyTextStyle,
                      ),
                    ), // Placeholder for last login
                    DataCell(
                      Text(
                        _users[index].createdAt != null
                            ? DateFormat('yyyy-MM-dd HH:mm:ss')
                            .format(_users[index].createdAt!)
                            : 'N/A',
                        style: Styles.bodyTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
