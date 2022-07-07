part of 'widgets.dart';

class Threads extends StatelessWidget {
  const Threads({
    Key? key,
    this.name,
    this.content,
    this.image,
    this.countComments,
    this.countLikes,
    this.onTap,
    this.isDetail = false,
    this.isChild = false,
    this.isAnonymous = false,
    this.isVerified = false,
    this.isLiked = false,
    this.createdAt,
    this.onTapParent,
    this.onTapComment,
    this.onTapLike,
    this.onTapShare,
  }) : super(key: key);

  final String? name;
  final String? content;
  final String? image;
  final int? countComments;
  final int? countLikes;
  final bool isDetail;
  final bool isChild;
  final bool isAnonymous;
  final bool isVerified;
  final bool isLiked;
  final String? createdAt;
  final Function()? onTap;
  final Function()? onTapParent;
  final Function()? onTapComment;
  final Function()? onTapLike;
  final Function()? onTapShare;
  

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
                  Text(
                    isAnonymous ? 'Nama disamarkan' : name ?? '-',
                    style: MyTextStyle.h5.bold.copyWith(
                        decoration: isAnonymous
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  Spaces.smallHorizontal(),
                  isVerified && !isAnonymous
                      ? Icon(
                          Icons.verified_outlined,
                          color: MyColors.primary,
                          size: 18,
                        )
                      : Container(),
                  Spaces.smallHorizontal(),
                  Text(
                    '· ${isVerified && !isAnonymous ? 'Edukator' : ''}',
                    style: MyTextStyle.contentDescription,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 6),
                child: Text(
                  '${content}',
                  style: MyTextStyle.h5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Helpers.isEmpty(image)
                    ? Container()
                    : GFImageOverlay(
                        color: MyColors.greyPlaceHolder,
                        height: 120,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        image: NetworkImage(AppSettings.getConfig.BASE_URL +
                            'storages/' +
                            image!.replaceFirstMapped('.', (match) => '/')),
                        boxFit: BoxFit.cover,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: onTapComment,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              Icon(Icons.mode_comment_outlined, size: 16,
                                color:Colors.black38,
                              ),
                              Spaces.smallHorizontal(),
                              Text(
                                '${countComments ?? '0'}',
                                style: MyTextStyle.contentDescription,
                              ),
                              Spaces.normalHorizontal(),
                            ],
                          ),
                        ),
                      ),
                      Spaces.normalHorizontal(),
                      InkWell(
                        onTap: onTapLike,
                        child: Row(
                          children: [
                            Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              size: 16,
                              color:
                                  isLiked ? MyColors.primary : Colors.black38,
                            ),
                            Spaces.smallHorizontal(),
                            Text(
                              '${countLikes ?? '0'}',
                              style: MyTextStyle.contentDescription,
                            ),
                            Spaces.normalHorizontal(),
                          ],
                        ),
                      ),
                      Spaces.normalHorizontal(),
                      InkWell(
                        onTap: onTapShare,
                        child: Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              size: 16,
                              color: Colors.black38,
                            ),
                            Spaces.smallHorizontal(),
                            Text(
                              '',
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
                            onTap: onTapParent,
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
                  Row(
                    children: [
                      Text(
                        isAnonymous ? 'Nama disamarkan' : name ?? '-',
                        style: MyTextStyle.h5.bold.copyWith(
                            decoration: isAnonymous
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      Spaces.smallHorizontal(),
                      isVerified && !isAnonymous
                          ? Icon(
                              Icons.verified_outlined,
                              color: MyColors.primary,
                              size: 18,
                            )
                          : Container(),
                    ],
                  ),
                  Text(
                    '${isVerified && !isAnonymous ? 'Edukator' : ''}',
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
                padding: const EdgeInsets.only(right: 8, bottom: 6),
                child: Text(
                  '${content}',
                  style: MyTextStyle.h4,
                ),
              ),
              Helpers.isEmpty(image)
                  ? Container()
                  : GFImageOverlay(
                      color: MyColors.greyPlaceHolder,
                      height: 120,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      image: NetworkImage(AppSettings.getConfig.BASE_URL +
                          'storages/' +
                          image!.replaceFirstMapped('.', (match) => '/')),
                      boxFit: BoxFit.cover,
                    ),
              Spaces.normalVertical(),
              Text(
                '${Helpers.formatDateTime(createdAt ?? DateTime.now().toString(), format: 'HH:mm · dd MMMM yyyy')}',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${countComments ?? 0}',
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
                              '${countLikes ?? 0}',
                              style: MyTextStyle.h7.bold,
                            ),
                            Spaces.smallHorizontal(),
                            Text('Menyukai', style: MyTextStyle.h7),
                          ],
                        ),
                      ],
                    ),
                    isChild
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: onTapParent,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_upward_rounded,
                                    size: 16,
                                    color: MyColors.textContent,
                                  ),
                                  Spaces.smallHorizontal(),
                                  Text(
                                    'Lihat balasan',
                                    style: MyTextStyle.h7,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: null,
                        child: Row(
                          children: [
                            Icon(Icons.mode_comment_outlined, size: 16, color: Colors.black38,),
                            Spaces.smallHorizontal(),
                            Text(
                              '${countComments ?? 0}',
                              style: MyTextStyle.contentDescription,
                            ),
                            Spaces.normalHorizontal(),
                          ],
                        ),
                      ),
                      Spaces.normalHorizontal(),
                      InkWell(
                        onTap: onTapLike,
                        child: Row(
                          children: [
                            Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              size: 16,
                              color:
                                  isLiked ? MyColors.primary : Colors.black38,
                            ),
                            Spaces.smallHorizontal(),
                            Text(
                              '${countLikes ?? 0}',
                              style: MyTextStyle.contentDescription,
                            ),
                            Spaces.normalHorizontal(),
                          ],
                        ),
                      ),
                      Spaces.normalHorizontal(),
                      IconButton(
                        onPressed: onTapShare,
                        icon: Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              size: 16,
                              color: Colors.black38,
                            ),
                            Spaces.smallHorizontal(),
                            Text(
                              '',
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
