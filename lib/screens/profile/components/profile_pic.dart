
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -50,
            bottom: 17,
            child: SizedBox(
              height: 200,
              width: 200,
              child: CircleAvatar(
                // backgroundImage: AssetImage("assets/images/user.png"),
                // backgroundColor: kbackgroundImageProfile,
              ),
            ),
          )
        ],
      ),
    );
  }
}
  