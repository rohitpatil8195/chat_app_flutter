import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatefulWidget {
  static const String id= 'chat_screen';

  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
final _fireStore=FirebaseFirestore.instance;
late User loggedInUser;
class _ChatScreenState extends State<ChatScreen> {

   final  messageTexController=TextEditingController();
  final _auth=FirebaseAuth.instance;

  late String messageText;
  void getCurrentUser()async{
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    }catch(e){
      print(e);
    }

  }
  
  getMessages()async{
    var db = FirebaseFirestore.instance;
    final messages = await _fireStore.collection('messages').get();
     final data=messages.docs.map((doc) => doc.data());
     print(data);
    // messages.map((v)=>print(v));
  }

  void messagesStream()async{
    await for(var snapshots in _fireStore.collection('messages').snapshots()){
      // for(var message in snapshots.docs){
      //   print(message.data());
      // }
      var data=snapshots.docs.map((msg)=> msg.data());
        print(data);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
               Navigator.pushNamed(context, LoginScreen.id);
                // messagesStream();
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const StreamMessages(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                      setState(() {
                        messageText=value;
                      });
                      },
                      decoration: kMessageTextFieldDecoration,
                    controller: messageTexController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: InkWell(
                      onTap: () {
                        _fireStore.collection('messages').add({
                          'text':messageText,
                          'Sender':loggedInUser.email
                        });
                        messageTexController.clear();
                      },
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
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

class StreamMessages extends StatelessWidget {
  const StreamMessages({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream:_fireStore.collection('messages').snapshots(),
        builder: (context,snapshot){
          List<MessageBubble> msgBubbles=[];
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final massages=snapshot.data?.docs;
          for(var msg in massages!) {
            final msgsText=msg.data()['text'];
            final msgsSender=msg.data()['Sender'];
            final currentUser=loggedInUser.email;
             bool isMee=currentUser==msgsSender;
            final msgBubble=MessageBubble(msgsText,msgsSender,isMee);
            msgBubbles.add(msgBubble);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              children:msgBubbles,
            ),
          );
        }
    );
  }
}


  
class MessageBubble extends StatelessWidget {
   final String text;
   final String sender;
   final bool isMe;
  const MessageBubble(this.text,this.sender,this.isMe, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 14,color: Colors.black54
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius:  BorderRadius.only(
                topLeft: isMe ? const Radius.circular(30) : const Radius.circular(0),
              topRight:  isMe ? const Radius.circular(0) : const Radius.circular(30),
              bottomLeft:const Radius.circular(30),
               bottomRight:const Radius.circular(30),
            ),
            color:isMe? Colors.lightBlueAccent : Colors.grey.shade400,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                text,
                 style:  TextStyle(
                   fontSize: 17,
                   color: isMe? Colors.white : Colors.black,
                 ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
