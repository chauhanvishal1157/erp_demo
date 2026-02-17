import 'package:flutter/material.dart';

import 'common_decoration.dart';

class CommonListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;


  const CommonListTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: EdgeInsets.only(top: 15,left: 15,right: 15),
        decoration: CommonDecorations.card(),
        child: Row(
          children: [
            /// Left Icon
            Container(
              padding:  EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),

            const SizedBox(width: 15),

            /// Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.keyboard_arrow_right_outlined,
                color: color,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
