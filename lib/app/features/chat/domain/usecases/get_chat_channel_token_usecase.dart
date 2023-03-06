import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../entities/chat_channel_open_entity.dart';
import '../repositories/chat_channel_repository.dart';

@immutable
class GetChatChannelTokenUseCase {
  const GetChatChannelTokenUseCase({
    required IChatChannelRepository repository,
  }) : _repository = repository;

  final IChatChannelRepository _repository;

  Future<Either<Failure, ChatChannelOpenEntity>> call(int clientId) =>
      _repository.openChannel('$clientId');
}
