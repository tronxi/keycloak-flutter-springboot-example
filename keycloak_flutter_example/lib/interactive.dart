import 'package:flutter/material.dart';
import 'package:openidconnect/openidconnect.dart';
import 'credentials.dart';

import 'identity_view.dart';

class InteractivePage extends StatefulWidget {
  const InteractivePage({super.key});

  @override
  InteractivePageState createState() => InteractivePageState();
}

class InteractivePageState extends State<InteractivePage> {
  OpenIdConfiguration? discoveryDocument;
  AuthorizationResponse? identity;
  Map<String, dynamic>? userInfo;

  @override
  void initState() {
    OpenIdConnect.getConfiguration(defaultDiscoveryUrl)
        .then((value) => discoveryDocument = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton.icon(
            onPressed: () async {
              try {
                final response = await OpenIdConnect.authorizeInteractive(
                  context: context,
                  title: "",
                  request: await InteractiveAuthorizationRequest.create(
                    clientId: defaultClientId,
                    redirectUrl: defaultRedirectUrl,
                    scopes: defaultscopes,
                    configuration: discoveryDocument!,
                    autoRefresh: true,
                    useWebPopup: true,
                  ),
                );
                final userInfo = await OpenIdConnect.getUserInfo(
                    request: UserInfoRequest(
                        accessToken: response!.accessToken,
                        configuration: discoveryDocument!));
                setState(() {
                  identity = response;
                  this.userInfo = userInfo;
                });
              } on Exception {
                setState(() {
                  identity = null;
                });
              }
            },
            icon: const Icon(Icons.login),
            label: const Text("Login"),
          ),
          Visibility(
            visible: identity != null,
            child: TextButton.icon(
              onPressed: () async {
                try {
                  final response = await OpenIdConnect.refreshToken(
                      request: RefreshRequest(
                          clientId: defaultClientId,
                          scopes: defaultscopes,
                          refreshToken: identity!.refreshToken!,
                          configuration: discoveryDocument!));
                  setState(() {
                    identity = response;
                  });
                } on Exception {
                  setState(() {
                    identity = null;
                  });
                }
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Refresh"),
            ),
          ),
          Visibility(
            visible: identity != null,
            child: identity == null ? Container() : IdentityView(identity!, userInfo!),
          ),
          Visibility(
            visible: identity != null,
            child: TextButton.icon(
              onPressed: () async {
                OpenIdConnect.logout(
                  request: LogoutRequest(
                    idToken: identity!.idToken,
                    configuration: discoveryDocument!,
                  )
                );
                setState(() {
                  identity = null;
                });
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }
}
