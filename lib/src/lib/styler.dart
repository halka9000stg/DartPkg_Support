enum PkgName{
  com,
  org,
  any,
}
bool isPathSty(String pathCrd){
  try{
    return Uri.parse(pathCrd).isAbsolute;
  }catch (e){
    return false;
  }
}
bool isPkgSty(String nameCrd,PkgName sty){
  switch(sty){
    case PkgName.com:
      //print("On Com Sty");
      return RegExp(r"([a-zA-Z][a-zA-Z0-9_]+)").fullyMatch(nameCrd);
    case PkgName.org:
      //print("On Org Sty");
      return RegExp(r"([a-z][a-z0-9_]+)").fullyMatch(nameCrd);
    case PkgName.any:
      //print("On Any Sty");
      return (isPkgSty(nameCrd,PkgName.com))||(isPkgSty(nameCrd,PkgName.org));
  }
}
extension FullyMatch on RegExp{
  bool fullyMatch(String input){
    //print("HasMach on \"$input\": ${this.hasMatch(input)}");
    if(this.hasMatch(input)){
      Iterable<RegExpMatch> am = this.allMatches(input);
      //print("RegExpMatch len on \"$input\": ${am.length}");
      if(am.length>0){
        //print("Now: do map RegExpMatch to bool");
        return am.map<bool>((RegExpMatch rem){
          //print("Count for \"$input\": ${rem.groupCount}");
          Iterable<String> gn = rem.groupNames;
          //print("NamedGroup for \"$input\": ${gn.length}");
          List<int> gi = List<int>.generate(rem.groupCount+1, (int index)=>index).where((int elm)=>elm>0).toList();
          String? se = rem.group(0);
          //print("group(0)=${se}");
          Iterable<bool> sm = rem.groups(gi).map<bool>((String? sr){
            if(sr == null){
              return false;
            }else{
              //print("IsMachLen on \"$input\": ${sr.length}==${input.length}: ${sr.length == input.length}");
              return sr.length == input.length;
            }
          });
          if(sm.length>0){
            return sm.reduce((bool curr, bool prev)=>prev||curr);
          }
          return false;
        }).reduce((bool curr, bool prev)=>prev||curr);
      }
      return false;
    }
    return false;
  }
}