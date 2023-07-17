import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/chat_main_tile_entity.dart';

part 'chat_main_talks_state.freezed.dart';

@freezed
class ChatMainTalksState with _$ChatMainTalksState {
  const factory ChatMainTalksState.initial() = _Initial;
  const factory ChatMainTalksState.loading() = _Loading;
  const factory ChatMainTalksState.loaded(List<ChatMainTileEntity> tiles) =
      _Loaded;
  const factory ChatMainTalksState.error(String message) = _ErrorDetails;
}
