import 'package:flutter_siap_nikah/src/commons/spaces.dart';
import 'package:flutter_siap_nikah/src/features/profile/bloc/profile/profile_bloc.dart';
import 'package:flutter_siap_nikah/src/features/search/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siap_nikah/src/styles/my_colors.dart';
import 'package:flutter_siap_nikah/src/styles/my_font_weight.dart';
import 'package:flutter_siap_nikah/src/widgets/general.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc bloc = ProfileBloc();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;

    return BlocProvider(
      create: (BuildContext context) => ProfileBloc(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: true,
              expandedHeight: 300.0,
              backgroundColor: MyColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Aku nama",
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
            SliverToBoxAdapter(child: _body(context)),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
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
                _itemWidget(value: 'bloc.user.email', key: 'Email', onTap: () {}),
                _itemWidget(
                    value: '0838912900067', key: 'No Telp', onTap: () {}),
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
                    icon: Icons.logout, text: 'Logout', onTap: (){}),
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
