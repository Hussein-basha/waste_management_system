// ignore_for_file: avoid_print
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_app/shared/constants.dart';
import '../controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';
import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  TextEditingController messageController = TextEditingController();
  late UserModel receiverUserDataModel;

  ChatDetailsScreen({super.key, required this.receiverUserDataModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        WasteAppCubit.get(context)
            .getMessages(messageReceiverID: receiverUserDataModel.uId!);
        return BlocConsumer<WasteAppCubit, WasteAppState>(
          listener: (context, state) {
            if (state is SendMessageSuccessState) {
              messageController.text = '';
            }
          },
          builder: (context, state) {
            final cubit = WasteAppCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 5,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: NetworkImage(
                        receiverUserDataModel.image!,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      receiverUserDataModel.name!,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    state is GetMessageLoadingState
                        ? const Center(child: CupertinoActivityIndicator())
                        : Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, i) {
                                return cubit.messages[i].messageSenderID ==
                                        cubit.userModel!.uId
                                    ? buildMyMessageItem(cubit.messages[i])
                                    : buildReceiverMessageItem(
                                        cubit.messages[i]);
                              },
                              separatorBuilder: (context, i) => const SizedBox(
                                height: 12,
                              ),
                              itemCount: cubit.messages.length,
                            ),
                          ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: TextFormField(
                        controller: messageController,
                        onFieldSubmitted: (val) {
                          cubit.sendMessage(
                            message: messageController.text,
                            messageReceiverID: receiverUserDataModel.uId!,
                          );
                        },
                        decoration: InputDecoration(
                          hintText: "type your message here",
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.sendMessage(
                                message: messageController.text,
                                messageReceiverID: receiverUserDataModel.uId!,
                              );
                            },
                            color: defaultColor,
                            icon: const Icon(
                              Icons.send,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMyMessageItem(MessageModel model) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "",
          ),
        ),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              padding: const EdgeInsets.all(
                10,
              ),
              decoration: BoxDecoration(
                color: defaultColor.withOpacity(
                  0.5,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                    0,
                  ),
                  bottomLeft: Radius.circular(
                    10,
                  ),
                  topLeft: Radius.circular(
                    10,
                  ),
                  bottomRight: Radius.circular(
                    10,
                  ),
                ),
              ),
              child: Text(
                model.message!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildReceiverMessageItem(MessageModel model) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              padding: const EdgeInsets.all(
                10,
              ),
              decoration: BoxDecoration(
                color: defaultColor.withOpacity(
                  0.1,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                    10,
                  ),
                  bottomLeft: Radius.circular(
                    10,
                  ),
                  topLeft: Radius.circular(
                    0,
                  ),
                  bottomRight: Radius.circular(
                    10,
                  ),
                ),
              ),
              child: Text(
                model.message!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const Expanded(
          child: Text(
            "",
          ),
        ),
      ],
    );
  }
}
