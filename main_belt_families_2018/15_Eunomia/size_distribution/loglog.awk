#!/usr/bin/gawk -f

!/^#/{
  print log10($1), log10($2);
}

function log10(x) {
  return log(x)/log(10);
}

