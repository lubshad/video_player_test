import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';

class ActionSection extends StatelessWidget {
  const ActionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            child: const Icon(CupertinoIcons.chevron_back),
            onTap: () {},
          ),
          CustomIconButton(
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.arrowtriangle_down_fill,
                    color: screaminGreen,
                  ),
                  Text(
                    "Download",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 16),
                  ),
                  defaultSpacerHorizontalSmall
                ],
              ),
              onTap: () {}),
          CustomIconButton(
            child: const Icon(CupertinoIcons.chevron_forward),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
