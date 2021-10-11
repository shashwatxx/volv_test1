import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on PlatformException catch (e) {
      log("On Platform Exception ${e.message}");
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      throw e;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<String?> signInwithApple() async {
    try {
      if (await SignInWithApple.isAvailable()) {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
            clientId: '',
            redirectUri: Uri.parse(''),
          ),
        );
        final signInWithAppleEndpoint = Uri(
          scheme: 'https',
          host: 'flutter-sign-in-with-apple-example.glitch.me',
          path: '/sign_in_with_apple',
          queryParameters: <String, String>{
            'code': credential.authorizationCode,
            if (credential.givenName != null)
              'firstName': credential.givenName!,
            if (credential.familyName != null)
              'lastName': credential.familyName!,
            'useBundleId':
                Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
            if (credential.state != null) 'state': credential.state!,
          },
        );

        final session = await http.Client().post(
          signInWithAppleEndpoint,
        );

        // If we got this far, a session based on the Apple ID credential has been created in your system,
        // and you can now set this as the app's session
        log(session.toString());
      }
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      throw e;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signOutFromApple() async {
    await _auth.signOut();
  }
}
