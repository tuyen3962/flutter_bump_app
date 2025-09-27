extension ListExtension<E> on List<E> {
  bool isSameList(List<E> items) {
    if (this.length != items.length) return false;
    for (var i = 0; i < length; i++) {
      if (this[i] != items[i]) return false;
    }

    return true;
  }
}
