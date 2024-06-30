#!/bin/bash

flutter test --coverage
lcov --remove coverage/lcov.info 'lib/generated/*' -o coverage/new_lcov.info
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html