enum ChatTabItem {
  people,
  talks,
}

extension ChatTabTitle on ChatTabItem {
  String? get title {
    switch (this) {
      case ChatTabItem.people:
        return 'Todas as usuárias';
      case ChatTabItem.talks:
        return 'Conversas';
    }
  }
}
