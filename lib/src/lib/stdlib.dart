extension ListBasicOper<T,E> on List<T> {
  List<E> indexedMap<E>(E Function(int index, T item) function) {
    List<E> list = <E>[];
    this.asMap().forEach((int index, T element) {
      list.add(function(index, element));
    });
    return list;
  }
  List<T> operator +(List<T> other) {
    if(this.length > 0 && other.length > 0){
      if(this.length > other.length){
        T first = other[0];
        List<T> filler = List<T>.generate(this.length+other.length, (int index)=>first);
        other.addAll(filler);
      }
      return this.indexedMap((int ind, T thisEl){
        return thisEl + other[ind];
      }).toList();
    }else{
      return this;
    }
  }
  List<List<T>> operator *(List<T> other) {
    if(this.length > 0 &&other.length > 0){
      List<List<T>> list = <List<T>>[];
      this.indexedMap((int ind, T thisEl){
        int sub = ind - this.length;
        if(sub > 0){
          List<T> filler = List<T>.generate(sub, (int index)=><T>[]);
          list.addAll(filler);
        }
        other.forEach((T otherEl){
          list[ind].add(thisEl * otherEl);
        });
      }).toList();
      return list;
    }else{
      return [this];
    }
  }
}
extension WithListOper<T> on T {
  List<T> operator +(List<T> other) {
    if(other.length > 0){
      return other.map<T>((T otherElm){
        return otherElm + this;
      }).toList();
    }else{
      return other;
    }
  }
  List<T> operator *(List<T> other) {
    if(other.length > 0){
      return other.map<T>((T otherElm){
        return otherElm * this;
      }).toList();
    }else{
      return other;
    }
  }
}