#!/bin/bash
helm template test-chart . -f values.yaml -f values_debug.yaml --debug > debug_template_result.yaml