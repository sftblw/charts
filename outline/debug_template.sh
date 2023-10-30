#!/bin/bash
helm template test-chart . -f values.yaml -f values_my.yaml --debug > debug_template_result.yaml