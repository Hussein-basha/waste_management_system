import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../model/user_model.dart';
import '../shared/icon_broken.dart';

//ignore: must_be_immutable
class AllRatesScreen extends StatefulWidget {
  const AllRatesScreen({Key? key}) : super(key: key);

  @override
  State<AllRatesScreen> createState() => _AllRatesScreenState();
}

class _AllRatesScreenState extends State<AllRatesScreen> {
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
              appBar: AppBar(
                title: const Text(
                  'All Rates',
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                ),
              ),
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
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Container(
                          color: Colors.grey.shade300,
                          height: 1,
                          width: double.infinity,
                        ),
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
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 10,
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
                backgroundImage: NetworkImage(
                  model.image!,
                ),
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
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              if (model.comment != null)
                Text(
                  model.comment!,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                    color: Colors.grey[600],
                  ),
                )
              else
                Text(
                  'No Comment Yet !!',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                    color: Colors.grey[600],
                  ),
                ),
              const SizedBox(
                height: 2,
              ),
              if (model.rate != null)
                Row(
                  children: [
                    Text(
                      '${model.rate}  Stars',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                )
              else
                Text(
                  'No Rate !!',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                    color: Colors.grey[600],
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
