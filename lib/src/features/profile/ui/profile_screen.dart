import 'package:flutter_qfam/src/commons/spaces.dart';
import 'package:flutter_qfam/src/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_qfam/src/features/auth/ui/login_screen.dart';
import 'package:flutter_qfam/src/features/home/bloc/home/home_bloc.dart';
import 'package:flutter_qfam/src/features/home/bloc/home_root/home_root_bloc.dart';
import 'package:flutter_qfam/src/features/profile/bloc/profile/profile_bloc.dart';
import 'package:flutter_qfam/src/features/search/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qfam/src/styles/my_colors.dart';
import 'package:flutter_qfam/src/styles/my_font_weight.dart';
import 'package:flutter_qfam/src/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthBloc authBloc;
  late HomeRootBloc homeRootBloc;
  ProfileBloc bloc = ProfileBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
    homeRootBloc = context.read<HomeRootBloc>();
  }

  @override
  void dispose() {
    // authBloc.close();
    // homeRootBloc.close();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => ProfileBloc(),
      child: Scaffold(
        body: BlocConsumer<HomeRootBloc, HomeRootState>(
          bloc: homeRootBloc,
          listener: (context, state) {
            debugPrint('homeRootBloc ${authBloc.state.currentUser?.role} ${state.index}');
            if (authBloc.state.currentUser?.email == null && state.index == 3) {
              homeRootBloc.add(HomeRootEventSelectedIndex(index: 0));
              Navigator.of(context).pushNamed(LoginScreen.routeName);
              GFToast.showToast('Anda harus login terlebih dahulu.', context,
                  toastPosition: GFToastPosition.BOTTOM);
            }
          },
          builder: (context, rootState) {
            return BlocConsumer<AuthBloc, AuthState>(
              bloc: authBloc,
              listener: (context, state) {
                debugPrint('AuthBloc ${state.currentUser?.role} ${homeRootBloc.state.index}');
                if (state.currentUser?.email == null &&
                    homeRootBloc.state.index == 3) {
                  homeRootBloc.add(HomeRootEventSelectedIndex(index: 0));
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                  GFToast.showToast(
                      'Anda harus login terlebih dahulu.', context,
                      toastPosition: GFToastPosition.BOTTOM);
                }
              },
              builder: (context, authState) {
                return BlocConsumer<ProfileBloc, ProfileState>(
                  bloc: bloc,
                  listener: (context, state) {
                    _refreshController.refreshCompleted();
                    _refreshController.loadComplete();
                  },
                  builder: (context, state) {
                    return SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: _refreshController,
                      onRefresh: () {
                        authBloc.add(AuthEventGetCurrentUser());
                        _refreshController.refreshCompleted();
                        _refreshController.loadComplete();
                      },
                      child: Wrapper(
                        state: NetworkStates.onLoaded,
                        onLoading: SafeArea(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: GFShimmer(
                              child: Column(
                                children: [
                                  for (var i = 0; i < 5; i++)
                                    Column(
                                      children: [
                                        loadingBlock(dimension),
                                        Spaces.normalVertical()
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        onLoaded: CustomScrollView(
                          slivers: <Widget>[
                            SliverAppBar(
                              pinned: true,
                              snap: false,
                              floating: true,
                              expandedHeight: 300.0,
                              backgroundColor: MyColors.primary,
                              flexibleSpace: FlexibleSpaceBar(
                                title: Text(
                                  "${authState.currentUser?.name}",
                                  style: TextStyle(
                                    color: MyColors.white,
                                    fontWeight: MyFontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                background: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://weddingmarket.com/storage/images/artikelidea/c66afbcc39555a48c1ec3a7f4a300be3a3401b32.webp'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: _body(context, authState),
                            ),
                          ],
                        ),
                        onError: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              authState.message ?? 'Unknown Error',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, state) {
    final dimension = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              // color: MyColors.greyPlaceHolder,
              border: Border.all(color: MyColors.white, width: 0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Akun",
                  style: TextStyle(
                      color: MyColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                _itemWidget(
                  value: state.currentUser?.email,
                  key: 'Email',
                ),
                _itemWidget(value: state.currentUser?.telp, key: 'Telp'),
                Spaces.smallVertical(),
                Text(
                  "Settings",
                  style: TextStyle(
                      color: MyColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                _menuWidget(
                    icon: Icons.lock_open, text: 'Ubah Password', onTap: () {}),
                _menuWidget(
                    icon: Icons.logout,
                    text: 'Logout',
                    onTap: () {
                      // homeRootBloc.add(HomeRootEventSelectedIndex(index: 0));
                      authBloc.add(AuthEventOnLogout());
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemWidget({value: '-', key: '-', onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: MyColors.greyLight, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value ?? '-',
                  style: TextStyle(
                    color: MyColors.text,
                    fontWeight: MyFontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  key ?? '-',
                  style: TextStyle(
                    color: MyColors.text,
                    fontWeight: MyFontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            onTap != null
                ? Icon(
                    Icons.keyboard_arrow_right,
                    color: MyColors.text,
                    size: 30,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _menuWidget({icon: Icons.redo, text: '-', onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: MyColors.greyLight, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 26,
                  color: MyColors.text,
                ),
                Spaces.smallHorizontal(),
                Text(
                  text,
                  style: TextStyle(
                    color: MyColors.text,
                    fontWeight: MyFontWeight.normal,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: MyColors.text,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
