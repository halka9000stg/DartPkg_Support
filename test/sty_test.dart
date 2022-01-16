import "package:dartpkg_support/src/lib/styler.dart";
void main(){
  List<String> pathTestCand = [];
  List<String> pkgTestCand = ["like_this_sty","LikeThisSty"];
  testSty(pathTestCand, testPathSty);
  testSty(pkgTestCand, testPkgSty);
}
void testSty(List<String> testStrs, String Function(String) testFn){
  testStrs.forEach((String testStr){
    String res = testFn(testStr);
    print("Test subj.: $testStr\tResult: $res");
  });
}
String testPathSty(String testStr)=>isPathSty(testStr).toString();
String testPkgSty(String testStr)=>[PkgName.com,PkgName.org,PkgName.any].map<String>((PkgName sty)=>isPkgSty(testStr,sty).toString()).join(", ");