import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inbox',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.pinch_outlined), onPressed: () {}),
        ],
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         width: 100,
      //         height: 100,
      //         decoration: BoxDecoration(
      //           color: Colors.grey[200],
      //           borderRadius: BorderRadius.circular(50),
      //         ),
      //         child: const Icon(
      //           Icons.chat_bubble_outline,
      //           size: 50,
      //           color: Colors.grey,
      //         ),
      //       ),
      //       const SizedBox(height: 24),
      //       Text(
      //         'No messages yet',
      //         style: Theme.of(
      //           context,
      //         ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      //       ),
      //       const SizedBox(height: 8),
      //       Text(
      //         'Share Pins to start a conversation',
      //         style: Theme.of(
      //           context,
      //         ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Messages',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
                Spacer(),
                Text(
                  'See all  ',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                ),
                Icon(size: 20, Icons.arrow_forward_ios_outlined),
              ],
            ),

            // SizedBox(height: 15),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: Icon(
                  Icons.person_add_alt_1_outlined,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Invite your friends',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              subtitle: Text(
                'Connect to start chatting',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
            ),

            // Row(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(14),
            //         color: Colors.grey.withOpacity(0.3),
            //       ),
            //       child: Icon(Icons.person_add_alt_1_outlined, size: 30),
            //     ),
            //     SizedBox(width: 18),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Invite your friends',
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //         Text('Connect to start chatting'),
            //       ],
            //     ),
            //   ],
            // ),
            ///   SizedBox(height: 15),
            Text(
              'Updates',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
            ),

            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(19.0),
                    child: Image.asset('assets/images/bottleceleb.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      softWrap: true,
                      textAlign: TextAlign.center,
                      'Updates show your activity on your pins and boards and give you tips and tricks to explore. They will be here soon.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
