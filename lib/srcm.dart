import 'package:file/local.dart';
import 'package:file/file.dart';


// Ref Table for Dart Pub Pkg and local Dir Path
class PkgRefTab{
  List<PkgRefBundle> _data = [];
  PkgRefTab.withIn(){
    LocalFileSystem fs = LocalFileSystem();
  }
  void add(PkgRefBundle bund){}
}
// ToDo: シリアライズ書式の確定
class PkgRefBundle{
  String pkgNameAls;
  String pkgNameOrg;
  String path;
  PkgRefBundle(this.pkgNameAls, this.pkgNameOrg, this.path);
  factory PkgRefBundle.parse(String line){
    List<String> delimed = line.split(" ");
    return PkgRefBundle(delimed[0], delimed[1], delimed[2]);
  }
  @override
  String toString() {
    return [this.pkgNameAls, this.pkgNameOrg, this.path].join(" ");
  }
}
enum Hooker{
  before,
  after
}
class CmdClassCtl{
  //Todo: 関数テーブルの作成
  void Function(String) logger = (String nop){};
  List<String> _cats = [];
  Map<String, List<String>> _cmds = {};
  CmdClassCtl.init();
  void add(String cat, List<String> cmds){
    if(this.hasCat(cat)){
      this._cmds.update(cat, (List<String> cmdsE){
        cmdsE.addAll(cmds);
        return cmdsE;
      });
    }else{
      this._cats.add(cat);
      this._cmds.putIfAbsent(cat, ()=>cmds);
    }
  }
  bool hasCat(String cat) => this.cats.where((String catE)=>catE==cat).length > 0;
  bool hasCmd(String cmd,[String? cat]){
    if(cat == null){
      return this.cmds.map<String, bool>((String key, List<String> value)=>MapEntry<String, bool>(key,this.hasCmd(cmd,key))).values.toList().where((bool has)=>has).length > 0;
    }else{
      if(this.hasCat(cat)){
        return this.cmds[cat]!.where((String cmdE)=>cmdE==cmd).length > 0;
    }
      return false;
    }
  }
  String catFromCmd(String cmd){
    int len = this.cats.length;
    for(int i = 0; i < len; i++){
      String ct = this.cats[i];
      if(this.hasCmd(cmd, ct)){
        return ct;
      }
    }
    return "#!nocmd";
  }
  void showCatFromCmd(String cmd){
    String cat = this.catFromCmd(cmd);
    if(cat == "#!nocmd"){
      this.logger("!!No such as cmd: \"$cmd\"");
    }else{
      this.logger("cmd: \"$cmd\"\tcat: \"$cat\"");
    }
  }
  void addHandler(String cat, String cmd, void Function(List<String>,CmdClassCtl) handler){
    if(this.hasCmd(cmd, cat)){
      //Todo: 関数テーブルの関数への追加
    }
  }
  void Function(List<String>,CmdClassCtl) pickHandler(String cat, String cmd){
    void Function(List<String>,CmdClassCtl) nop = (List<String> args,CmdClassCtl ctlr){};
    //Todo: 関数テーブルからの取得
    return nop;
  }
  void hook(String cmd, List<String> args){
    if(this.hasCmd(cmd)){
      String cat = this.catFromCmd(cmd);
      void Function(List<String>,CmdClassCtl) handler = this.pickHandler(cat,cmd);
      handler(args,this);
    }
  }
  List<String> get cats => this._cats;
  Map<String, List<String>> get cmds => this._cmds;
}