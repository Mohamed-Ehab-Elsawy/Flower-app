import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/requests/send_notification_request.dart';
import 'package:flower_app/core/constants/constants.dart';
import 'package:flower_app/core/error_handling/execute_api.dart';
import 'package:flower_app/core/error_handling/handle_stream_api.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/features/track_order/data/data_source/track_order_data_source.dart';
import 'package:flower_app/features/track_order/domain/entity/active_order_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderDataSource)
class TrackOrderDataSourceImpl implements TrackOrderDataSource {
  final FirebaseFirestore firestore;
  final ApiClient _apiClient;

  TrackOrderDataSourceImpl(this.firestore, this._apiClient);

  @override
  Stream<Result<ActiveOrderEntity>> listenToOrder({required String orderId}) {
    return handleStreamApi(
      () => firestore.collection('active_orders').doc(orderId).snapshots().map((
        snapshot,
      ) {
        if (!snapshot.exists || snapshot.data() == null) {
          return ActiveOrderEntity(orderId: orderId, documentExists: false);
        }
        return ActiveOrderEntity.fromFirestore(snapshot.data()!, orderId);
      }),
    );
  }

  @override
  Future<Result<void>> sendOrderDeliveredNotification({
    required String targetToken,
    required String title,
    required String body,
  }) async {
    final accessToken = await AppLocalStorage.getSecuredString(
      key: AppConstants.fcmAccessToken,
    );
    return executeApi(
      () => _apiClient.sendNotification(
        notificationDto: SendNotificationRequest(
          targetToken: targetToken,
          // title: title,
          // body: body,
          data: {
            'type': 'silent',
          },
        ),
        authorization: 'Bearer $accessToken',
      ),
    );
  }
}
