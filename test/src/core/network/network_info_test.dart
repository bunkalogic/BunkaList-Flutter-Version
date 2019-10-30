

import 'package:bunkalist/src/core/platform/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnetionChecker extends Mock implements DataConnectionChecker{}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnetionChecker mockDataConnetionChecker;

  setUp((){
    mockDataConnetionChecker = MockDataConnetionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnetionChecker);
  });

  group('isConnected', (){
    test(
      'should forward the call to DataConnectionChecker.hasConnection', 
      () async {
        
        // arrange
        final tHasConnectionFuture = Future.value(true);
        when(mockDataConnetionChecker.hasConnection)
            .thenAnswer((_) => tHasConnectionFuture);
        // act
        // NOTICE: We're NOT awaiting the result 
        final result = networkInfoImpl.isConnected;
        // assert
        verify(mockDataConnetionChecker.hasConnection);
        // Utilizing Dart's default referential equality.
        // Only references to the same object are equal.
        expect(result, tHasConnectionFuture);


    });
  });

}