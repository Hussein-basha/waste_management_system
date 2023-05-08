// ignore_for_file: avoid_print
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../model/user_model.dart';
import 'chat_details_screen.dart';

//ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        WasteAppCubit.get(context).getUsersData();
        return BlocConsumer<WasteAppCubit, WasteAppState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = WasteAppCubit.get(context);
            return Scaffold(
              body: cubit.usersData.isEmpty
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return buildChatItem(
                          context: context,
                          model: cubit.usersData[index],
                        );
                      },
                      separatorBuilder: (context, i) => Container(
                        height: 5,
                      ),
                      itemCount: cubit.usersData.length,
                    ),
            );
          },
        );
      },
    );
  }

  Widget buildChatItem(
      {required UserModel model, required BuildContext context}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailsScreen(
              receiverUserDataModel: model,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 5,
          top: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CircleAvatar(
                  radius: 21.5,
                  backgroundColor: Colors.black.withOpacity(
                    0.5,
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(model.image!),
                ),
              ],
            ),
            const SizedBox(
              width: 13,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 2.5,),
                Text(
                  model.name!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                // if user change userName , it will be shown but if shown the value that store on postData there will be difference
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "last message",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
