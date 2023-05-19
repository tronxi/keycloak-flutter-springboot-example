import 'package:flutter/material.dart';
import 'package:openidconnect/openidconnect.dart';
import 'dart:convert' show latin1;
import 'dart:convert' show utf8;

class IdentityView extends StatelessWidget {
  final AuthorizationResponse identity;
  final Map<String, dynamic> userInfo;
  const IdentityView(this.identity, this.userInfo,{super.key});

  @override
  Widget build(BuildContext context) {
    final captionTheme = Theme.of(context).textTheme.bodySmall;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Access Token:",
                  softWrap: true,
                  style: captionTheme,
                ),
                Text(
                  identity.accessToken,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Expires At:",
                  style: captionTheme,
                ),
                Text(
                  identity.expiresAt.toIso8601String(),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Refresh Token:",
                  style: captionTheme,
                ),
                Text(
                  identity.refreshToken ?? "Not included",
                )
              ],
            ),
            ...userInfo.entries.map((entry) => Row(
              children: [
                Text(
                  "${entry.key}: ",
                  style: captionTheme,
                ),
                Text(
                  utf8.decode(latin1.encode(entry.value.toString()))
                )
              ],
            )).toList(),
          ],
        ),
      ),
    );
  }
}