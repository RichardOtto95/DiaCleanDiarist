import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_agent_white_label/app/modules/messages/widgets/conversation.dart';
import 'package:delivery_agent_white_label/app/shared/widgets/empty_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '../../core/models/message_model.dart';
import '../../core/models/time_model.dart';

import '../../shared/utilities.dart';
import '../../shared/widgets/center_load_circular.dart';
import '../../shared/widgets/default_app_bar.dart';
import 'messages_store.dart';
import 'widgets/search_messages.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  MessagesPageState createState() => MessagesPageState();
}

class MessagesPageState extends State<MessagesPage> {
  final MessagesStore store = Modular.get();
  final User? _user = FirebaseAuth.instance.currentUser;
  bool searching = false;
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    store.clearNewMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        store.disposeMessages();
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("chats")
                    .where("agent_id", isEqualTo: _user!.uid)
                    .orderBy("updated_at", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    print("snapshot.error: ${snapshot.error}");
                  if (!snapshot.hasData) {
                    return const CenterLoadCircular();
                  }

                  List<QueryDocumentSnapshot<Map<String, dynamic>>>
                      conversations = snapshot.data!.docs;

                  if (conversations.isEmpty) {
                    return const EmptyState(
                      title: "Nenhuma conversa ainda",
                      asset: "./assets/svg/chat_bubble.svg",
                      changeColor: false,
                    );
                  }

                  return Column(
                    children: [
                      SizedBox(
                          height: viewPaddingTop(context) + wXD(60, context)),
                      SearchMessages(
                        onChanged: (txt) =>
                            store.searchMessages(txt, snapshot.data!),
                      ),
                      Container(
                        width: maxWidth(context),
                        height: wXD(41, context),
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: wXD(33, context), top: wXD(16, context)),
                          child: Text(
                            'Minhas conversas',
                            style: textFamily(
                              context,
                              fontSize: 17,
                              color: getColors(context)
                                  .onBackground
                                  .withOpacity(.7),
                            ),
                          ),
                        ),
                      ),
                      Listener(
                        onPointerDown: (_) =>
                            FocusScope.of(context).requestFocus(FocusNode()),
                        child: Observer(
                          builder: (context) {
                            if (store.searchedChats != null ||
                                store.searchedMessages != null) {
                              if (store.searchedChats!.isEmpty &&
                                  store.searchedMessages!.isEmpty) {
                                return EmptyState(
                                  top: hXD(150, context),
                                  title:
                                      "Nenhuma mensagem ou conversa encontrada",
                                  asset: "./assets/svg/chat_bubble.svg",
                                  changeColor: false,
                                );
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (store.searchedChats!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: wXD(26, context),
                                        top: wXD(10, context),
                                      ),
                                      child: Text(
                                        "Conversas",
                                        style: textFamily(
                                          context,
                                          fontSize: 17,
                                          color: getColors(context)
                                              .onBackground
                                              .withOpacity(.7),
                                        ),
                                      ),
                                    ),
                                  ...store.searchedChats!
                                      .map(
                                        (chat) => Conversation(
                                          conversationData: chat.data()!,
                                        ),
                                      )
                                      .toList(),
                                  if (store.searchedMessages!.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: wXD(26, context),
                                        top: wXD(10, context),
                                      ),
                                      child: Text(
                                        "Mensagens",
                                        style: textFamily(
                                          context,
                                          fontSize: 17,
                                          color: getColors(context)
                                              .onBackground
                                              .withOpacity(.7),
                                        ),
                                      ),
                                    ),
                                  ...store.searchedMessages!.map(
                                    (messageTitle) => MessageSearched(
                                        messageTitle: messageTitle),
                                  ),
                                ],
                              );
                            }
                            if (conversations.isEmpty) {
                              return EmptyState(
                                top: hXD(150, context),
                                title: "Você ainda não possui conversas",
                                asset: "./assets/svg/chat_bubble.svg",
                                changeColor: false,
                              );
                            }
                            return Column(
                              children: conversations
                                  .map(
                                    (conversation) => Conversation(
                                        conversationData: conversation.data()),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: wXD(70, context))
                    ],
                  );
                },
              ),
            ),
            DefaultAppBar(
              'Mensagens',
              onPop: () {
                store.disposeMessages();
                Modular.to.pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

class MessageSearched extends StatelessWidget {
  final SearchMessage messageTitle;
  const MessageSearched({Key? key, required this.messageTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed('/messages/chat', arguments: {
        "receiverId": messageTitle.receiverId,
        "receiverCollection": messageTitle.receiverCollection,
        "messageId": messageTitle.message.id,
      }),
      child: Container(
        width: maxWidth(context),
        padding: EdgeInsets.only(
          left: wXD(19, context),
          right: wXD(10, context),
          top: wXD(10, context),
          bottom: wXD(10, context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  messageTitle.title,
                  style: textFamily(
                    context,
                    fontSize: 15,
                    color: getColors(context).onSurface,
                  ),
                ),
                Text(
                  Time(messageTitle.message.createdAt!.toDate()).chatTime(),
                  style: textFamily(
                    context,
                    fontSize: 11,
                    color: getColors(context).onSurface,
                  ),
                )
              ],
            ),
            SizedBox(height: wXD(3, context)),
            Text(
              messageTitle.message.text!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textFamily(
                context,
                fontSize: 13,
                color: getColors(context).onSurface.withOpacity(.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
