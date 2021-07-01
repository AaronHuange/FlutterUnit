import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_unit/model/github/issue_comment.dart';
import 'package:flutter_unit/model/github/issue.dart';
import 'package:flutter_unit/model/github/repository.dart';
import 'package:flutter_unit/app/utils/Toast.dart';
import 'package:flutter_unit/views/widgets/FiledText.dart';
import 'package:interfacerequest/interfacerequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:

const kBaseUrl = 'http://119.45.173.197:8080/api/v1';

const editBaseUrl = 'http://119.45.173.197:8080/api/v1';

class IssuesApi {
  static Dio dio = Dio(BaseOptions(baseUrl: kBaseUrl));

  static Future<Repository> getRepoFlutterUnit() async {
    Response<dynamic> rep = await dio.get('/repository/name/FlutterUnit');
    dynamic repoStr = rep.data['data']['repositoryData'];
    return Repository.fromJson(json.decode(repoStr));
  }

  static Future<List<Issue>> getIssues(
      {int page = 1, int pageSize = 100}) async {
    List<dynamic> res = (await dio.get('/point',
            queryParameters: {"page": page, "pageSize": pageSize}))
        .data['data'] as List;
    return res.map((e) => Issue.fromJson(json.decode(e['pointData']))).toList();
  }

  static Future<List<IssueComment>> getIssuesComment(int pointId) async {
    List<dynamic> res =
        (await dio.get('/pointComment/$pointId')).data['data'] as List;
    return res
        .map((e) => IssueComment.fromJson(json.decode(e['pointCommentData'])))
        .toList();
  }

  static void upLoadCode(BuildContext context, String code) async {
    String ip = "";
    if (FiledText.IP.isEmpty) {
      var sp = await SharedPreferences.getInstance();
      ip = sp.getString("IP");
    } else {
      ip = FiledText.IP;
    }

    SocketManager.get().load(ip, 16868).send(code, (replay) {
      Toast.toast(context, '代码复制成功:请直接在编辑器中粘贴使用',
          duration: Duration(seconds: 2));
    }, (errorMsg) {
      Toast.toast(context, '代码复制失败: $errorMsg', duration: Duration(seconds: 2));
    });
  }
}
