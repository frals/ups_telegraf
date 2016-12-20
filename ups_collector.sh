#!/bin/sh

print_influx_line() {
    echo "ups,host=gatekeeper.frals.int,ups=gatekeeper $1=$2"
}

INPUT_DATA=$(/bin/upsc ups@gatekeeper.frals.int:3493)

VOLTAGE=$(echo "$INPUT_DATA" | grep 'input.voltage:'|awk '{print $2}')
BATTERY_CHARGE=$(echo "$INPUT_DATA" | grep 'battery.charge:'|awk '{print $2}')
BATTERY_RUNTIME=$(echo "$INPUT_DATA" | grep 'battery.runtime:'|awk '{print $2}')
BATTERY_VOLTAGE=$(echo "$INPUT_DATA" | grep 'battery.voltage:'|awk '{print $2}')
UPS_LOAD=$(echo "$INPUT_DATA" | grep 'ups.load'|awk '{print $2}')
UPS_STATUS=$(echo "$INPUT_DATA" | grep 'ups.status'|awk '{print $2}')
UPS_STATUS="\"${UPS_STATUS}\""

print_influx_line "involtage" $VOLTAGE
print_influx_line "charge" $BATTERY_CHARGE
print_influx_line "runtime" $BATTERY_RUNTIME
print_influx_line "voltage" $BATTERY_VOLTAGE
print_influx_line "load" $UPS_LOAD
print_influx_line "status" $UPS_STATUS
