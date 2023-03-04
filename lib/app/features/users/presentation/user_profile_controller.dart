import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/error/failures.dart';
import '../../authentication/presentation/shared/map_failure_message.dart';
import '../../chat/domain/entities/chat_channel_open_entity.dart';
import '../../chat/domain/usecases/get_chat_channel_token_usecase.dart';
import '../domain/entities/user_detail_entity.dart';
import '../domain/usecases/block_user_usecase.dart';
import '../domain/usecases/report_user_usecase.dart';
import 'user_profile_state.dart';

part 'user_profile_controller.g.dart';

class UserProfileController extends _UserProfileControllerBase
    with _$UserProfileController {
  UserProfileController({
    required UserDetailEntity person,
    required GetChatChannelTokenUseCase getChatChannelToken,
    required ReportUserUseCase reportUser,
    required BlockUserUseCase blockUser,
  }) : super(person, getChatChannelToken, reportUser, blockUser);
}

abstract class _UserProfileControllerBase with Store, MapFailureMessage {
  _UserProfileControllerBase(
    this._person,
    this._getChatChannelToken,
    this._reportUser,
    this._blockUser,
  ) {
    _init();
  }

  final UserDetailEntity _person;
  final GetChatChannelTokenUseCase _getChatChannelToken;
  final BlockUserUseCase _blockUser;
  final ReportUserUseCase _reportUser;

  @observable
  UserProfileState state = const UserProfileState.initial();

  @observable
  UserMenuState menuState = const UserMenuState.hidden();

  @observable
  UserProfileReaction? reaction;

  void _init() {
    state = UserProfileState.loaded(_person);
    menuState = _person.isMyself
        ? const UserMenuState.hidden()
        : const UserMenuState.visible();
  }

  @action
  Future<void> openChannel() async {
    final channel = await _getChatChannelToken(_person.profile.clientId!);
    reaction = channel.fold(_handleFailure, _handleChatChannelSuccess);
  }

  @action
  void onTapMenuOptions() {
    reaction = UserProfileReaction.showProfileOptions();
  }

  @action
  void onOptionSelected(UserProfileSelectedOption? option) {
    reaction = option?.when(
      report: () => UserProfileReaction.askReportReasonDialog(),
      block: () => UserProfileReaction.showBlockConfirmationDialog(
        'Deseja realmente bloquear ${_person.profile.nickname}?',
      ),
    );
  }

  @action
  Future<void> onSendReportPressed(String reason) async {
    reaction = UserProfileReaction.showProgressDialog();
    final result = await _reportUser(
      clientId: '${_person.profile.clientId}',
      reason: reason,
    );
    reaction = result.fold(
      _handleFailure,
      (result) => UserProfileReaction.showSnackBar(
        result.message ?? 'Reportado com sucesso',
      ),
    );
  }

  @action
  Future<void> onConfirmBlockPressed() async {
    reaction = UserProfileReaction.showProgressDialog();
    final result = await _blockUser('${_person.profile.clientId}');
    reaction = result.fold(
      _handleFailure,
      (_) => UserProfileReaction.dismissProgressDialog(),
    );
  }

  UserProfileReaction? _handleChatChannelSuccess(ChatChannelOpenEntity chat) {
    Modular.to.pushReplacementNamed(
      '/mainboard/chat/${chat.token}',
      arguments: chat,
    );
    return null;
  }

  UserProfileReaction? _handleFailure(Failure error) {
    final errorMessage = mapFailureMessage(error);
    return errorMessage != null
        ? UserProfileReaction.showSnackBar(errorMessage)
        : null;
  }
}
