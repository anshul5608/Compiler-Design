#!/bin/bash


EXE="${1:-./lexer}"
TESTDIR="${2:-test}"
SINGLE_FILE="$3"

if [ ! -x "$EXE" ]; then
    echo "Executable '$EXE' not found or not executable. Run 'make' first."
    exit 1
fi

if [ -n "$SINGLE_FILE" ]; then
    "$EXE" "$TESTDIR/$SINGLE_FILE"
    exit $?
fi

if [ ! -d "$TESTDIR" ]; then
    echo "Test directory '$TESTDIR' not found."
    exit 1
fi

status=0
for f in "$TESTDIR"/*; do
    [ -f "$f" ] || continue
    echo
    "$EXE" "$f"
    rc=$?
    if [ $rc -ne 0 ]; then status=$rc; fi
    echo
done

exit $status
