import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'video_player_page.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SearchVideo extends StatefulWidget {
  const SearchVideo({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchVideo> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _videoResult = [];
  bool _isLoading = false;
  double _downloadProgress = 0.0;
  bool _downloading = false;
  CancelToken? _cancelToken;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _searchMusic(String query) async {
    setState(() {
      _isLoading = true;
    });

    final url = 'https://youtube-music6.p.rapidapi.com/ytmusic/?query=$query';
    final headers = {
      'X-RapidAPI-Key': '798380edccmsh58901f2e0846a5ep1050d2jsnb4f483a8177d',
      'X-RapidAPI-Host': 'youtube-music6.p.rapidapi.com'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _videoResult = data ?? [];
        });
      } else {
        setState(() {
          _videoResult = [];
        });
        print('Error: ${response.reasonPhrase}');
      }
    } catch (error) {
      setState(() {
        _videoResult = [];
      });
      print('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _downloadFile(String videoUrl, String fileName, BuildContext context, int index) async {
    setState(() {
      _videoResult[index]['isDownloading'] = true;
      _downloading = true;
      _downloadProgress = 0.0;
      _cancelToken = CancelToken();
    });

    final storageStatus = await Permission.storage.request();
    if (!storageStatus.isGranted) {
      print('Permission denied');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permission required'),
            content: Text('This app needs storage permission to download files.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
              ),
            ],
          );
        },
      );
      setState(() {
        _videoResult[index]['isDownloading'] = false;
        _downloading = false;
      });
      return;
    }

    final directory = await getExternalStorageDirectory();
    final downloadDirectory = Directory('/storage/emulated/0/Download');
    if (!(await downloadDirectory.exists())) {
      await downloadDirectory.create(recursive: true);
    }
    final finalVideoPath = path.join(downloadDirectory.path, '$fileName.mp3');

    try {
      final url = 'https://youtube-mp3-downloader2.p.rapidapi.com/ytmp3/ytmp3/';
      final headers = {
        'X-RapidAPI-Key': '0e5c7f9c21msh2abe22a023d60d8p1c80d7jsn0de3dc0d8b14',
        'X-RapidAPI-Host': 'youtube-mp3-downloader2.p.rapidapi.com'
      };
      final params = {'url': videoUrl};

      final response = await http.get(Uri.parse(url).replace(queryParameters: params), headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final downloadUrl = jsonResponse['dlink'];
        print(downloadUrl);

        if (downloadUrl == null) {
          throw Exception('Download URL is null');
        }

        Dio dio = Dio();

        await dio.download(
          downloadUrl,
          finalVideoPath,
          onReceiveProgress: (received, total) {
            setState(() {
              _downloadProgress = received / total;
            });
          },
          cancelToken: _cancelToken, // Use cancel token for download cancellation
        );

        print('File downloaded to: $finalVideoPath');
        _showNotification(fileName);
      } else {
        throw Exception('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      if (e is DioException && CancelToken.isCancel(e)) {
        print('Download canceled');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Download Error'),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } finally {
      setState(() {
        _videoResult[index]['isDownloading'] = false;
        _downloading = false;
        _cancelToken = null;
      });
    }
  }

  void _showNotification(String fileName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Download completed: $fileName'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Search",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
              children: [
          Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.black,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        _searchMusic(_searchController.text);
                      },
                    ),
                  ),
                  onSubmitted: (_) {
                    _searchMusic(_searchController.text);
                  },
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        if (_isLoading)
    Expanded(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green), // Neon green color
        ),
      ),
    )
    else
    Expanded(
    child: ListView.builder(
    itemCount: _videoResult.length,
      itemBuilder: (context, index) {
        final video = _videoResult[index];
        final title = video['title'] ?? 'No title';
        final artists = (video['artists'] as List?)
            ?.map((artist) => artist['name'] as String?)
            .where((name) => name != null)
            .join(', ') ?? 'Unknown artist';
        final thumbnails = video['thumbnails'] as List?;
        final thumbnailUrl = thumbnails != null && thumbnails.isNotEmpty
            ? thumbnails[0]['url'] as String? ?? ''
            : '';
        final videoId = video['videoId'] as String?;
        final streamingUrl = 'https://www.youtube.com/watch?v=$videoId';

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          padding: EdgeInsets.all(8.0),
          color: Colors.black87,
          child: Column(
            children: [
              if (thumbnailUrl.isNotEmpty)
                Image.network(
                  thumbnailUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ListTile(
                title: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  artists,
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.play_arrow, color: Colors.white),
                      onPressed: () {
                        if (videoId != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerPage(videoId: videoId),
                            ),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.download, color: Colors.white),
                      onPressed: () {
                        if (videoId != null) {
                          _downloadFile(streamingUrl, title, context, index);
                        }
                      },
                    ),
                  ],
                ),
              ),
              if (_videoResult[index]['isDownloading'] == true)
                LinearProgressIndicator(
                  value: _downloadProgress,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
            ],
          ),
        );
      },
    ),
    ),
              ],
          ),
        ),
    );
  }
}
