import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
final emulatorIp = '10.0.2.2:8000';
final simulatorIp = '127.0.0.1:8000';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;

// final ip = 'ec2-3-38-210-40.ap-northeast-2.compute.amazonaws.com';