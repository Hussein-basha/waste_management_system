import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_app/screens/web_view_screen.dart';
import 'package:waste_app/shared/constants.dart';
import '../controller/app_cubit/cubit.dart';
import '../controller/app_cubit/states.dart';
import '../shared/componentes.dart';

//ignore: must_be_immutable
class Items {
  dynamic image;
  dynamic itemTitle;
  dynamic itemText;
  dynamic url;

  Items({
    @required this.image,
    @required this.itemTitle,
    @required this.itemText,
    @required this.url,
  });
}

//ignore: must_be_immutable
class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WasteAppCubit, WasteAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(item[index], context),
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
            itemCount: item.length,
          ),
        );
      },
    );
  }

  Widget buildCatItem(Items item, context) => Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Row(
          children: [
            Image.asset(
              item.image,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${item.itemTitle}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        '${item.itemText}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultButton(
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(
                              '${item.url}',
                            ),
                          ),
                        );
                      },
                      text: 'To your solution',
                      height: 35,
                      background: defaultColor,
                      isUpperCase: false,
                      radius: 30,
                      width: 200,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
