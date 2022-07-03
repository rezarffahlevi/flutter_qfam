part of 'widgets.dart';

enum NetworkStates {
  onLoading,
  onLoaded,
  onError,
  onEmpty,
}

Widget sectionWidget(text, {child, showAll = true, onTapAll}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: onTapAll,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Text(text, style: MyTextStyle.contentTitle)),
              Spaces.smallHorizontal(),
              showAll
                  ? Row(
                      children: [
                        Text(
                          "Lihat semua",
                          style: MyTextStyle.sessionTitle
                              .copyWith(color: MyColors.primary),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: MyColors.primary,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      Spaces.smallVertical(),
      child,
      Spaces.normalVertical(),
    ],
  );
}

Widget renderContent(state, {onLoading, onLoaded, onError}) {
  if (state == NetworkStates.onLoading) {
    return onLoading;
  } else if (state == NetworkStates.onLoaded) {
    return onLoaded;
  } else {
    return onError;
  }
}

Widget loadingBlock(dimension) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 54,
          height: 46,
          color: Colors.white,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 8,
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              Container(
                width: dimension.width * 0.5,
                height: 8,
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              Container(
                width: dimension.width * 0.25,
                height: 8,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

AppBar appBar(
    {child,
    onTapBack: null,
    onTap: null,
    icon: Icons.notifications,
    fontFamily: null}) {
  return AppBar(
    backgroundColor: MyColors.primary,
    leading: InkWell(
      child: Container(
          padding: const EdgeInsets.all(10.0),
          child: onTapBack != null
              ? BackButton(
                  onPressed: onTapBack,
                )
              : GFAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png'),
                  size: 20,
                  backgroundColor: MyColors.background,
                )),
      onTap: () {},
    ),
    centerTitle: fontFamily == null ? false : true,
    title: (child == null || child is String)
        ? Text(
            child ?? AppSettings.name,
            style: MyTextStyle.appBarTitle.copyWith(
                color: MyColors.textReverse,
                fontWeight: MyFontWeight.bold,
                fontFamily: fontFamily),
          )
        : child,
    actions: [
      onTap == null
          ? Container()
          : InkWell(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                child: icon.runtimeType == IconData ? Icon(
                  icon,
                  color: MyColors.textReverse,
                  size: 24,
                ) : icon,
              ),
              onTap: onTap,
            ),
    ],
  );
}
