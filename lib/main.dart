import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';
import 'package:news_app/shared/cubit/app_states.dart';
import 'package:news_app/shared/cubit/news_cubit/cubit.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'layout/news_layout.dart';


Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark ;
  const MyApp({ required this.isDark, Key? key}) : super(key: key);
  

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSports()..getScience()),
        BlocProvider(create: (context) => AppCubit()..changeAppMode(isDark)),
      ],
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state){
          var cubit = AppCubit.get(context);
          return MaterialApp(
              theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  progressIndicatorTheme: ProgressIndicatorThemeData(
                    color: Colors.deepOrange
                  ),
                  floatingActionButtonTheme: const FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrangeAccent),
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                    titleSpacing: 20.0,
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      iconTheme: IconThemeData(color: Colors.black),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      )),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      backgroundColor: Colors.white,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.black,
                      type: BottomNavigationBarType.fixed,
                      elevation: 20.0
                  ),
                  textTheme:  const TextTheme(
                      bodyMedium: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Colors.black
                      )
                  )


              ),

              darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor('333739'),
                  primarySwatch: Colors.deepOrange,
                  progressIndicatorTheme: const ProgressIndicatorThemeData(
                    color: Colors.deepOrange
                  ),
                  floatingActionButtonTheme: const FloatingActionButtonThemeData(
                      backgroundColor: Colors.deepOrangeAccent),
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20.0,
                      titleTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      iconTheme: const IconThemeData(color: Colors.white),
                      backgroundColor: HexColor('333739'),
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light,
                      )),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: HexColor('333739'),
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                  ),
                  textTheme:  const TextTheme(
                      bodyMedium: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: Colors.white
                      )
                  )
              ),
              themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: NewsLayout());
        },
      ),
    );
  }
}
