import 'package:cookmaster_front/app/data/models/chatgpt_model.dart';
import 'package:rx_notifier/rx_notifier.dart';

// atoms
final chatsState = RxList<ChatModel>([]);
final chatLoading = RxNotifier(false);

// action
final sendMessageAction = RxNotifier<String>('');
