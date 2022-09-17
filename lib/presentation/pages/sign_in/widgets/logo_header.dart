import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/values/assets.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return ClipPath(
      clipper: _LogoHeaderClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 42 + mediaQueryData.padding.top, bottom: 72),
        color: theme.primaryColor,
        child: SvgPicture.asset(
          Assets.iconLogo,
          width: 72,
          height: 72,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _LogoHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double cutoutSize = size.height / 6;

    return Path()
      ..moveTo(0, size.height)
      ..cubicTo(
        0,
        size.height,
        0,
        size.height - cutoutSize,
        cutoutSize,
        size.height - cutoutSize,
      )
      ..lineTo(size.width, size.height - cutoutSize)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
