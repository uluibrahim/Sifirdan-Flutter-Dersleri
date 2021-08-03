import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/models/message.dart';
import 'package:flutter_lovers/models/user_model.dart';
import 'package:flutter_lovers/viewmodel/user_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class KonusmaPage extends StatefulWidget {
  MyUser currentUser;
  MyUser sohbetEdilenUser;
  KonusmaPage({required this.currentUser, required this.sohbetEdilenUser});

  @override
  _KonusmaPageState createState() => _KonusmaPageState();
}

class _KonusmaPageState extends State<KonusmaPage> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    MyUser _currentUser = widget.currentUser;
    MyUser _sohbetEdilenUser = widget.sohbetEdilenUser;

    return Scaffold(
      appBar: buildAppBar(_sohbetEdilenUser),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _userModel.getMessages(
                  _currentUser.userId!, _sohbetEdilenUser.userId!),
              builder: (context, AsyncSnapshot<List<MessageModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return _mesajBalonu(snapshot.data![index]);
                    },
                    itemCount: snapshot.data!.length,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 9,
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FloatingActionButton(
                    child: Icon(Icons.navigation),
                    onPressed: () {
                      _messageSave(_currentUser, _sohbetEdilenUser, _userModel);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(MyUser _sohbetEdilenUser) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(_sohbetEdilenUser.profilURL.toString()),
          ),
          SizedBox(width: 10),
          Text(_sohbetEdilenUser.userName.toString()),
        ],
      ),
    );
  }

  Future<void> _messageSave(MyUser currentUser, MyUser sohbetEdilenUser,
      UserViewModel userModel) async {
    if (_messageController.text.trim().length > 0) {
      MessageModel _mesaj = MessageModel(
        bendenMi: true,
        kimden: currentUser.userId.toString(),
        kime: sohbetEdilenUser.userId.toString(),
        message: _messageController.text,
      );
      _messageController.clear();
      await userModel.saveMessage(_mesaj);
    }
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 150), curve: Curves.bounceInOut);
  }

  Widget _mesajBalonu(MessageModel anlikMesaj) {
    Color _gidenMesajColor = Colors.blue;
    Color _gelenMesajColor = Colors.teal;
    bool myMessage = anlikMesaj.bendenMi;
    String? _saatDakikaDegeri =
        _saatDakikaFormat(anlikMesaj.date ?? Timestamp(1, 1));

    if (myMessage) {
      return Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    child: Text(
                      anlikMesaj.message,
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: _gidenMesajColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(17),
                      ),
                    ),
                  ),
                ),
                Text(_saatDakikaDegeri.toString()),
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      widget.sohbetEdilenUser.profilURL.toString()),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    child: Text(
                      anlikMesaj.message,
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: _gelenMesajColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(17),
                      ),
                    ),
                  ),
                ),
                Text(_saatDakikaDegeri.toString()),
              ],
            )
          ],
        ),
      );
    }
  }

  String _saatDakikaFormat(Timestamp? date) {
    return DateFormat.Hm().format(date!.toDate());
  }
}
