import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/web_view/web_view_screen.dart';
import '../cubit/app_cubit.dart';
import '../cubit/app_states.dart';

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(url: article['url'],));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover
              )
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: BlocBuilder<AppCubit, AppStates>(
                    builder:(context, state) {
                      return Text(
                        '${article['title']}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      );
  
                    }),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(
                      color: Colors.grey
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ),
  ),
);


Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => buildArticleItem(list[index], context),
      itemCount: 10,
    ) ,
    fallback: (context) => isSearch ? Container() : const Center(child: CircularProgressIndicator())
);


Widget defaultFormfield( {
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChanged,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isClickable = true,
  Color borderColor = Colors.blue, // Default border color
  Color labeledColor = Colors.blue, // Default label color
  TextStyle? textStyle,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClickable,
      obscureText: isPassword,
      validator: validate,
      style: textStyle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: labeledColor),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor), // Color when focused
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor), // Color when enabled
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        prefixIcon: Icon(prefix ,color: Colors.deepOrange),
      ),
    );


void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),);