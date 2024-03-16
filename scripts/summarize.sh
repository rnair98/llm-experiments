#!/bin/sh

(
    echo '[INST]Summarize the following test:'
    links -codepage utf-8 \
          -force-html \
          -width 500 \
          -dump https://www.poetryfoundation.org/poems/48860/the-raven | sed 's/   */  /g'
    echo '[INST]'
) | llamafile \
      -m phi-2.Q8_0.gguf \
      -f /dev/stdin \
      -c 0 \
      --temp 0 \
      -n 500 \
      --silent-prompt 2>/dev/null
