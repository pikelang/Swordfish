#!/bin/sh
make spotless
pike -x module --all
pike -x module testsuite
pike -x module verbose_verify
