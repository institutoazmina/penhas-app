enum ChatTabItem {
  people,
  talks
}

extension ChatTabTitle on ChatTabItem {
  String? get title {
    switch (this) {
      case ChatTabItem.people:
        return 'Pessoas';
      case ChatTabItem.talks:
        return 'Conversas';
      default:
        return null;
    }
  }
}
