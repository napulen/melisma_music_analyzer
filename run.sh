#!/bin/bash
bin/tsroot --meldir $MELISMA/bin --midir $HUMEXTRA/bin --roman $1 2>/dev/null > /tmp/rna.krn
$HUMDRUM/bin/assemble $1 /tmp/rna.krn
