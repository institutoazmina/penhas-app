import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

abstract class ITweetController {
  Future<void> like(TweetEntity tweet);
  Future<void> reply(TweetEntity tweet);
  Future<void> delete(TweetEntity twee);
  Future<void> report(TweetEntity twee);
}

class TweetController implements ITweetController {
  final FeedUseCases _useCase;

  TweetController({
    @required FeedUseCases useCase,
  }) : _useCase = useCase;

  @override
  Future<void> like(TweetEntity tweet) async {
    if (tweet == null) {
      return;
    }

    if (tweet.meta.liked) {
      await _useCase.unlike(tweet);
    } else {
      await _useCase.like(tweet);
    }
  }

  @override
  Future<void> reply(TweetEntity tweet) async {
    if (tweet == null) {
      return;
    }

    Modular.to.pushNamed('/mainboard/reply', arguments: tweet);
  }

  @override
  Future<void> delete(TweetEntity tweet) async {
    if (tweet == null) {
      return;
    }

    await _useCase.delete(tweet);
  }

  @override
  Future<void> report(TweetEntity tweet) async {
    Modular.to.showDialog(
      builder: (context) {
        TextEditingController _controller = TextEditingController();

        return AlertDialog(
          title: Text('Denunciar'),
          content: TextFormField(
            controller: _controller,
            maxLength: 500,
            maxLines: 5,
            maxLengthEnforced: true,
            decoration: InputDecoration(
                hintText: 'Informe o motivo de denúncia deste post',
                filled: true),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Enviar'),
              onPressed: () async {
                await _useCase.report(tweet, _controller.text);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
