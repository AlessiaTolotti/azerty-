// TODO: define your model
class Contact {   }

class ContactListScreen extends State<...> {
  // TODO init with dummy data
  final List<Contact> contacts = [ ... ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    // TODO ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: ListView( ... ),
    );
  }
}
