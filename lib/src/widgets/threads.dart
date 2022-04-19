part of 'widgets.dart';

class Threads extends StatelessWidget {
  const Threads({
    Key? key,
    this.onTap,
    this.isDetail = false,
    this.isChild = false,
    this.scrollToTop,
    this.onLoading,
    this.onLoaded,
    this.onError,
  }) : super(key: key);

  final bool isDetail;
  final bool isChild;
  final Function()? onTap;
  final Function()? scrollToTop;
  final Widget? onLoading;
  final Widget? onLoaded;
  final Widget? onError;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.only(bottom: 2, top: 6),
          decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: MyColors.text, width: 0.2)),
          ),
          child: isDetail ? _detail() : _thread()),
    );
  }

  Widget _thread() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          child: GFAvatar(
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png'),
            // size: 20,
            backgroundColor: MyColors.background,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spaces.smallVertical(),
              Row(
                children: [
                  Text('Nama user', style: MyTextStyle.h5.bold),
                  Spaces.smallHorizontal(),
                  Text(
                    '@username · 7h',
                    style: MyTextStyle.contentDescription,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  'ada yang punya pdf mengenai Qualitative research ngga? Yang enak buat di resensi yang ada silakan tinggalkan jejak di reply ya terimakasih sebelumnya 🙏',
                  style: MyTextStyle.h5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: null,
                        icon: Row(
                          children: [
                            Icon(Icons.mode_comment_outlined, size: 16),
                            Spaces.smallHorizontal(),
                            Text(
                              '1',
                              style: MyTextStyle.contentDescription,
                            ),
                          ],
                        ),
                      ),
                      Spaces.normalHorizontal(),
                      IconButton(
                        onPressed: () {
                          debugPrint('Fav');
                        },
                        icon: Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 16,
                              color: Colors.black38,
                            ),
                            Spaces.smallHorizontal(),
                            Text(
                              '1',
                              style: MyTextStyle.contentDescription,
                            ),
                          ],
                        ),
                      ),
                      Spaces.normalHorizontal(),
                      IconButton(
                        onPressed: () {
                          debugPrint('Share');
                        },
                        icon: Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              size: 16,
                              color: Colors.black38,
                            ),
                            Spaces.smallHorizontal(),
                            Text(
                              '1',
                              style: MyTextStyle.contentDescription,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  isChild
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: scrollToTop,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward_rounded,
                                  size: 16,
                                  color: MyColors.textContent,
                                ),
                                Spaces.smallHorizontal(),
                                Text(
                                  'menuju utas',
                                  style: MyTextStyle.contentDescription,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _detail() {
    return Container(
      padding: EdgeInsets.only(top: 14, left: 14, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GFAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png'),
                backgroundColor: MyColors.background,
              ),
              Spaces.normalHorizontal(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama user', style: MyTextStyle.h5.bold),
                  Text(
                    '@username',
                    style: MyTextStyle.contentDescription,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spaces.normalVertical(),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  'ada yang punya pdf mengenai Qualitative research ngga? Yang enak buat di resensi yang ada silakan tinggalkan jejak di reply ya terimakasih sebelumnya 🙏',
                  style: MyTextStyle.h4,
                ),
              ),
              Spaces.normalVertical(),
              Text(
                '19.30 · 19.04/22',
                style: MyTextStyle.contentDescription,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: MyColors.text, width: 0.2),
                    bottom: BorderSide(color: MyColors.text, width: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          '1',
                          style: MyTextStyle.h7.bold,
                        ),
                        Spaces.smallHorizontal(),
                        Text('Komentar', style: MyTextStyle.h7),
                      ],
                    ),
                    Spaces.normalHorizontal(),
                    Row(
                      children: [
                        Text(
                          '1',
                          style: MyTextStyle.h7.bold,
                        ),
                        Spaces.smallHorizontal(),
                        Text('Menyukai', style: MyTextStyle.h7),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: null,
                        icon: Row(
                          children: [
                            Icon(Icons.mode_comment_outlined, size: 16),
                            Spaces.smallHorizontal(),
                            Text(
                              '1',
                              style: MyTextStyle.contentDescription,
                            ),
                          ],
                        ),
                      ),
                      Spaces.normalHorizontal(),
                      IconButton(
                        onPressed: () {
                          debugPrint('Fav');
                        },
                        icon: Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 16,
                              color: Colors.black38,
                            ),
                            Spaces.smallHorizontal(),
                            Text(
                              '1',
                              style: MyTextStyle.contentDescription,
                            ),
                          ],
                        ),
                      ),
                      Spaces.normalHorizontal(),
                      IconButton(
                        onPressed: () {
                          debugPrint('Share');
                        },
                        icon: Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              size: 16,
                              color: Colors.black38,
                            ),
                            Spaces.smallHorizontal(),
                            Text(
                              '1',
                              style: MyTextStyle.contentDescription,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
