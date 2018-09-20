#!/bin/sh

export LOCAL_IF="vtnet0"
export LOCAL_MAC="58:9c:fc:0e:e9:36"
export REMOTE_MAC="58:9c:fc:0e:2f:00"
export LOCAL_ADDR6="2001:638:501:4ef4:5a9c:fcff:fe0e:e936"
export REMOTE_ADDR6="2001:638:501:4ef4:5a9c:fcff:fe0e:2f00"

function run_scapy_test_suite {
	TEST_SUITE=$1
	ADDR_FILE=$TEST_SUITE/addr.py

	[ -f $ADDR_FILE ] && rm $ADDR_FILE
	touch $ADDR_FILE

	echo "LOCAL_IF = '${LOCAL_IF}'" >> $ADDR_FILE
	echo "LOCAL_MAC = '${LOCAL_MAC}'" >> $ADDR_FILE
	echo "REMOTE_MAC = '${REMOTE_MAC}'" >> $ADDR_FILE
	echo "LOCAL_ADDR6 = '${LOCAL_ADDR6}'" >> $ADDR_FILE
	echo "REMOTE_ADDR6 = '${REMOTE_ADDR6}'" >> $ADDR_FILE


	for script in $TEST_SUITE/*.py; do
		OUTPUT="$(python2 $script)"
		if [ $? -eq 0 ]; then
			echo "$script: PASSED"
		else
			echo "$script: FAILED with exit code $?"
			echo $OUTPUT
        	fi
	done
}
run_scapy_test_suite regress/frag6
run_scapy_test_suite regress/rh0
