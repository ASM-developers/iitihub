import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'dart:convert';
import 'package:http/http.dart' as http;

const CLIENT_ID =
    '710399060234-goduuvh2htd6pomkdpaa1d7cbqa0htn0.apps.googleusercontent.com';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  final GoogleSignIn? googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/gmail.modify'],
    hostedDomain: "",
    clientId: "",
  );

  var code;

  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      // handle error
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((_) async {
      await GoogleSignIn().signOut();
    });
  }

  Future<void> googleLogin() async {
    try {
      final googleUser = await googleSignIn!.signIn();
      if (googleUser == null) return;
      code = googleUser.serverAuthCode;
      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<AuthClient> httpClient() async {
    await googleLogin();

    final client = (await googleSignIn!.authenticatedClient())!;
    // this post request should be able to give you a refreshtoken provided you have a client secret
    //but android does not have a client secret. This is only for web

    // final response = await http.post(
    //   Uri.parse('https://oauth2.googleapis.com/token'),
    //   headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    //   body: {
    //     'code': code!,
    //     'client_id': 'YOUR_CLIENT_ID',
    //     'client_secret': 'YOUR_CLIENT_SECRET',
    //     'redirect_uri': 'YOUR_REDIRECT_URI',
    //     'grant_type': 'authorization_code',
    //   },
    // );

    // final Map<String, dynamic> tokens = jsonDecode(response.body);

    // final refreshToken = tokens['refresh_token'];
    // print(refreshToken);
    // print(client.credentials.refreshToken);
    // final refreshingClient =
    //     autoRefreshingClient(ClientId(CLIENT_ID), client.credentials, client);

    //this thing will grant a new AccessToken given you have a refreshToken
    //http.post to this thing https://oauth2.googleapis.com/token

    // POST /token HTTP/1.1
    // Host: oauth2.googleapis.com
    // Content-Type: application/x-www-form-urlencoded

    // client_id=ClientId(CLIENT_ID)&
    // client_secret=ClientId(CLIENT_ID).secret&
    // refresh_token=refresh_token&
    // grant_type=refresh_token
    return client;
  }
}
