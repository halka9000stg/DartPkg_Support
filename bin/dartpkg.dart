import 'dart:io';
import 'package:shell/shell.dart';
import "package:dartpkg_support/srcm.dart";

void main(List<String> args) async {
  Shell shell = new Shell();
  PkgRefTab env = PkgRefTab.withIn();
  List<String> direct = ["analyze","compile","create","fix","format","migrate","pub","run","test"];
  List<String> pub = ["add", "cache", "deps","downgrade", "get", "global", "login", "logout", "outdated", "publish", "remove", "upgrade", "uploader"];
  List<String> own = ["init","del","where","go","move"];
  CmdClassCtl ctl = CmdClassCtl.init();
  ctl.add("own",own);
  ctl.add("pub",pub);
  ctl.add("direct",direct);
  void Function(List<String>,CmdClassCtl) goer = (List<String> args, CmdClassCtl ctlr){
    String path = args[0];
    ctlr.hook("go", [path]);
  };
  //ctl.addHandler("own","init",);
  //ctl.addHandler("own","del",);
  //ctl.addHandler("own","where",);
  //ctl.addHandler("own","go",);
  //ctl.addHandler("own","move",);
  //ctl.addHandler("2","move",);

  print(args);
  ctl.logger=print;
  String cmd = args[0];
  ctl.showCatFromCmd(cmd);
  String cat = ctl.catFromCmd(cmd);
  List<String> args2 = List.from(args);
  switch(cat){
    case "pub":
      args2.insert(0,"pub");
      String echo = await shell.startAndReadAsString("dart", arguments: args2);
      print(echo);
      break;
    case "direct":
      String echo = await shell.startAndReadAsString("dart", arguments: args2);
      print(echo);
      break;
    case "own":
      break;
    default:
      break;
  }
}
