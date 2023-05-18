const defaultDiscoveryUrl =
    "https://tronxi.ddns.net/auth/realms/keycloak-example/.well-known/openid-configuration";
const defaultClientId = "flutter";
const defaultRedirectUrl = "http://localhost:49430/callback.html";
final defaultscopes = [
  "openid",
  "profile",
  "email",
  "address",
  "offline_access"
];