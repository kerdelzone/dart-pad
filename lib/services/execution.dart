// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library execution;

import 'dart:async';

class TestResult {
  const TestResult(this.success, this.message);
  final bool success;
  final String message;
}

abstract class ExecutionService {
  Future execute(String html, String css, String javaScript);

  void replaceHtml(String html);
  void replaceCss(String css);

  /// Destroy the iframe; stop any currently running scripts. The iframe will be
  /// available to be re-used again.
  Future tearDown();

  Stream<String> get onStdout;
  Stream<String> get onStderr;
  Stream<TestResult> get testResults;

  /// This method should be added to any Dart code that needs to report a test
  /// result while executing via this service. It calls `print` with a specially
  /// constructed string, which is caught by the `dartPrint` method and routed
  /// to [testResults] rather than the [onStdout] stream.
  String get testResultDecoration;
}
