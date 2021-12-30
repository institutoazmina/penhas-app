import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penhas/app/core/extension/asuka.dart';
import 'package:penhas/app/features/feed/domain/entities/tweet_entity.dart';
import 'package:penhas/app/features/feed/domain/usecases/feed_use_cases.dart';

abstract class ITweetController {
  Future<void> like(TweetEntity tweet);
  Future<void> reply(TweetEntity tweet);
  Future<void> delete(TweetEntity tweet);
  Future<void> report(TweetEntity tweet);
  Future<void> detail(TweetEntity tweet);
}

class TweetController implements ITweetController {
  TweetController({
    required FeedUseCases useCase,
  }) : _useCase = useCase;

  final FeedUseCases _useCase;

  @override
  Future<void> like(TweetEntity tweet) async {
    if (tweet.meta.liked) {
      await _useCase.unlike(tweet);
    } else {
      await _useCase.like(tweet);
    }
  }

  @override
  Future<void> reply(TweetEntity tweet) async {
    Modular.to.pushNamed('/mainboard/reply', arguments: tweet);
  }

  @override
  Future<void> delete(TweetEntity tweet) async {
    await _useCase.delete(tweet);
  }

  @override
  Future<void> report(TweetEntity tweet) async {
    return Modular.to.showDialog(
      builder: (context) {
        final TextEditingController _controller = TextEditingController();

        return AlertDialog(
          title: const Text('Denunciar'),
          content: TextFormField(
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            controller: _controller,
            maxLength: 500,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Informe o motivo de denúncia deste post',
              filled: true,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('Enviar'),
              onPressed: () {
                _useCase
                    .report(tweet, _controller.text)
                    .then((value) => Navigator.of(context).pop());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Future<void> detail(TweetEntity tweet) async {
    Modular.to.pushNamed('/mainboard/tweet/${tweet.id}', arguments: tweet);
  }
}
