import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/composite_disposable.dart';
import '../../../domain/data_channels/message_data_channel.dart';
import '../../../domain/models/message/message.dart';
import '../../../domain/models/message/message_wrapper.dart';
import 'events/event_message.dart';

@injectable
class RealtimeDataBroadcastCubit extends Cubit<Unit> with CompositeDisposable<Unit> {
  RealtimeDataBroadcastCubit(
    this._messageDataChannel,
    this._eventBus,
  ) : super(unit);

  final MessageDataChannel _messageDataChannel;
  final EventBus _eventBus;

  Future<void> init() async {
    _messageDataChannel.startListening();
    addSubscription(_messageDataChannel.events.listen((Message event) =>
        _eventBus.fire(EventMessage.received(MessageWrapper.fromMessage(event)))));
  }

  @override
  Future<void> close() {
    _messageDataChannel.stopListening();

    return super.close();
  }
}
