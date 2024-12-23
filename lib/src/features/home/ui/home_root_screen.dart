import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_qfam/src/features/forum/ui/forum_screen.dart';
import 'package:flutter_qfam/src/features/home/bloc/home/home_bloc.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/features/home/ui/home_screen.dart';
import 'package:flutter_qfam/src/features/profile/ui/profile_screen.dart';
import 'package:flutter_qfam/src/features/search/bloc/search/search_bloc.dart';
import 'package:flutter_qfam/src/features/search/ui/search_screen.dart';
import 'package:flutter_qfam/src/helpers/helpers.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_font_weight.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeRootScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeRootScreen({Key? key}) : super(key: key);

  @override
  _HomeRootScreenState createState() => _HomeRootScreenState();
}

class _HomeRootScreenState extends State<HomeRootScreen> {
  late HomeRootBloc bloc;
  late AuthBloc authBloc;

  @override
  void initState() {
    bloc = context.read<HomeRootBloc>();
    authBloc = context.read<AuthBloc>();
    authBloc.add(AuthEventGetCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeRootBloc, HomeRootState>(
          listener: (context, state) {},
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {},
        ),
      ],
      child: WillPopScope(
        onWillPop: null,
        child: BlocBuilder<HomeRootBloc, HomeRootState>(
            bloc: bloc,
            builder: (context, state) {
              return Scaffold(
                body: GestureDetector(
                  onTap: () {
                    Helpers.dismissKeyboard(context);
                  },
                  child: bloc.children[state.index],
                  // child: IndexedStack(
                  //   children: bloc.children,
                  //   index: state.index,
                  // ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: MyColors.primary,
                  unselectedItemColor: Colors.grey,
                  currentIndex: state.index,
                  selectedLabelStyle: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 12.0, fontWeight: MyFontWeight.bold),
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(
                          fontSize: 10.0,
                          fontWeight: MyFontWeight.bold,
                          color: MyColors.grey),
                  iconSize: 20,
                  selectedIconTheme: IconThemeData(size: 24),
                  onTap: (index) {
                    bloc.add(HomeRootEventSelectedIndex(index: index));
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Beranda',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Edukasi',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.forum),
                      label: 'Forum',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profil',
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
